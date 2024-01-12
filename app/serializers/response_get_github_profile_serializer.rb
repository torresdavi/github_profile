class ResponseGetGithubProfileSerializer < ActiveModel::Serializer
  def serialize_primary_data
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

  def serialize_repos
    serialize ||= {}
    count = 0

    self.object.parsed_response.each do |item|
      unless count == 3
        serialize.merge!({repo_name: item['name'], full_repo_name: item['full_name'], private: item['private']})

        count += 1
      end
    end
    serialize
  end
end