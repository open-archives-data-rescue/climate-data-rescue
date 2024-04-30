module Admin
  class FieldGroupsController < AdminController
    # load_and_authorize_resource
    respond_to :html, :json, :js
    #Corresponds to the "fieldgroup" model, FieldGroup.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the FieldGroup model
    #Fieldgroups contain (relate to) many fields and group them based on their location on a page
    #All .html.slim views for "FieldGroup.rb" are located at "project_root\app\views\fieldgroups"
    # GET /fieldgroups
    # GET /fieldgroups.json
    def index
      if current_user && current_user.admin?
        #@field_groups is the variable containing all instances of the "FieldGroup.rb" model passed to the fieldgroup view "index.html.slim" (project_root/fieldgroups) and is used to populate the page with information about each fieldgroup using @field_groups.each (an iterative loop).
        @field_groups = FieldGroup.includes(:page_types).all
        if params[:page_type_id].present?
          @page_type = PageType.find params[:page_type_id]
          @field_groups = @field_groups.select{|field_group| !field_group.page_types.include?(@page_type) }
        end

        respond_to do |format|
          format.html # index.html.erb
          format.json
        end
      else
        flash[:danger] = 'Only administrators can modify fieldgroups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # GET /fieldgroups/fieldgroup_id
    # GET /fieldgroups/fieldgroup_id.json
    def show
      if current_user && current_user.admin?
        #@field_group is a variable containing an instance of the "FieldGroup.rb" model. It is passed to the fieldgroup view "show.html.slim" (project_root/fieldgroups/fieldgroup_id) and is used to populate the page with information about the fieldgroup instance.
        @field_group = FieldGroup.find(params[:id])

        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @field_group }
        end
      else
        flash[:danger] = 'Only administrators can view fieldgroups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # GET /fieldgroups/new
    # GET /fieldgroups/new.json
    def new
      if current_user && current_user.admin?

        #@field_group is a variable containing an instance of the "FieldGroup.rb" model. It is passed to the fieldgroup view "new.html.slim" (project_root/fieldgroups/new) and is used to populate the page with information about the fieldgroup instance. "new.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the new fieldgroup instance.
        @field_group = FieldGroup.new

        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @field_group }
        end

      else
        flash[:danger] = 'Only users can modify fieldgroups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # GET /fieldgroups/fieldgroup_id/edit
    def edit
      if current_user && current_user.admin?
        #@field_group is a variable containing an instance of the "FieldGroup.rb" model. It is passed to the fieldgroup view "edit.html.slim" (project_root/fieldgroups/edit) and is used to populate the page with information about the fieldgroup instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent fieldgroup instance.
        @field_group = FieldGroup.find(params[:id])
      else
        flash[:danger] = 'Only users can modify fieldgroups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # POST /fieldgroups
    # POST /fieldgroups.json
    def create
      if current_user && current_user.admin?

        FieldGroup.transaction do
          begin
            #@field_group is a variable containing an instance of the "FieldGroup.rb" model created with data passed in the params of the "new.html.slim" form submit action.
            @field_group = FieldGroup.create!(field_group_params)

            if params[:page_type_id]
              @page_type = PageType.find params[:page_type_id]
            end
          rescue => e
            flash[:danger] = e.message
          end
        end

        respond_to do |format|
          if @field_group.id
            format.html { redirect_to admin_field_group_path(@field_group), success: 'Fieldgroup was successfully created.' }
            format.json
          else
            format.html { render action: "new" }
            format.json { render json: @field_group.errors, status: :unprocessable_fieldgroup }
          end
        end

      else
        flash[:danger] = 'Only users can modify fieldgroups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # PUT /fieldgroups/fieldgroup_id
    # PUT /fieldgroups/fieldgroup_id.json
    def update
      if current_user && current_user.admin?

        FieldGroup.transaction do
          begin
            #@field_group is a variable containing an instance of the "FieldGroup.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action.
            @field_group = FieldGroup.find(params[:id])

          rescue => e
            flash[:danger] = e.message
          end
        end

        respond_to do |format|
          if @field_group.update(field_group_params)
            format.html { redirect_to admin_field_group_path(@field_group), success: 'Fieldgroup was successfully updated.' }
            format.json
          else
            format.html { render action: "edit" }
            format.json { render json: @field_group.errors, status: :unprocessable_fieldgroup }
          end
        end

      else
        flash[:danger] = 'Only users can modify fieldgroups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # DELETE /fieldgroups/fieldgroup_id
    # DELETE /fieldgroups/fieldgroup_id.json
    def destroy
      if current_user && current_user.admin?

        FieldGroup.transaction do
          begin
            #this function is called to delete the instance of "FieldGroup.rb" identified by the fieldgroup_id passed to the destroy function when it was called
            @field_group = FieldGroup.find(params[:id])
            @field_group.destroy
            flash[:info] = I18n.t('field-group-successfully-deleted')
          rescue => e
            flash[:danger] = e.message
          end
        end

        respond_to do |format|
          format.html { redirect_to admin_field_groups_path }
          format.json { head :no_content }
        end
      else
        flash[:danger] = 'Only users can modify field groups! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end



    def add_to_page_type
      raise 'page type and field not present' unless params[:page_type_id].present? && params[:field_group_id].present?

      @page_type = PageType.find params[:page_type_id]
      @field_group = FieldGroup.find params[:field_group_id]

      ptfg = PageTypesFieldGroup.create!(
        page_type_id: params[:page_type_id],
        field_group_id: params[:field_group_id],
        sort_order: 0
      )
      # raise ptfg.errors.full_messages.join("<br />") if ptfg.errors.any?
    rescue => ex
      Rails.logger.error ex.message
      Rails.logger.error ex.backtrace.join('\n\t')
      render status: :bad_request, text: ex.message
    end

    def remove_from_page_type
      raise 'page type and field not present' unless params[:page_type_id].present? && params[:field_group_id].present?
      @page_type = PageType.find params[:page_type_id]
      @field_group = FieldGroup.find params[:field_group_id]
      @ptfg = PageTypesFieldGroup.find_by(page_type_id: params[:page_type_id], field_group_id: params[:field_group_id])
      @ptfg.destroy if @ptfg
    rescue => ex
      Rails.logger.error ex.message
      Rails.logger.error ex.backtrace.join('\n\t')
      render status: :bad_request, text: ex.message
    end

    def update_sort_order
      raise 'page type and field not present' unless params[:page_type_id].present? && params[:field_group_id].present?
      @page_type = PageType.find params[:page_type_id]
      @field_group = FieldGroup.find params[:field_group_id]
      @ptfg = PageTypesFieldGroup.find_by(page_type_id: params[:page_type_id], field_group_id: params[:field_group_id])
      if @ptfg
        @ptfg.sort_order_position = params[:sort_order_position]
        @ptfg.save!
      end
    rescue => ex
      Rails.logger.error ex.message
      Rails.logger.error ex.backtrace.join('\n\t')
      render status: :bad_request, text: ex.message
    end

    def for_page_type
      begin
        if params[:page_type_id].present?
          @page_type = PageType.find params[:page_type_id]
          search = params[:search] ? params[:search] : nil

          if search
            @field_groups = @page_type.field_groups.where(["name like :q or name like :q or help like :q", :q => ("%" + search + "%")])
          else
            @field_groups = @page_type.field_groups
          end
        end
      rescue => e
        flash[:danger] = e.message
      end

      render "index"
    end

    protected
    def field_group_params
      params.require(:field_group).permit(:internal_name, :name, :display_name, :description, :help, :page_type_id, :position, :colour_class)
    end
  end
end
