Gem::Specification.new do |s|
  s.name = %q{dbagger}
  s.version = "0.1.4"
  s.date = %q{2013-12-12}
  s.summary = 'creates user databags from github api results'
  s.description = <<EOF
Command line tool to fetch user details including keys from the github API
and transform into a Chef Databag usable by the Chef Users cookbook.
EOF
  s.files = [
    "lib/dbagger.rb"
  ]
  s.executables = [
    'dbagger'
  ]
  s.authors = ["Paul Czarkowski"]
  s.email   = 'username.taken@gmail.com'
  s.homepage = 'http://github.com/paulczar/dbagger'
  s.license = 'apache2'
  s.require_paths = ["lib"]
  s.add_dependency 'rest-client', '~> 1.6.7'
end
