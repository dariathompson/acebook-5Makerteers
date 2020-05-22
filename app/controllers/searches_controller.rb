# frozen_string_literal: true

class SearchesController < ApplicationController
  def search
    if params[:query].blank?
      redirect_to(root_path, alert: 'Empty Search!') && return
    else
      @parameter = params[:query].downcase
      @user_results = User.all.where('lower(name) LIKE :search OR lower(username) LIKE :search', search: @parameter)
      @post_results = Post.all.where('lower(message) LIKE :search', search: @parameter)
    end
  end
end
