class CommentsController < ApplicationController
  def create
     @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype) # 今回の実装には関係ありませんが、このようにPrefixでパスを指定することが望ましいです。
    else
      @prototype = @comment.prototype.find(params[:id])
      @comments = @prototype.comments.find(params[:id])
      render "prototypes/show" # views/prototypes/show.html.erbのファイルを参照しています。
    end
end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end