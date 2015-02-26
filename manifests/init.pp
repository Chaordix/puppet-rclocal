class rclocal {
  $rclocal_file = '/etc/rc.d/rc.local'

  concat { $rclocal_file:
    owner => 'root',
    group => 'root',
    mode  => '0755'
  }

  concat::fragment{ 'rclocal_header':
    target  => $rclocal_file,
    content => "#!/bin/sh\n# Managed by puppet - do not modify\ntouch /var/lock/subsys/local\n",
    order   => '01'
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
