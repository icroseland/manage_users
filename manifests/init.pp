# Manage local users
# All Data from Hiera only
#
#
class manage_users (
){

$user_hash = lookup('manage_users::user_hash', { merge => 'hash'})
$group_hash = lookup('manage_users::group_hash', { merge => 'hash'})

if $group_hash != undef {
  create_resources (manage_users::resource_mkgroups, $group_hash)
}
if $user_hash != undef {
  create_resources (manage_users::resource_mkuser, $user_hash)
  }
}
