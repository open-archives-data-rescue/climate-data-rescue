module Admin
  class PagesController < AdminController
    include LedgerUtils

    respond_to :html
    #Corresponds to the "page" model, page.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the page model
    #All .html.slim views for "page.rb" are located at "project_root\app\views\pages"
    # GET /pages
    def index
      # check
    end

    # GET /pages/page_id
    # GET /pages/page_id.json
    def show
      @page = Page.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @page }
      end
    end

    # GET /pages/new
    # GET /pages/new.json
    def new
      @page = Page.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @page }
      end
    end

    # GET /pages/page_id/edit
    def edit
      @page = Page.find(params[:id])
    end

    # POST /pages
    # POST /pages.json
    def create
      raise "no image detected" unless params[:page][:image].present?

      upload = params[:page][:image]
      Rails.logger.debug upload unless Rails.env.production?

      image = upload.is_a?(Array) ? upload[0] : upload
      page = nil

      filename = filename_sans_suffix(image: image)
      components = parse_filename(filename: filename)

      # Get or create the Ledger and PageType if needed
      ledger = create_or_find_ledger(components: components)
      page_type = create_or_find_page_type(ledger: ledger, components: components)

      Page.with_advisory_lock("Page_#{filename}_lock", timeout_seconds: 60) do
        # search based on filename before the suffix
        page = Page.where("image_file_name like ?", "#{filename}.%").take
        Page.transaction do
          if page.present? # update the image for the existing page
            page.update!(image: image)
          else # create a new page + ledger and page types if needed
            page = create_page(image: image, ledger: ledger, page_type: page_type, components: components)
          end
        end
      end

      respond_to do |format|
        format.html { #(html response is for browsers using iframe solution)
          render :json => [page.to_jq_upload].to_json,
          :content_type => 'application/json',
          :layout => false
        }
        format.json {
          render :json => {files: [page.to_jq_upload] }.to_json
        }
      end
    rescue => ex
      Rails.logger.error ex.message
      Rails.logger.error ex.backtrace.join("\n\t")
      respond_to do |format|
        format.html do
          flash[:error] = ex.message
          redirect_to new_admin_page_path
        end
        format.json do
          render status: :bad_request, text: ex.message
        end
      end
    end

    # PUT /pages/page_id
    # PUT /pages/page_id.json
    def update
      Page.transaction do
        begin
          @page = Page.find(params[:id])
          if @page.width.nil?
            @page.extract_dimensions
          end
        rescue => ex
          Rails.logger.error ex.message
          Rails.logger.error ex.backtrace.join("\n\t")
          flash[:danger] = ex.message
        end

        respond_to do |format|
          if @page.update(page_params)
            format.html { redirect_to admin_page_path(@page), success: 'Page was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @page.errors, status: :unprocessable_fieldgroup }
          end
        end
      end
    end

    def for_transcription
      if params[:transcription_id].present?
        begin
          @transcription = Transcription.find(params[:transcription_id])
          @page = @transcription.page
        rescue => e

        end
      end
    end

    # DELETE /pages/page_id
    # DELETE /pages/page_id.json
    def destroy
      Page.transaction do
          page = Page.find(params[:id])
          page.destroy!
      end

      respond_to do |format|
        format.html { redirect_to admin_pages_path }
        format.json { render :json => true }
      end
    end

    private

    def page_params
      params.require(:page).permit(:height, :order, :width, :page_type_id, :image,
        :title, :accession_number, :start_date, :start_date, :page_type, :volume,
        :visible, :done)
    end

    def page_number
      params[:page] || 1
    end

    def per_page
      params[:per_page] || 10
    end
  end
end
