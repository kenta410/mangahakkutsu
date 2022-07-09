class Public::CommentsController < ApplicationController
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
end
