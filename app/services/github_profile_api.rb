# frozen_string_literal: true

require 'httparty'

class GithubProfileApi
  include ActiveModel::Validations
  include HTTParty

  attr_reader :username

  validates :username, presence: true

  def self.call(username)
    primary_data = self.primary_data(username)

    if primary_data != { message: 'Usuário não encontrado.' }
      repos = self.repos(username)
      primary_data.merge!(repos)
    else
      { message: 'Erro!' }
    end
  end

  def self.primary_data(username) # Adicionar novamente o personal access token, mas pelo environment
    response = HTTParty.get("http://api.github.com/users/#{username}", headers: { Authorization: '' })

    if response['login']
      ResponseGetGithubProfileSerializer.new(response).serialize_primary_data
    else
      { message: 'Usuário não encontrado.' }
    end
  end

  def self.repos(username)
    response = HTTParty.get("https://api.github.com/users/#{username}/repos", headers: { Authorization: '' })

    ResponseGetGithubProfileSerializer.new(response).serialize_repos
  end
end
