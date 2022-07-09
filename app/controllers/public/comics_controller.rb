class Public::ComicsController < ApplicationController



  def show
    @comic = comic.find
    comment = Comment.new
  end

  def index
    @comics = comic.all
    @comic = comic.new
  end

  def create
    @comic = comic.new(conic_parames)
    @comic.customer_id = current_customer.id
    if @comic.save
      redirect_to comic_path(@comic), notice: "You have created comic successfully."
    else
      @comic = comic.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @comic.update(comic_params)
      redirect_to comic_path(@comic), notice: "You have updated comic successfully."
    else
      render "edit"
    end
  end

  def destroy
    @comic.destroy
    redirect_to comics_path
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :synopsis)
  end

  def rnsure_correct_user
    @comic = comic.find(params[:id])
    unless @comic.customer == current_customer
      redirect_to comics_path
    end
  end
end
