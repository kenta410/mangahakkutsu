class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'customer'
			@records = Customer.search_for(@content, @method)
		elsif @model == 'comic'
			@records = Comic.search_for(@content, @method)
		elsif @model == 'tag'
			@records = Tag.search_comics_for(@content, @method)
		end
  end
end
