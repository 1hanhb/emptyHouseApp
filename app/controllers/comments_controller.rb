class CommentsController < ApplicationController
  def create
    @user = current_user
    @home = Home.find(params[:home_id])
    @comment = @home.comments.create(comment_params)
    redirect_to user_home_path(@user,@home)
  end

  def destroy
    @user = current_user
    @home = Home.find(params[:home_id])
    @comment = @home.comments.find(params[:id])
    @host = User.find(@home.user_id)
    if @user == nil
      redirect_to homes_path
    elsif @user.id == @comment.user_id || @user.admin
      @comment.destroy
      redirect_to user_home_path(@host,@home)
    end



  end


  private

  def comment_params
    params.require(:comment).permit(:commenter,:body,:user_id)
  end
end
