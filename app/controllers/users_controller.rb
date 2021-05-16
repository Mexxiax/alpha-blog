class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users =  User.paginate(page: params[:page], per_page: 5).order("id DESC")
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5).order("id DESC")
  end
  
  def new 
    @user = User.new
  end

  def edit 
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all articles associated deleted"
    if !current_user.admin?
      redirect_to root_path
    else
      redirect_to users_path
    end
  end

  def update
    return render 'edit' unless @user.update(user_params)
    flash[:notice] = "Your account information was successfully updated"
    redirect_to @user
  end

  def create
    @user = User.new(user_params)
    return render 'new' unless @user.save

    session[:user_id] = @user.id
    flash[:notice] = "Welcome to the Alpha Blog #{@user.username}!"
    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit your own user"
      redirect_to @user
    end
  end

end
