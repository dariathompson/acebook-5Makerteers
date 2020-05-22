# frozen_string_literal: true

class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.create(comment_params)
    redirect_to user_path(id: @comment.post.wall_id)
  end

  def edit
    @comment = Comment.find(params[:id])
    if !owner?(@comment.user_id) || Time.now > (@comment.created_at + 600)
      redirect_to user_path(id: @comment.post.wall_id), notice: 'You cannot edit this comment'
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attribute(:body, comment_params['body'])
      redirect_to user_path(id: @comment.post.wall_id)
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if !owner?(@comment.user_id)
      redirect_to user_path(id: @comment.post.wall_id), notice: 'You cannot delete this comment'
    else
      @comment.destroy
      redirect_to user_path(id: @comment.post.wall_id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :body)
  end
end
