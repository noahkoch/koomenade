class SitesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :post_values

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

  def post_values
    # fix authenticity issue later
    @document = current_user.documents.find_by(name: params[:document_path])

    form = @document.available_forms.find_by(table_name: params[:_store])
    new_values = params[form.table_name]
    if new_values.present?
      new_record = {}
      form.fields.keys.each do |key|
        new_record[key] = new_values[key]
      end
      KQLDataStore.get_store(@document.user, form.table_name)
                  .write(new_record)
    end

    redirect_to render_view_path(
      username: @document.user.username, 
      site_name: @document.site.name,
      document_path: @document.name
    )  
  end

  private

  def site_params
    params.require(:site).permit(:name)
  end
end
