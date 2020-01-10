# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :logged_in_user, only: %i[new create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to root_path
  end

  def index
    @posts = Post.all
  end

  # cannot post minus logging in
  def logged_in_user
    redirect to login_path unless logged_in?
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
