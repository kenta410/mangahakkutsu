class Public::FavoritesController < ApplicationController
  def create
    comic = Comic.find(params[:comic_id])
    favorite = current_customer.favorites.new(comic_id: comic.id)
    favorite.save!
    redirect_to request.referer
  end

  def destroy
    comic = Comic.find(params[:comic_id])
    favorite = current_customer.favorites.find_by(comic_id: comic.id)
    favorite.destroy
    redirect_to request.referer
  end
end
