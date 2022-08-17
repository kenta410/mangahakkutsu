class Public::ComicsController < ApplicationController
  
before_action :current_customer,only: [:edit, :update, :destroy]

   def new
    @comic = Comic.new
   end

  def show
    @comic = Comic.find(params[:id])
    @comment = Comment.new
  end

  def index
    @customer = current_customer
    @comics = Comic.all.page(params[:page]).per(10)
    @comic = Comic.new
  end

  def create
    @customer = current_customer
    @comic = Comic.new(comic_params)
    @comic.customer_id = current_customer.id
    tag_list = params[:comic][:tag_name].split(',')
    if @comic.save
      @comic.save_tags(tag_list)
      redirect_to comic_path(@comic), notice: "You have created comic successfully."
    else
      @comics = Comic.all
      render 'index'
    end
  end

  def edit
    @comic = Comic.find(params[:id])
    @comments = Comment.all.page(params[:page]).per(10)
  end

  def update
    @comic = Comic.find(params[:id])
    if @comic.update(comic_params)
      redirect_to comic_path(@comic), notice: "You have updated comic successfully."
    else
      render "edit"
    end
  end

  def destroy
    @comic = Comic.find(params[:id])
    @comic.destroy
    redirect_to comics_path
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :synopsis, :image)
  end

  def corect_customer
    @comic = Comic.find(params[:id])
    unless @comic.customer == current_customer
      redirect_to comics_path
    end
  end
end
