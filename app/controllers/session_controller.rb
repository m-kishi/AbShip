class SessionController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:mail], params[:password])
      redirect_to(expense_path(year: Date.today.year, mnth: Date.today.month))
    else
      flash.now[:alert] = 'Login failed.'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:login, notice: 'Logged out.')
  end

end
