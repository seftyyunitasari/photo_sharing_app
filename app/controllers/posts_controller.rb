class PostsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @post.save
        PostMailer.post_created(current_user).deliver
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
    @like = current_user.likes.find_by(post_id: @post.id)
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
    params.require(:post).permit(:content, :caption, :content_cache)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
