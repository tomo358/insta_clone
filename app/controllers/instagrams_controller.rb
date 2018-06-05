class InstagramsController < ApplicationController

  before_action :logged_in_user, only: [:new, :edit, :show, :destroy]

  def index
    @instas = Instagram.all
  end

  def new
    if params[:back]
      @insta = Instagram.new(instagram_params)
      @insta.image.retrieve_from_cache! params[:cache][:image]
    else
      @insta = Instagram.new
    end
  end

  def create
    @insta = Instagram.new(instagram_params)
    @insta.user_id = current_user.id
    @insta.image.retrieve_from_cache! params[:cache][:image]

    if @insta.save
      NoticeMailer.notice_mail(@insta).deliver
      redirect_to instagrams_path,notice: "投稿完了！"
    else
      render 'new'
    end
  end

  def show
    @insta = Instagram.find(params[:id])
    @favorite = current_user.favorites.find_by(instagram_id:@insta.id)
  end

  def edit
    @insta = Instagram.find(params[:id])
  end

  def update
    @insta = Instagram.find(params[:id])
    if @insta.update(instagram_params)
      redirect_to instagrams_path,notice: "編集完了!"
    else
      render 'edit'
    end
  end

  def destroy
    @insta = Instagram.find(params[:id])
    @insta.destroy
    redirect_to instagrams_path,notice: "削除完了!"
  end

  def confirm
    @insta = Instagram.new(instagram_params)
    @insta.user_id = current_user
    render "new" if @insta.invalid?
  end

  private
  def instagram_params
    params.require(:instagram).permit(:content, :image, :image_cache)
  end

  def set_instagram
    @insta = Instagram.find(params[:id])
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in!"
      redirect_to new_session_path
    end
  end
end
