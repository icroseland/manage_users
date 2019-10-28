# Manage local users
# All Data from Hiera only
#
#
class manage_users (
  $user_hash = $manage_users::params::user_hash,
){
if $user_hash != undef {
  create_resources (manage_users::user_resource, $user_hash)
  }
}
