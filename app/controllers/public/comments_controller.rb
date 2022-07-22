class Public::CommentsController <
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:edit]
  def create
    comic = comic.find(params[:comic.id])
    comment = current_customer.comic_comments.new(comic_comment_params)
    comment.comic_id = comic.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    Comment.find_by(id: params[:id], comic_id: params[:comic_id]).destroy
    redirect_to request.referer
  end

  private
  def comic_comment_params
    params.require(:comic_comment).permit(:comment)
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
