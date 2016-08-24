class rclocal {
  case $::operatingsystem {
    'Debian', 'Ubuntu': {
      $rclocal_file = '/etc/rc.local'
    }
    'RedHat': {
      $rclocal_file = '/etc/rc.d/rc.local'
    }
    default: {
      fail("Module not supported on ${::operatingsystem}.")
    }

  concat { $rclocal_file:
    owner => 'root',
    group => 'root',
    mode  => '0755'
  }

  concat::fragment{ 'rclocal_header':
    target  => $rclocal_file,
    content => "#!/bin/sh\n# Managed by puppet - do not modify\n",
    order   => '01'
  }

  concat::fragment{ 'rclocal_exit':
    target  => $rclocal_file,
    content => "exit 0\n",
    order   => '99'
  }
}

# used by other modules to register themselves in the rclocal
define rclocal::register($content="", $order='10') {

  concat::fragment{ "rclocal_fragment_${name}":
    target  => $rclocal::rclocal_file,
    content => $content,
    order   => $order,
  }
}
