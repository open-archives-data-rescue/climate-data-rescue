class StaticPagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  respond_to :html, :json

  def show
    slug = request.path
    @slug = slug.gsub('/' + I18n.locale.to_s + '/', '/')
    @page = StaticPage.visible.find_by(slug: @slug)
  end

  private
  def static_page_params
    params.require(:static_page).permit(:title, :body, :slug, :show_in_header, :show_in_footer, :show_in_transcriber, :visible, :position, :meta_keywords, :meta_title, :meta_description, :title_as_header)
  end

  def accurate_title
    @page ? (@page.meta_title.present? ? @page.meta_title : @page.title) : nil
  end
end