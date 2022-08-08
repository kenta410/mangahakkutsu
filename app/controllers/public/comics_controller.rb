class Public::ComicsController < ApplicationController

before_action :current_customer,only: [:edit, :update]

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
    if params[:search].present?
      items = Comic.comics_serach(params[:search])
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      comics = @tag.comics.order(created_at: :desc)
    else
      comics = Comic.all.order(created_at: :desc)
    end
    @tag_lists = Tag.all
    @comics = Kaminari.paginate_array(comics).page(params[:page]).per(10)
  end

  def create
    @customer = current_customer
    @comic = Comic.new(comic_params)
#    tag_list = params[:comic][:tag_name].split(nil)
    @comic.customer_id = current_customer.id
    if @comic.save
#      @comic.save_comics(tag_list)
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
