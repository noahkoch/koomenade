class SitesController < ApplicationController
  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    @site.user = current_user
    @site.save
    redirect_to root_path, notice: "Created"
  end

  def show
    @site = current_user.sites.find_by(id: params[:id])
    @folders = @site.folders.where(folder_id: nil)
    @documents = @site.documents.where(folder_id: nil)
  end

  def render_view
    @view = current_user.documents.find_by(name: params[:document_path])
    render layout: nil 
  end

  private

  def site_params
    params.require(:site).permit(:name)
  end
end
