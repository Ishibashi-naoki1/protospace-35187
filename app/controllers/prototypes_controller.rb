class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]
# before_action :authenticate_user!, only: [:new, :edit, :destroy, :update, :create]
# before_action :move_to_index, only: [:update]

  def index
    @prototypes = Prototype.all
    # .includes(:user)
  end

  def new
    @prototype = Prototype.new
  end
  
  def create
    # @prototype = Prototype.new(prototypes_params)+if @prototype.saveでクリエイトと同じ記述になる
    @prototype = Prototype.new(prototypes_params)
    if @prototype.save
       redirect_to root_path(@prototype)
      # リダイレクトのお使い方redirect_to  edit_user_path(@item.user_id) #この@item.user_idを記載していませんでした。
    else
       render :new
       @prototype = Prototype.includes(:user)
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end
  
  def edit
    @prototype = Prototype.find(params[:id])
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototypes_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to root_path
    end    
  end

  private

  def prototypes_params
    # モデルは一つずつ処理を行うので単数形、テーブルはたくさんの情報があるので複数形データを渡す時はモデルを通すのでモデルファイル名を指定してあげる
    # user_id: current_user.id ドットidを忘れるなかれ！テーブルに反映されない
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  # def move_to_index
  #   unless user_signed_in? == current_user.name
  #     redirect_to root_path
  #   end
  # end
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def contributor_confirmation
    
    redirect_to root_path unless current_user == @prototype.user
  end
end
