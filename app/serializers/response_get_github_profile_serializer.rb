class ResponseGetGithubProfileSerializer < ActiveModel::Serializer
  def serialize_primary_data
    serialize ||= {
      login: object['login'],
      name: object['name'],
      avatar_url: object['avatar_url'],
      followers: object['followers'],
      following: object['following'],
      public_repos: object['public_repos'],
      location: object['location']
    }
  end

  def serialize_repos
    count = 0

    serialize = object.parsed_response.map do |repo|
      { repo_name: repo['name'], full_repo_name: repo['full_name'], private: repo['private'] }
    end

    serialize = serialize.take(4).each_with_object({}) do |i, final_hash|
      final_hash[count] = i
      count += 1
    end
  end
end
