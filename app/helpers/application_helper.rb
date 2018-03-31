module ApplicationHelper

  def bread_crumbs
    crumbs = []

    current_dir = true

    if @document
      crumbs << "<b><i class='fa fa-file'></i>#{@document.name}</b>"
      current_folder = @document.folder
      current_dir = false

      while current_folder do
        crumbs << link_to("<i class='fa fa-folder'></i>#{current_folder.name}".html_safe, site_folder_path(current_folder.site, current_folder))

        current_folder = current_folder.folder
      end

      crumbs << link_to(@site.name, site_path(@site))
    elsif @folder
      current_folder = @folder

      while current_folder do
        if current_dir
          crumbs << "<b><i class='fa fa-folder'></i>#{current_folder.name}</b>"
        else
          crumbs << link_to("<i class='fa fa-folder'></i>#{current_folder.name}".html_safe, site_folder_path(current_folder.site, current_folder))
        end

        current_folder = current_folder.folder
        current_dir = false
      end

      crumbs << link_to(@site.name, site_path(@site))
    elsif @site
      if current_dir
        crumbs << "<b><i class='fa fa-globe'></i>#{@site.name}</b>"
      else
        crumbs << link_to("<i class='fa fa-globe'></i>#{@site.name}", site_path(@site))
      end
      current_dir = false
    end

    if current_dir
      crumbs << "<b>Sites</b>"
    else
      crumbs << link_to("Sites", root_path)
    end

    crumbs.reverse.join(" / ").html_safe
  end

end
