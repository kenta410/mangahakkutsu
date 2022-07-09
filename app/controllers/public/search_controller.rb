class Public::SearchController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'customer'
      @recodes = customer.search_for(@content, @method)
    else
      @recodes = comic.search_for(@content, @method)
    end
  end
end
