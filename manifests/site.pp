
notify{"Started on  ${fqdn}": }

# install XFS programsfac
package{'xfsprogs':
  ensure => present
}

# create mountpoints
file{'/srv/test1':
  ensure => 'directory'
}
file{'/srv/test2':
  ensure => 'directory'
}


class {'lvm':
    volume_groups => {
      'second' => {
        physical_volumes => ['/dev/disk/by-id/scsi-SATA_VIRTUAL_second'],
        logical_volumes => {
          'test1' => {
            size => '128M',
            fs_type => 'xfs',
            mountpath => '/srv/test1',
            mountpath_require => true,

          },
          'test2' => {
            size => '128M',
            fs_type => 'ext3',
            mountpath => '/srv/test2',
            mountpath_require => false,
          },
        }
      }
    },

    require => Package['xfsprogs']
  }