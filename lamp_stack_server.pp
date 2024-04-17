package { 'apache2':
  ensure => installed,
}

package { 'php':
  ensure => installed,
  notify  => Service['apache2'],
  require => [Package['apache2']],
}

package { 'libapache2-mod-php':
  ensure => installed,
  require => Package['apache2'],
}

package { 'php-cli':
  ensure => installed,
  require => Package['php'],
}

package { 'php-mysql':
  ensure => installed,
  require => [Package['php'], Package['mysql-server']],
}

package { 'mysql-server':
  ensure => installed,
}

file { '/var/www/html/phpinfo.php':
  ensure  => file,
  source  => '/home/tpham/tpham_inet4031_puppet_lab9/phpinfo.php',
  notify  => Service['apache2'],
  require => [Package['apache2']],
}

service { 'apache2':
  ensure => running,
  enable => true,
  require => [Package['apache2'], Package['php']]
}

service { 'mysql':
  ensure => running,
  enable => true,
  require => Package['mysql-server'],
}

package { 'mariadb-server':
  ensure => installed,
}

service { 'mariadb':
  ensure  => running,
  enable  => true,
  require => Package['mariadb-server'],
}
