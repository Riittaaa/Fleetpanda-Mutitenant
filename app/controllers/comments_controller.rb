class CommentsController < ApplicationController
  before_action :set_blog
  before_action :authorize_commenter!, only: [:destroy]

  def create 
    @comment = @blog.comments.build(comment_params)
    @comment.commenter = current_user.email
    if @comment.save
      redirect_to blog_path(@blog), notice: "Comment added successfully!"
    else
      redirect_to blog_path(@blog), alert: "There was an error adding your comment."
    end
  end

  def destroy
    # @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    redirect_to blog_path(@blog), notice: "Comment deleted successfully!"
  end

  private

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end
  
  def comment_params
    params.require(:comment).permit(:comment)
  end

  def authorize_commenter!
    @comment = @blog.comments.find(params[:id])
    unless current_user.email == @comment.commenter
      redirect_to blog_path(@blog), alert: "You are not authorized to delete this comment."
    end
  end
end
