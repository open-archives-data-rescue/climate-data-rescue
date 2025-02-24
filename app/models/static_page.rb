class StaticPage < ApplicationRecord
  translates :title, :body, :slug, :meta_keywords, :meta_title,
             :meta_description, fallbacks_for_empty_translations: true
  globalize_accessors

  belongs_to :parent, class_name: 'StaticPage', optional: true
  has_many :children, class_name: 'StaticPage', :dependent => :destroy, foreign_key: :parent_id

  default_scope { order(position: :asc) }

  validates :title, presence: true
  validates :slug, :body, presence: true
  validates :slug, uniqueness: true

  scope :visible, -> { where(visible: true) }
  scope :top_level, -> { where(parent_id: nil) }
  scope :header_links, -> { where(show_in_header: true).visible.top_level }
  scope :footer_links, -> { where(show_in_footer: true).visible.top_level }
  scope :transcriber_links, -> { where(show_in_transcriber: true).visible.top_level }

  before_save :update_positions_and_slug

  def visible_children?
    children.where(visible: true).count > 0
  end

  def visible_header_children?
    children.where(visible: true, show_in_header: true).count > 0
  end

  def visible_footer_children?
    children.where(visible: true, show_in_footer: true).count > 0
  end

  def initialize(*args)
    super(*args)
    last_page = StaticPage.last
    self.position = last_page ? last_page.position + 1 : 0
  end

  def self.matches?(request)
    slug = request.path
    I18n.available_locales.each do |locale|
      slug.gsub!('/' + locale.to_s + '/', '/')
    end
    return false if slug =~ %r{\A\/+(admin|system)+}
    StaticPage.visible.find_by(slug: slug).present?
  end

  def link
    "/#{I18n.locale}#{slug}"
  end

  private

  def update_positions_and_slug
    # Ensure that all slugs start with a slash.
    slug.prepend('/') if !slug.start_with?('/')
    return if new_record?
    return unless (prev_position = StaticPage.find(id).position)
    if prev_position > position
      StaticPage.where('? <= position and position < ?', position, prev_position).update_all('position = position + 1')
    elsif prev_position < position
      StaticPage.where('? < position and position <= ?', prev_position, position).update_all('position = position - 1')
    end
  end
end
