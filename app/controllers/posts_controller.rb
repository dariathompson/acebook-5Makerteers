# frozen_string_literal: true

class PostsController < ApplicationController
  # /index shows all posts where the wall_id = 0 (Newsfeed wall ID) or where the Wall_id = User_id (User posted on their own wall)
  # /index also allows us to create a new post
  # /index also allows us to create a new comment
  def index
    @comment = Comment.new
    @new_post = Post.new
    @posts = Post.where('wall_id = 0').order(created_at: :desc)
  end

  # /edit finds the post with the corresponding ID
  # if the current user is not the owner of the post or if the post was created over 10 minutes ago, then the post cannot be editted.
  def edit
    @post = Post.find(params[:id])
    if !owner?(@post.user_id) || Time.now > (@post.created_at + 600)
      redirect_to posts_url, notice: 'You cannot edit this post'
    end
  end

  # /create takes the post parameters and created a new post under the current user
  def create
    @post = current_user.posts.create(post_params)
    redirect_to user_path(id: post_params[:wall_id])
  end

  # /update finds the post with the corresponding ID
  # if the new post params allow for an edit to be made then the user is redirected back to the posts_url
  # else if the params do not allow for an edit, the user is redirected back to the edit view.
  def update
    @post = Post.find(params[:id])
    if @post.update_attribute(:message, post_params['message'])
      redirect_to posts_url
    else
      render 'edit'
    end
  end

  # /destroy finds the post with the corresponding ID
  # if the current user is not the owner of the post, they are redirected back to the posts page and notified that they cannot delete this post
  # if the current user is the owner of the post, the post is deleted and they are redirected back to the posts page.

  def destroy
    @post = Post.find(params[:id])
    if !owner?(@post.user_id)
      redirect_to posts_url, notice: 'You cannot delete this post'
    else
      @post.destroy
      redirect_to posts_url
    end
  end

  private

  # post_params filter the parameters to find the relevant parameters related to creating or editing the post.
  def post_params
    params.require(:post).permit(:message, :wall_id)
  end
end
