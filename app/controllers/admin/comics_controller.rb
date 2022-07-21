class Admin::ComicsController < ApplicationController
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
    if  @comic.update(comic_params)
      redirect_to admin_comic_path(@comic)
    else
      render "edit"
    end
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :synopsis)
  end


end
