# defined typee to create groups
#
define manage_users::resource_mkgroups(
  $ensure='present',
  $gid,
){
group { $name:
  ensure => $ensure,
  gid    => $gid,
  }
}