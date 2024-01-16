# frozen_string_literal: true

class GithubController < ApplicationController
  def index; end

  def search
    @result = GithubProfileApi.call(search_params[:username])

    respond_to do |format|
      if @result[:login]
        format.html { render layout: false }
        format.json { render json: @result }
      else
        format.html { render layou: false }
        format.html { render jsons: { errors: @result[:errors][:message], status: 404 }, status: 404 }
      end
    end
  end

  private

  def search_params
    params.permit(:username)
  end
end
