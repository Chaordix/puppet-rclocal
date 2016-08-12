#puppet-rclocal

This module is used by other modules to update content in `/etc/rc.d/rc.local` or `/etc/rc.local`.

It will overwrite `/etc/rc.d/rc.local` or `/etc/rc.local`.

# Usage

Sample Hiera configuration

`serverone.yaml`

    ---
    classes:
      - rclocal
      - sssd
      - stdlib

Sample module

    class sssd {
      ::rclocal::register{ 'sssd': 
        content => "/usr/sbin/fstrim /\n/usr/sbin/fstrim /boot\n",
      }
    }
