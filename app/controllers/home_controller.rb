class HomeController < ApplicationController
  
  def index
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

end
