class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_user_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = current_user
    if @user.destroy
      redirect_to new_user_session_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name)
  end
end
