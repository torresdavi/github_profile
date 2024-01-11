require 'httparty'

class GithubProfileApi
  include ActiveModel::Validations
  include HTTParty

  attr_reader :username

  validates :username, presence: true

  def self.search_by_user_name(username)
    HTTParty.get("http://api.github.com/users/#{username}")
  end
end