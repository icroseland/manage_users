# params for manage_users
#


$user_hash = lookup (
  {
    name   => 'manage_users::user_hash',
    merge  =>  { strategy => 'deep' },
    default_value => undef
  }
)