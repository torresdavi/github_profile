class GithubController < ApplicationController
  def index; end

  def search
    result = GithubProfileApi.search_by_user_name(search_params[:username])

    serialized = ResponseGetGithubProfileSerializer.new(result).serialize

    respond_to do |format|
      if result
        format.html { render html: serialized }
      else
        format.html
        format.json { render json: {error => 'Deu ruim'} }
      end
    end
  end

  private

  def search_params
    params.permit(:username)
  end
end
