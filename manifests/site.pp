
notify{"Started on  ${fqdn}": }

physical_volume { '/dev/disk/by-id/scsi-SATA_VIRTUAL_second':
  ensure => present,
}

volume_group { "second":
  ensure           => present,
  physical_volumes => '/dev/disk/by-id/scsi-SATA_VIRTUAL_second',
}


logical_volume {"test_volume":
  ensure       => present,
  volume_group => 'second',
  size         => '512M',
}