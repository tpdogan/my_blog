class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.article_id = params[:article_id]
    if @comment.user == '' || @comment.body == ''
      respond_to do |format|
        format.html { redirect_to article_path(@comment.article), notice: 'Fields cannot be empty!' }
      end
      return
    end
    @comment.save
    redirect_to article_path(@comment.article)
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to article_path(@comment.article), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:user, :body, :article_id)
    end
end
