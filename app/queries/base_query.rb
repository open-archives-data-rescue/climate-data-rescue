# Responsible for returning a collection of items
# Results can be sorted, filtered, and paginated
require 'ostruct'

class BaseQuery
  attr_reader :total, :collection

  delegate :key, to: :sort, prefix: true
  delegate :key=, to: :sort, prefix: true
  delegate :desc, to: :sort, prefix: true
  delegate :desc=, to: :sort, prefix: true

  delegate :size, to: :page, prefix: true
  delegate :size=, to: :page, prefix: true
  delegate :number, to: :page, prefix: true
  delegate :number=, to: :page, prefix: true

  def initialize(sort: nil, page: nil, filters: {}, collection: nil, query_op: nil)
    @total = 0
    @collection = collection

    self.tables = OpenStruct.new(**tables_hash)

    initialize_sort(sort)
    initialize_page(page)
    initialize_filters(filters)
    initialize_query_op(query_op)
  end

  def base_collection
    raise ::NoMethodError, 'you must define a base ActiveRecord::Collection to use for the results query'
  end

  def tables_hash
    raise ::NoMethodError, 'you must define a hash of tables to use for the query'
  end

  def active_filters
    results = {}
    filters.each_pair do |k, v|
      next if v.blank?

      results[k] = v
    end

    results
  end

  def set_filter(key, value)
    filters.send("#{key}=".to_sym, value)
  end

  def clear_filter(key)
    filters.delete_field(key)
  end

  def resolve(paginated: true)
    results = base_collection
              .where(query_conditions)
              .order(order_statement)

    self.total = results.size

    results = results.paginate(
      page: page.number,
      per_page: page.size
    ) if paginated

    results
  end

  attr_writer :total
  attr_accessor :page, :sort, :filters, :tables, :query_op

  protected

  def filter_class
    raise ::NoMethodError, 'you must define a filter class to use for the query'
  end

  def query_conditions
    account_filters = filter_class.new(filters, tables, query_op)
    account_filters.apply
  end

  def initialize_sort(sort)
    self.sort = OpenStruct.new(
      key: (sort.present? && sort[:key] ? sort[:key].to_sym : :created_at), # default sort: created_at column
      desc: (sort.present? && (sort[:desc] == true || sort[:desc] == 'true')) # default sort direction: ascending
    )
  end

  def initialize_page(page)
    self.page = OpenStruct.new(
      number: (page.present? && page[:number] ? page[:number].to_i : 1), # default page: 1
      size: (page.present? && page[:size] ? page[:size].to_i : 10) # default page size: 10
    )
  end

  def initialize_filters(filters)
    self.filters = OpenStruct.new(**process_filters(filters))
  end

  def initialize_query_op(query_op)
    self.query_op = query_op
  end

  def order_statement
    sort_by.public_send(sort.desc ? :desc : :asc)
  end

  def sort_by
    raise ::NoMethodError, 'you must define the sort mechanism'
  end

  def process_filters(filters)
    return {} if filters.nil?

    filters.symbolize_keys
  end
end
