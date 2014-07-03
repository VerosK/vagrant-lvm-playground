
notify{"Started on  ${fqdn}": }

# install XFS programsfac
package{'xfsprogs':
  ensure => present
}

file {'/srv/backup':
  ensure => directory,
}

filesystem { '/dev/disk/by-id/scsi-SATA_VIRTUAL_second':
  ensure  => present,
  fs_type => 'xfs',
  require => Package['xfsprogs'],
}

mount {'/srv/backup':
  device => '/dev/disk/by-id/scsi-SATA_VIRTUAL_second',
  fstype => 'xfs',
  ensure => mounted,
  atboot => true,
  options => 'auto',
  require => Filesystem['/dev/disk/by-id/scsi-SATA_VIRTUAL_second'],
}