class BooksController < ApplicationController
  before_action :is_matching_post_book, only: [:edit, :update]

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

    def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
      flash[:notice] = "You have created book successfully."
    # 4. トップ画面へリダイレクト
    redirect_to book_path(@book)
  else
    @user = current_user
    @books = Book.all
    render :index
  end
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "Book was successfully updated."
       redirect_to book_path(@book.id)
    else
       @books = Book.all
      render :edit
    end
  end


  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

def is_matching_post_book
    book = Book.find(params[:id])
    login_user_id = current_user.id
    if(book.user_id != login_user_id)
      redirect_to books_path
    end
  end

end

