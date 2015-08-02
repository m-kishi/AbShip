class UserController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  skip_before_filter :require_login, only: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :login, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      logout
      redirect_to :login, notice: 'Please login again.'
    else
      render :edit
    end
  end

  def destroy
    # dependent: :destroy では遅すぎるため直接削除
    ActiveRecord::Base.transaction do
      @user.expenses.delete_all
      @user.graphics.delete_all
      @user.balances.delete_all
      @user.privates.delete_all
      @user.summaries.delete_all
      @user.destroy
    end
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:mail, :password, :password_confirmation)
  end

end
