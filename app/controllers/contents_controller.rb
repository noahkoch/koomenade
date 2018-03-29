class ContentsController < ApplicationController

  def new
  end

  def create
    if contents_params[:type] == 'folder'
      Objekt.new(contents_params)
    elsif contents_params[:type] == 'file'
      Objekt::File.new(contents_params)
    end

    redirect_to root_path
  end

  private

  def contents_params
  end

end
