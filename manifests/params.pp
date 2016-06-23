# Private class
class ca_cert::params {
  case $::osfamily {
    'Debian': {
      $trusted_cert_dir = '/usr/local/share/ca-certificates'
      $update_cmd       = 'update-ca-certificates'
      $cert_dir_group   = 'staff'
      $ca_file_extension = 'crt'
    }
    'RedHat': {
      $trusted_cert_dir    = '/etc/pki/ca-trust/source/anchors'
      $distrusted_cert_dir = '/etc/pki/ca-trust/source/blacklist'
      $update_cmd          = 'update-ca-trust extract'
      $cert_dir_group      = 'root'
      $ca_file_extension = 'crt'
    }
    'Suse': {
      if $::operatingsystemmajrelease == '11'  {
        $trusted_cert_dir  = '/etc/ssl/certs'
        $update_cmd        = 'c_rehash'
        $ca_file_extension = 'pem'
      }
      else {
        $trusted_cert_dir  = '/etc/pki/trust/anchors'
        $update_cmd        = 'update-ca-certificates'
        $ca_file_extension = 'crt'
      }
      $cert_dir_group      = 'root'
    }
    default: {
      fail("Unsupported osfamily (${::osfamily})")
    }
  }
}
