class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    @Post = Post.new
  end

  # cannot post minus logging in
  def logged_in_user
    unless log_in?
      redirect to login_path
    end    
  end
  
end
