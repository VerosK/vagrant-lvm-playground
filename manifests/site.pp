
notify{"Started on  ${fqdn}": }

# Mount filesystem from $blockdevice to $mountpoint
# Create filesystem $fs_type if needed
# Create Icinga check
define foo_filesystem(
      $blockdevice,
      $mountpoint = $title,
      $fs_type = 'ext3',
    ) {

  # install mkfs.xfs if needed
  if $fs_type == 'xfs' {
    case $operatingsystem {
      'centos','redhat' : { $fs_package = 'xfsprogs' }
      'ubuntu': { $fs_package = 'xfsprogs' }
      default: { $fs_package = undef }
    }
  }

  if $fs_package and (!defined(Package[$fs_package])) {
    package {$fs_package:
      ensure => present,
      before => Filesystem[$blockdevice]
    }
  }

  file { $mountpoint:
    ensure => directory,
    before => Mount[$mountpoint],
  }

  filesystem { $blockdevice:
    ensure  => present,
    fs_type => $fs_type,
  }

r
  mount {$mountpoint:
    ensure  => mounted,
    device  => $blockdevice,
    fstype  => $fs_type,
    atboot  => true,
    options => 'auto',
    require => Filesystem[$blockdevice],
  }
}

foo_filesystem{'/srv/backup/':
  blockdevice => '/dev/disk/by-id/scsi-SATA_VIRTUAL_second',
  fs_type     => 'xfs',
}