# @summary This manifest ensures that gpgcheck is turned on globally
#  for Yum
#
# This manifest searches through /etc/yum.conf looking for a line that starts
# with the line "gpgcheck". If that line exists and has any other value than
# "gpgcheck=1", it will regex replace that line with the appropriate value.
# If the line does not exist, it adds it into the file.
#
# @example
#   include cis::gpgcheck
class cis::gpgcheck {

  include stdlib
  include purge

  # Ensure gpgcheck is globally activated - Section 1.2.3
  file_line { 'gpgcheck':
    ensure => 'present',
    path   => '/etc/yum.conf',
    line   => 'gpgcheck=1',
    match  => '^gpgcheck\=',
  }

  # Ensure gpgcheck is not off in every Yum repo
  purge { 'yumrepo':
    manage_property => 'gpgcheck',
    state           => '1',
  }

}
