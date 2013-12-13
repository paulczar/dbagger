require 'test/unit'
require 'rest_client'
require 'dbagger'
require 'json'
require 'webmock/test_unit'

class DbaggerTest < Test::Unit::TestCase
  def stubs
    stub_request(:get, "http://api.server/users/gh_username").with(
      :headers => {
        'Accept'=>'*/*; q=0.5, application/xml',
        'Accept-Encoding'=>'gzip, deflate',
        'User-Agent'=>'Ruby'
      }
    ).to_return(
        :status => 200,
        :body => '{"login": "username","name": "name"}',
        :headers => {}
    )
    stub_request(:get, "http://api.server/users/gh_username/keys").with(
      :headers => {
        'Accept'=>'*/*; q=0.5, application/xml',
        'Accept-Encoding'=>'gzip, deflate',
        'User-Agent'=>'Ruby'
      }
    ).to_return(
      :status => 200,
      :body => '[{"id": 666,"key": "ssh-rsa blahblahblahimadirtytramp"}]',
      :headers => {}
    )
  end

  def test_dbagger
    stubs
    result = Dbagger.collect_data({:username=>"username", :groups=>"group", :github_api=>"http://api.server", :shell=>"shell", :gh_username=>"gh_username"})
    assert_equal result, {:id=>"username", :ssh_keys=>["ssh-rsa blahblahblahimadirtytramp"], :groups=>["group"], :shell=>"shell", :comment=>"name", :password=>"*"}
  end
end
