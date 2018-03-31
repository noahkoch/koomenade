class DocumentsController < ApplicationController

  def new
    @site = current_user.sites.find_by(id: params[:site_id])
    @document = Document.new(folder_id: params[:folder_id])
  end

  def create
    @site = Site.find_by(id: params[:site_id])

    @document = Document.new(document_params)
    @document.site = @site
    @document.user = current_user
  
    if @document.save
      if @document.folder 
        redirect_to site_folder_path(site_id: @site.id, id: @document.folder.id)
      else
        redirect_to site_path(id: @site.id)
      end
    else
      render :new
    end
  end

  def edit
    @site = Site.find_by(id: params[:site_id], user: current_user)
    @document = @site.documents.find_by(id: params[:id])
  end

  def update
    @site = Site.find_by(id: params[:site_id], user: current_user)
    @document = @site.documents.find_by(id: params[:id])
    @document.assign_attributes(document_params)
    if @document.save
      if @document.folder 
        redirect_to site_folder_path(site_id: @site.id, id: @document.folder.id)
      else
        redirect_to site_path(id: @site.id)
      end
    else
      render :edit
    end
  end

  private

  def document_params
    params.require(:document).permit(:contents, :name, :folder_id) 
  end

end
