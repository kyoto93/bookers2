class BooksController < ApplicationController
	before_action :authenticate_user!

	def new #新たに投稿するためのページを呼ぶアクション
		@book = Book.new
	end

   # 投稿データの保存
	def create
		@book = Book.new(book_params)

		@book.user_id = current_user.id

		if @book.save
		    flash[:notice] = "You have creatad book successfully."

		    redirect_to book_path(@book.id)

		else
			@user = current_user
			@books = Book.all
			render action: :index
		end
	end

	def update
		@book = Book.find(params[:id])

		if @book.update(book_params)
			flash[:notice] = "You have updated book successfully."

			redirect_to book_path(@book.id)

        else
        	render action: :edit
        end
  end

	def index

		@book = Book.new#form(新たに作る為の入力欄・空箱)
		@books = Book.all #booksと複数形にした方が自然

		@user = current_user
	end

	def show
		@book = Book.find(params[:id])
		@user = @book.user#ブックを投稿したユーザ
	end

	def edit
		@book = Book.find(params[:id])
		if current_user.id != @book.user_id
			redirect_to books_path
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path, notice:"successfully."
	end

	# 投稿データのストロングパラメータ
	private
    def book_params
        params.require(:book).permit(:title, :body)
    end

end
