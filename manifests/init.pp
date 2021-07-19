# Manage local users
# All Data from Hiera only
#
#
class manage_users (
  $user_hash = $manage_users::params::user_hash,
  $group_hash = $manage_users::params::group_hash
){
if $group_hash != undef {
  create_resources (manage_users::resource_mkgroups, $group_hash)
}->
if $user_hash != undef {
  create_resources (manage_users::resource_mkuser, $user_hash)
  }
}
