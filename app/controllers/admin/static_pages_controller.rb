module Admin
  class StaticPagesController < AdminController
  	rescue_from ActiveRecord::RecordNotFound, with: :render_404
    respond_to :html, :json

    def index
      @static_pages = StaticPage.top_level
    end

    def new
      @static_page = StaticPage.new
    end

    def create
    	if current_user && current_user.admin?
      	StaticPage.transaction do
      		begin
            @static_page = nil
            @static_page = StaticPage.create!(static_page_params)
      		rescue => e
      			flash[:danger] = e.message
  				end
      	end

        respond_to do |format|
          if @static_page && @static_page.id
            flash[:success] = 'Content Page created successfully!'
            format.html { redirect_to admin_static_pages_path }
          else
            format.html { redirect_to new_admin_static_page_path }
          end
        end
    	else
        flash[:danger] = 'Only admins can create pages! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
  	  end
    end

    def update
      if current_user && current_user.admin?
        StaticPage.transaction do
          begin
            @static_page = nil
            @static_page = StaticPage.find params[:id]
            @static_page.update(static_page_params)
          rescue => e
            flash[:danger] = e.message
          end
        end

        respond_to do |format|
          if @static_page && @static_page.id
            flash[:info] = 'Content Page updated successfully!'
            format.html { redirect_to admin_static_pages_path }
          else
            format.html { redirect_to :back }
          end
        end
      else
        flash[:danger] = 'Only admins can update pages! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    def destroy
      if current_user && current_user.admin?
        begin
          @static_page = StaticPage.find(params[:id]).destroy
          flash[:info] = "Page sucessfully deleted"
        rescue => e
          flash[:danger] = e.message
        end
        redirect_to admin_static_pages_path
      else
        flash[:danger] = 'Only admins can update pages! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    def edit
      if current_user && current_user.admin?
        begin
          @static_page = StaticPage.find(params[:id])
        rescue => e
          flash[:danger] = e.message
        end
      else
        flash[:danger] = 'Only admins can update pages! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    private
    def static_page_params
    	params.require(:static_page).permit(:title, :body, :slug, :show_in_header, :show_in_footer, :show_in_transcriber, :visible, :position, :meta_keywords, :meta_title, :meta_description, :title_as_header, :parent_id)
    end

    def accurate_title
      @page ? (@page.meta_title.present? ? @page.meta_title : @page.title) : nil
    end
  end
end