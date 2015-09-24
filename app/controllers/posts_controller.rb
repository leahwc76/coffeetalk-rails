class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
  	@posts = Post.last(10).reverse
  end

  def new
  	@post = Post.new
  end

  def show
  end

  def edit
  end

  def create
  	@post = Post.create(post_params)
  	redirect_to profile_path, notice: "New post!"
  end

  def update
  	@post.update(post_params)
  	redirect_to @post, notice: "Post updated!"
  end

  def destroy
  	@post.destroy
  	redirect_to posts_path, notice: "Post was deleted."
  end

  private

  def post_params
  	params.require(:post).permit(:title, :body).merge(user: current_user)
  end

  def set_post
  	begin
  		@post = Post.find(params[:id])
  	rescue
  		flash[:notice] = "That post is not available."
  		redirect_to posts_path
  	end
  end
end
