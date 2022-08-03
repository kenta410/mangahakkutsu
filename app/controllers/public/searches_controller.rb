class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    if (params[:kyeword])[0] == '#'
      @comics = Tag.search(params[:kyeword]).(order'created_at DESC')
    else
      @comics = Comic.search(params[:kyeword]).order('created_at DESC')
    end
  end
end
