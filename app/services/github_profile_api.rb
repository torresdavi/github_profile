require 'httparty'

class GithubProfileApi
  include ActiveModel::Validations
  include HTTParty

  attr_reader :username

  validates :username, presence: true

  def self.call(username)
    primary_data = self.primary_data(username)
    repos = self.repos(username)

    primary_data.merge!(repos)
  end

  private

  def self.primary_data(username)
    response = HTTParty.get("http://api.github.com/users/#{username}")

    primary_data = ResponseGetGithubProfileSerializer.new(response).serialize_primary_data
  end

  def self.repos(username)
    response = HTTParty.get("https://api.github.com/users/#{username}/repos")

    repos = ResponseGetGithubProfileSerializer.new(response).serialize_repos
  end
end