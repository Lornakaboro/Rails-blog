class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments, author: :comments)
  end

  def show
    @current_user = current_user
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @post = @user.posts.find(params[:id])
    else
      @post = Post.find(params[:id])
    end
    @comments = @post.comments
  end

  def new
  @current_user = current_user
  @user = current_user
  @post = @current_user.posts.new
  end

  def create
    @current_user = current_user
    @post = @current_user.posts.new(post_params)
    if @post.save
      redirect_to user_posts_path(@current_user)
    else
      render :new
    end
  end  
  
  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
