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
    @comic.image = params[:comic][:image]
    @comic.title = params[:comic][:title]
    @comic.synopsis = params[:comic][:synopsis]
    if @comic.save
      redirect_to admin_comics_path(@comic)
    else
      render "edit"
    end
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :synopsis, :image)
  end


end
