class AdminUsersControllerController < ApplicationController

  layout 'admin'

  before_filter :confirm_logged_in

  def index
    list
    render ('list')
  end

  def list
    @users = AdminUser.sorted
  end

  def new
    @user = AdminUser.new
  end 

  def create
    # Instantiate a new object using form parameters
    @user = AdminUser.new(params[:user])
    # Save the object
    if @user.save
      # If save succeeds, redirect to the list action
      flash[:notice] = "User created successfully."
      redirect_to(:action => 'list')
    else
      # If save fails, redisplay the form so the user can fix the problem
      render('new')
    end
  end

  def edit
    @user = AdminUser.find(params[:id])
  end

  def update
    # Find an object using form parameters
    @user = AdminUser.find(params[:id])
    # Update the object
    if @user.update_attributes(params[:user])
      # If update succeeds, redirect to the list action
      flash[:notice] = "User updated successfully."
      redirect_to(:action => 'list')
    else
      # If save fails, redisplay the form so the user can fix the problem
      render('edit')
    end
  end

  def delete
    @user = AdminUser.find(params[:id])
  end

  def destroy
     AdminUser.find(params[:id]).destroy
     flash[:notice] = "It's dead Jim!"
     redirect_to(:action => 'list')
  end

end
