# Controller for interacting with Administrative duties including User creation and Deletion
# This is a protected class and requires the user to login before it can access any of the functions
#
#
# @author Justin Barclay & Mackenzie Bligh
# @see https://github.com/CMPUT401/vettr_server/wiki/API-Documentation#user_authentication
class AdminsController < ApplicationController
  before_action :authenticate_admin

  # Handles POST request to create a invite a user, route /api/admin/invite
  # This is an unprotected route.
  # @example
  #   {
  #     "user": 
  #      { 
  #        "name": "User McUser",
  #        "email": "user@example.com",
  #      }
  #   }
  #
  # @example success
  #   {
  #     "success": true
  #   }
  # @example failure
  #   {
  #     "success": false
  #     "errors": [....]
  #   }
  #
  # @return HTTP 201 JSON, on success
  # @return HTTP 500 JSON, on failure
  def invite_user
    @user = User.new user_params
    @user.password = SecureRandom.uuid
    if @user.save
      UserMailer.invite_user(@user).deliver_now #Might be making a logical mistake, mailer not gauranteed to succeed
      render status: 200, json: { success: true }
    else
      render status: :error, json: { errors: @user.errors.full_messages }
    end
  end

  # Handles POST request to create a invite a user, route /api/admin/invite
  # This is an unprotected route.
  # This sends an email to the user with 
  # @example
  #   {
  #     "user": 
  #      { 
  #        "id": "integer",
  #      }
  #   }
  #
  # @example success
  #   {
  #     "success": true
  #   }
  # @example failure
  #   {
  #     "success": false
  #     "errors": [....]
  #   }
  #
  # @return HTTP 201 JSON, on success
  # @return HTTP 500 JSON, on failure
  def reset_user_password
    @user = User.find_by(id: user_params[:id])

    if @user.nil?
      render status: :error, json: { error: 'Can not find user' }
    else
      UserMailer.reset_password_email(@user).deliver_now
      render status: 200, json: { success: true }
    end
  end

  # Handles GET request to shwo the index of all users user, route /api/users
  # @example success
  #   {
  #     'success': true
  #     'users': [{'id': 'integer', 'name': 'string', 'email': 'string'}...]
  #   }
  # @return HTTP 200 JSON, on success
  def index
    users = filter_users User.all
    render status: 200, json: { success: true, users: users }
  end

  # Handles GET request to show a user, route /api/users/:id
  # @example
  #   {
  #     'success': true
  #     'user': 
  #      { 
  #        'name': 'string',
  #        'email': 'string',
  #      }
  #   }
  # @return HTTP 200, JSON
  # @return HTTP 404, JSON
  def show
    user = User.find_by(id: params[:id])
    if !user.nil?
      render status: 200, json: { success: true, user: filter_user(user) }
    else
      render status: 404, json: { success: false, error: 'User not found' }
    end
  end

  # Handles DELETE request for  a user, route /api/users/:id
  # @example
  #   {
  #     'success': true
  #   }
  # @return HTTP 200, JSON
  # @return HTTP 500, JSON
  # @return HTTP 404, JSON
  def delete
    user = User.find_by(id: params[:id])
    unless user.nil?
      if User.destroy(params[:id])
        render status: 200, json: { success: true, user: user }
      else
        render status: :error, json: {success: false, error: 'Unable to delete user' }
      end
    else
      render status: 404, json: { success: false, error: 'User not found' }
    end
  end
  
  private
  
  def filter_users(users)
    users.map do |user|
      { id: user.id, email: user.email, first_name: user.first_name, last_name: user.last_name, type: user.type }
    end
  end

  def filter_user(user)
    { first_name: user.first_name, last_name: user.last_name, email: user.email, type: user.type, id: user.id }
  end

  def new_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :type)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :id, :type)
  end
end
