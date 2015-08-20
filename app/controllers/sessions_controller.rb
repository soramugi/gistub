# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController

  protect_from_forgery :except => :create

  skip_before_action :login_required
  skip_before_action :nickname_required, only: [:destroy]

  def start
    return_to = params[:return_to] || root_path
    redirect_to url_for("#{root_path}auth/github?return_to=#{return_to}")
  end

  def failure
    respond_to { |format| format.html }
  end

  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.where(
        omniauth_provider: auth['provider'], 
        omniauth_uid:      auth['uid']
      ).first || User.create_with_omniauth(auth)

      user.update!(email: auth['info']['email'])

      session[:user_id] = user.id
      return redirect_to params[:return_to] if params[:return_to].present?
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to root_path
  end

end
