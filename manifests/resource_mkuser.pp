# defined typee to create users
#
define manage_users::resource_mkuser(
  $ensure,
  $uid,
  $gid,
  $group_array=undef,
  $home,
  $shell,
  $password=undef,
  $ssh_id_rsa_pub=undef,
  $ssh_id_rsa=undef,
){
group { $name:
  ensure => $ensure,
  gid    => $gid,
  }
user { $name:
  ensure   => $ensure,
  uid      => $uid,
  gid      => $gid,
  groups   => $group_array,
  home     => $home,
  password => $password,
}
file { $home:
  ensure  => directory,
  owner   => $name,
  group   => $name,
  mode    => '0700',
  require => User[$name],
}
if ($ssh_id_rsa_pub != undef) and ($ssh_id_rsa != undef){ 
file {"${home}/.ssh":
  ensure  => directory,
  owner   => $name,
  group   => $name,
  mode    => '0700',
  require => File[$home],
  }
if $ssh_id_rsa_pub != undef {
  file { "${home}/.ssh/authorized_keys":
    ensure  => file,
    owner   => $name,
    group   => $gid,
    mode    => '0600',
    content => $ssh_id_rsa_pub,
    require => File["${home}/.ssh"],
  }
}
if $ssh_id_rsa != undef {
  file { "${home}/.ssh/id_rsa":
    ensure  => file,
    owner   => $name,
    group   => $gid,
    mode    => '0600',
    content => $ssh_id_rsa,
    require => File["${home}/.ssh"],
    }
}
}
exec { "move in .bash_logout ${name}":
  command => "/usr/bin/cp /etc/skel/.bash_logout ${home}",
  user    => $name,
  creates => "${home}/.bash_logout",
  require => File[$home],
}
exec { "move in .bash_profile ${name}":
  command => "/usr/bin/cp /etc/skel/.bash_profile ${home}",
  user    => $name,
  creates => "${home}/.bash_profile",
  require => File[$home],
}
exec { "move in .bashrc ${name}":
  command => "/usr/bin/cp /etc/skel/.bashrc ${home}",
  user    => $name,
  creates => "${home}/.bashrc",
  require => File[$home],
}
}
