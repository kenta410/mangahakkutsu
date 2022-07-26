class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:edit]
  def create
    comic = Comic.find(params[:comic_id])
    comment = current_customer.comments.new(comment_params)
    comment.comic_id = comic.id
    comment.save!
    redirect_to request.referer
  end

  def destroy
    Comment.find_by(id: params[:id], comic_id: params[:comic_id]).destroy
    redirect_to request.referer
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :rate)
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
