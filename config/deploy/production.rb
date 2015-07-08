# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

# server '104.236.68.98', user: 'rails', roles: %w{web app db}

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
# set :ssh_options, {
#     user: 'root',
#     keys: %w(~/.ssh/id_rsa.pub),
#     forward_agent: false,
#     auth_methods: %w(publickey)
#   }
#
# And/or per server (overrides global)
# ------------------------------------
server '104.236.68.98',
  user: 'root',
  roles: %w{web app db},
  ssh_options: {
    keys: %w(~/.ssh/id_rsa),
    forward_agent: true,
    auth_methods: %w(publickey)
    # password: 'please use keys'
  }
