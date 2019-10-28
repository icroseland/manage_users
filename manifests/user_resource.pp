# defined typee to create users
#
define manage_users::user_resourse(
  $ensure,
  $uid,
  $gid,
  $group_array,
  $home,
  $shell,
  $password,
  $ssh_id_rsa_pub,
  $ssh_id_rsa,
){
group { $name:
  ensure => $ensure,
  gid    => $gid,
  }
user { $name:
  ensure      => $ensure,
  uid         => $uid,
  gid         => $gid,
  groups      => $group_array,
  home        => $home,
  manage_home => true,
  password    => $password,
}
directory {"${home}/.ssh":
  ensure  => directory,
  owner   => $name,
  group   => $name,
  mode    => '0700',
  require => User[$name],
  }
if $ssh_id_rsa_pub != undef {
  file { "${home}/.ssh/id_rsa.pub":
    ensure  => file,
    owner   => $name,
    group   => $gid,
    mode    => '0700',
    content => $ssh_id_rsa_pub,
    require => File["${home}/.ssh"],
  }
}
if $ssh_id_rsa != undef {
  file { "${home}/.ssh/id_rsa":
    ensure  => file,
    owner   => $name,
    group   => $gid,
    mode    => '0700',
    content => $ssh_id_rsa,
    require => File["${home}/.ssh"],
    }
}


}
