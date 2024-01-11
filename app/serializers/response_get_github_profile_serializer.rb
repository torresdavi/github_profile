class ResponseGetGithubProfileSerializer < ActiveModel::Serializer
  def serialize
    serialize ||= {
      login: self.object['login'],
      name: self.object['name'],
      avatar_url: self.object['avatar_url'],
      followers: self.object['followers'],
      following: self.object['following'],
      public_repos: self.object['public_repos'],
      location: self.object['location']
    }
  end
end