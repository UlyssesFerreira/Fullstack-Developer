class Admin::UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :update, :destroy ]

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Account created successfully"
      redirect_to admin_dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      @user.attach_avatar_from_url if @user.avatar_url.present?
      flash[:notice] = "Account updated successfully"
      redirect_to admin_user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = "Account successfully deleted"
      redirect_to admin_dashboard_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "User not found"
    redirect_to root_path
  end

  def user_params
    user_p = params.require(:user).permit(:email, :full_name, :password, :role, :avatar_image, :avatar_url)
    user_p[:role] = User.roles.key(user_p[:role].to_i) if user_p[:role].present?
    user_p
  end
end
