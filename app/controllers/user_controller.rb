class UserController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  skip_before_filter :require_login, only: [:new, :create]

  # GET /user
  def index
    @users = User.all
  end

  # GET /user/new
  def new
    @user = User.new
  end

  # GET /user/1/edit
  def edit
  end

  # POST /user
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :login, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /user/1
  def update
    if @user.update(user_params)
      logout
      redirect_to :login, notice: 'Please login again.'
    else
      render :edit
    end
  end

  # DELETE /user/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:mail, :password, :password_confirmation)
    end
end
