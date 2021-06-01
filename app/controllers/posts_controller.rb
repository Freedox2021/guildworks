class PostsController < ApplicationController
  
 before_action :require_user_logged_in
   before_action :correct_user, only: [:destroy, :show, :update, :edit,]
  
  def index
    if logged_in?
      @post = current_user.posts.build
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
    end
  end

  def show
     @post = Post.find(params[:id])

  end

  def new
      @post = Post.new
  end

  def create

      @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'タスク が正常に投稿されました'
      redirect_to @post
    else
      flash.now[:danger] = 'タスク が投稿されませんでした'
      render :new
    end
  end

  def edit
       @post = Post.find(params[:id])
  end

  def update
       @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
  end

  def destroy
          @post = Post.find(params[:id])
    @post.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to posts_url
  end
  
   private

  # Strong Parameter
  def post_params
    params.require(:post).permit(:content, :status)
  end
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end