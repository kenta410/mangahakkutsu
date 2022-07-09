class Public::FavoritesController < ApplicationController
  def create
    comic = comic.find(params[:book_id])
    favorite = current_customer.favorites.new(comic_id: comic.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    comic = comic.find(params[:comic_id])
    favorite = current_customer.favorite.find_by(comic_id: comic.id)
    favorite.destroy
    redirect_to request.referer
  end
end
