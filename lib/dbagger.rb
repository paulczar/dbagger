# The main Dbagger driver
class Dbagger
  # Connect to github API and grab user data
  #
  # Example:
  #  >> Dbagger.collect_data({...})
  #
  # Arguments:
  #   options: (Hash)

  require 'rest_client'
  require 'json'

  def self.collect_data(options)

    options[:github_api] ||= ENV['github_api'] ||= 'https://api.github.com'
    options[:shell] ||= '/bin/bash'
    options[:password] ||= '*'
    options[:gh_username] ||= options[:username]
    keys = []

    begin
      response = RestClient.get("#{options[:github_api]}/users/#{options[:gh_username]}")
    rescue => e
      return false
    end
    gituser = JSON.parse(response.body)

    return false if gituser['message'] == 'Not Found'

    begin
      response = RestClient.get("#{options[:github_api]}/users/#{options[:gh_username]}/keys")
    rescue => e
      return false
    end

    return false if response.body == 'Not Found'

    JSON.parse(response.body).each do |key|
      keys.push(key['key'])
    end

    return false if keys.empty?

    return {
      id: options[:username],
      ssh_keys: keys,
      groups: options[:groups],
      shell: options[:shell],
      password: options[:password],
      comment: gituser['name']
    }

  end

end
