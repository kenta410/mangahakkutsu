class Admin::ComicsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @comic = Comic.find(params[:id])
    @comments = Comment.all.page(params[:page]).per(10)
  end

  def index
    @comics = Comic.all.page(params[:page]).per(10)
  end

  def edit
    @comic = Comic.find(params[:id])
    @comments = Comment.all.page(params[:page]).per(10)
  end

  def update
    @comic = Comic.find(params[:id])
    if @comic.update(comic_params)
      redirect_to admin_comics_path, notice: "You have updated comic successfully."
    else
      render "show"
    end
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :synopsis, :image, :is_delete)
  end
  
  
end
