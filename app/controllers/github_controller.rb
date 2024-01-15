class GithubController < ApplicationController
  def index; end

  def search
    @result = GithubProfileApi.call(search_params[:username])

    respond_to do |format|
      if @result
        format.html { render layout: false }
        format.json { render json: @result }
      else
        format.html { render html: @result.errors }
      end
    end
  end

  private

  def search_params
    params.permit(:username)
  end
end
