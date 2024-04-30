module Admin
  class FieldOptionsController < AdminController
    respond_to :html, :json

    def show
      set_field_option
    rescue => e
      flash[:danger] = e.message
    end

    def edit
      set_field_option
    rescue => e
      flash[:danger] = e.message
    end

    def update
      FieldOption.transaction do
        begin
          Rails.logger.debug "*** UPDATE FIELD OPTION #{params}"
          #@field_option is a variable containing an instance of the "FieldOption.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action.
          @field_option = FieldOption.find(params[:id])
          @field_option.update(field_option_params)

          if params[:field_option][:image] && !(params[:field_option][:image].size > 0) && params[:field_option][:delete_image] && params[:field_option][:delete_image] == "true"
            @field_option.image = nil
            @field_option.save!
          end

          if params[:field_id]
            @field = Field.find params[:field_id]
          end

        rescue => e
          Rails.logger.error "*** WE HAVE A PROBLEM #{e}"
          flash[:danger] = e.message
          respond_to do |format|
            format.json { render json: {message: e.message} and return}
            format.html { redirect_to(edit_admin_field_option_path(@field_option)) and return }
          end
        end
      end
      respond_to do |format|
        format.json
        format.html { redirect_to admin_field_options_path }
      end
    end

    def create
      FieldOption.transaction do
        begin
          #@field_Option is a variable containing an instance of the "FieldOption.rb" model created with data passed in the params of the "new.html.slim" form submit action.
          @field_option = FieldOption.create!(field_option_params)
          if params[:image].present?
            @field_option.image = params[:image]
          end

          @field_option.save!
        rescue => e
          flash[:danger] = e.message
        end
      end
      respond_to do |format|
        format.json
        format.html { redirect_to admin_field_options_path }
      end
    end

    def new
      @field_option = FieldOption.new
    end

    def add_to_field
      if params[:field_option_id].present? && params[:field_id].present?
        begin
          @field_option = FieldOption.find params[:field_option_id]
          @field = Field.find params[:field_id]

          FieldOptionsField.create!(field_option_id: params[:field_option_id], field_id: params[:field_id])
        rescue => e
          Rails.logger.error e.message
          Rails.logger.error e.backtrace.join('\n\t')

          render json: { status: :bad_request, text: e.message}
        end

        # render json: {}
      end
    end

    def remove_from_field
      if params[:field_option_id].present? && params[:field_id].present?
        begin
          @field_option = FieldOption.find params[:field_option_id]
          @field = Field.find params[:field_id]
          @fof = FieldOptionsField.find_by(field_option_id: params[:field_option_id], field_id: params[:field_id])
          @fof.destroy if @fof
        rescue => e
          Rails.logger.error e.message
          Rails.logger.error e.backtrace.join('\n\t')

          render json: { status: :bad_request, text: e.message}
        end

        # render json: {}
      end
    end

    def update_sort_order
      if params[:field_option_id].present? && params[:field_id].present?
        begin
          @field_option = FieldOption.find params[:field_option_id]
          @field = Field.find params[:field_id]
          @fof = FieldOptionsField.find_by(field_option_id: params[:field_option_id], field_id: params[:field_id])
          if @fof
            @fof.sort_order_position = params[:sort_order_position]
            @fof.save
          end
        rescue => e
          Rails.logger.error e.message
          Rails.logger.error e.backtrace.join('\n\t')

          render json: { status: :bad_request, text: e.message}
        end

        # render json: {}
      end
    end

    def index
      begin
        @field_options = FieldOption.all
        if params[:field_id].present?
          @field = Field.find params[:field_id]
          @field_options = @field_options.where(is_default: false).select{|fo| !fo.fields.include?(@field) }
        end
      rescue => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join('\n\t')

        render json: { status: :bad_request, text: e.message}
      end
    end

    def for_field
      begin
        if params[:field_id].present?
          @field = Field.find params[:field_id]
          search = params[:search] ? params[:search] : nil

          if search
            @field_options = @field.field_options.where(["value like :q or name like :q or help like :q", :q => ("%" + search + "%")])
          else
            @field_options = @field.field_options
          end
        end
      rescue => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join('\n\t')

        render json: { status: :bad_request, text: e.message}
      end

      render "index"
    end

    def destroy
      if current_user && current_user.admin?

        FieldOption.transaction do
          begin
            #this function is called to delete the instance of "FieldOption.rb" identified by the fieldOption_id passed to the destroy function when it was called
            @field_option = FieldOption.find(params[:id])
            @field_option.destroy
          rescue => e
            flash[:danger] = e.message
          end
        end

        respond_to do |format|
          format.html { redirect_to admin_field_options_path }
          format.json { head :no_content }
        end
      else
        flash[:danger] = 'Only users can modify field groups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    protected

    def set_field_option
      @field_option = FieldOption.find params[:id]
    end

    def field_option_params
      params.require(:field_option).permit(:internal_name, :name, :image, :help, :value, :text_symbol, :display_attribute)
    end
  end
end
