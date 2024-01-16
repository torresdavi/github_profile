# frozen_string_literal: true

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

  def self.primary_data(username)
    response = HTTParty.get("http://api.github.com/users/#{username}")

    if response['message'] && response['message'] == 'Not Found'
      return { errors: { message: 'Usuário não encontrado ou inválido.' } }
    end

    ResponseGetGithubProfileSerializer.new(response).serialize_primary_data
  end

  def self.repos(username)
    response = HTTParty.get("https://api.github.com/users/#{username}/repos")

    return {} if response['message'] && response['message'] == 'Not Found'

    ResponseGetGithubProfileSerializer.new(response).serialize_repos
  end
end
