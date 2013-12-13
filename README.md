dbagger
=======

dbagger is a ruby gem that will look up a user in the github API and create a databag that be be used by the [Users Cookbook](http://community.opscode.com/cookbooks/users) to manage users on Chef configured servers.

simply pass it the github username of the user and the groups you want them to be part of and it will print an appropriate databag to STDOUT which can be added to `chef` using the `knife` command including their SSH keys.


Usage
=====

Install
-------

`gem install dbagger`

CLI
---

Usage: `dbagger -u <username> -g <group1,group2>`

```
Options
    -u, --username USERNAME          Username you want to create
    -l, --gh-login USERNAME          Github username if different to --username
    -g, --groups GROUP1,GROUP2       Comma seperated list of groups to add user to
    -s, --shell '/bin/bash'          defaults to '/bin/bash' if not set
    -a, --api github_API_URI         defaults to 'https://api.github.com' if not set
    -p, --password $1$XXXXXX         encrypted password.  If left blank will set to '*'
    -h, --help                       help
```

### examples

#### Basic

```
$ ./dbagger -u dirtyharry -g cop,human

{id":"dirtyharry","ssh_keys":["ssh-rsa AAAAB3N.../sn+j"],"groups":["cop","human"],"shell":"/bin/bash","password":"*","comment":"Dirty Harry"}
```

#### Comprehensive

```
$ ./dbagger -u dirtyharry -g cop,human -l harry45 -s '/bin/zsh' -a 'http://github.lapd.com/api/v3' -p '$1$l7qLsKLx$0rVGl3CGEghjk6yo4KRXW0'

{id":"dirtyharry","ssh_keys":["ssh-rsa AAAAB3N.../sn+j"],"groups":["cop","human"],"shell":"/bin/zsh","password":"$1$l7qLsKLx$0rVGl3CGEghjk6yo4KRXW0","comment":"Dirty Harry"}
```

#### Use with knife

```
$ ./dbagger -u dirtyharry -g cop,human > /tmp/dirtyharry.json
$ knife data bag from file users /tmp/dirtyharry.json
Updated data_bag_item[users::dirtyharry]
```

Ruby
----

```
1.9.3-p448 :001 > require 'dbagger'
 => true
1.9.3-p448 :002 > Dbagger.collect_data(:username=>"dirtyharry", :groups=>["cop", "human"], :github_api=>"https://api.github.com", :shell=>"/bin/bash", :password=>"*", :gh_username=>"dirtyharry")
 => {:id=>"dirtyharry", :ssh_keys=>["ssh-rsa AAAAB3NzaC1yc2EAAAADAQAB...."], :groups=>["cop", "human"], :shell=>"/bin/bash", :password=>"*", :comment=>"Dirty Harry"}
 1.9.3-p448 :003 >
```

Testing
=======

```
bundle install
bundle exec rake test
```

Report Bugs
===========

use the github bugs thingy.


License and Author
==================

|                      |                                                    |
|:---------------------|:---------------------------------------------------|
| **Author**           | Paul Czarkowski (paul.czarkowski@rackspace.com)    |
|                      |                                                    |
| **Copyright**        | Copyright (c) 2013, Paul Czarkowski                |
| **Copyright**        | Copyright (c) 2013, Rackspace                      |


Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
