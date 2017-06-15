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
    if @user.id != @comment.user_id
      redirect_to user_home_path(@user,@home)
    end

    @comment.destroy
    redirect_to user_home_path(@user,@home)

  end


  private

  def comment_params
    params.require(:comment).permit(:commenter,:body,:user_id)
  end
end
