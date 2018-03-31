class FoldersController < ApplicationController

  def new
    @site = current_user.sites.find_by(id: params[:site_id])
    @folder = Folder.new(folder_id: params[:folder_id])
  end

  def create
    @site = Site.find_by(id: params[:site_id])

    @folder = Folder.new(folder_params)
    @folder.site = @site
    @folder.user = current_user
  
    if @folder.save
      redirect_to site_folder_path(site_id: @site.id, id: @folder.id)
    else
      render :new
    end
  end

  def edit
    @site = Site.find_by(id: params[:site_id], user: current_user)
    @folder = @site.folders.find_by(id: params[:id])
  end

  def update
    @site = Site.find_by(id: params[:site_id], user: current_user)
    @folder = @site.folders.find_by(id: params[:id])
    @folder.assign_attributes(folder_params)
    if @folder.save
      redirect_to site_folder_path(site_id: @site.id, id: @folder.id)
    else
      render :edit
    end
  end

  def show
    @site = Site.find_by(id: params[:site_id], user: current_user)
    @folder = @site.folders.find_by(id: params[:id])

    @documents = @folder.documents
    @folders = @folder.folders
  end

  private

  def folder_params
    params.require(:folder).permit(:name, :folder_id) 
  end

end
