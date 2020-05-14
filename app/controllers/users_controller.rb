class UsersController < ApplicationController
before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new
  end

  def new
  	@book = Book.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "You have creatad user successfully."
       redirect_to user_path(current_user)
    #current_userでサインインしているユーザーを取得する
    else
       render action: :edit
    end
  end


  def edit
  	@user = User.find(params[:id])
    if current_user.id != @user.id
       redirect_to user_path(current_user.id)
    end
  end

  def create
    @users = User.all
    # ストロングパラメーターを使用
    @book = Book.new(book_params)
    if @book.save
       flash[:notice] = "You have creatad book successfully."
       redirect_to book_path
    end
  end

  def index
    @book = Book.new
    @user = current_user
    @users = User.all
  end


  private

  def user_params
  	params.require(:user).permit(:name,:profile_image,:introduction)
  end
end



