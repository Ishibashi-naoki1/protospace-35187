class UsersController < ApplicationController
  def show
    # idからユーザーネームを取り出すには？
    @user = User.find(params[:id])
    @prototypes = Prototype.all
    # @name = user.name：編集画面等から遷移ができなくなるから要らない
    @prototypes = @user.prototypes
  end

  # private
  # def user_name
  #   params.require(:user).permit(:name, :profile, :occupation, :position).merge(user_id: current_user.id)
    
  # end


end
