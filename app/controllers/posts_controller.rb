class PostsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create, :index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @post.save
        redirect_to post_path(@post.id)
      else
        flash.now[:danger] = 'failed to post'
        render :new
      end
    end
  end

  def index
    @post = Post.all
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    render :new if @post.invalid?
  end

  private
  def post_params
    params.require(:post).permit(:content, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
