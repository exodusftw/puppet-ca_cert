# Private class
class ca_cert::params {
  case $::osfamily {
    'debian': {
      $trusted_cert_dir = '/usr/local/share/ca-certificates'
      $update_cmd       = 'update-ca-certificates'
      $cert_dir_group   = 'staff'
      $ca_package       = 'ca-certificates'
      $cert_extension   = 'crt'
    }
    'redhat': {
      $distrusted_cert_dir = '/etc/pki/ca-trust/source/blacklist'
      $cert_dir_group      = 'root'

      case $::operatingsystemmajrelease {
        '5':  {
          $trusted_cert_dir    = '/etc/pki/tls/certs'
          $update_cmd          = 'c_rehash'
          $ca_package          = 'openssl-perl'
          $cert_extension      = 'pem'
          }
        default: {
          $trusted_cert_dir    = '/etc/pki/ca-trust/source/anchors'
          $update_cmd          = 'update-ca-trust extract'
          $ca_package          = 'ca-certificates'
          $cert_extension      = 'crt'
          }
      }
    }
    default: {
      fail("Unsupported osfamily (${::osfamily})")
    }
  }
}
