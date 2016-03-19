# == Class: nodepool::install
#
# Installs nodepool into the indicated virtualenv
#
# == Parameters
#
# [*group*]
#   The group that nodepool should operate as
#
#   *Type*: string
#
# [*user*]
#   The user that nodepool should operate as
#
#   *Type*: string
#
# [*user_home*]
#   The home directory for the nodepool user
#
#   *Type*: string (absolute path)
#
# [*venv_path*]
#   Fully qualified path to the virtualen that nodepool should be
#   installed into.
#
#   *Type*: string (absolute path)
#
# [*vcs_path*]
#   Fully qualified path to the vcs repo that nodepool will be checked
#   out into. Nodepool will install into the venv_path using pip
#
#   *Type*: string (absolute path)
#
# [*vcs_source*]
#   vcsrepo source path for nodepool.
#
#   *Type*: string (vcsrepo URL)
#
# [*vcs_type*]
#   vcsrepo requires a type to be passed to it
#
#   *Type*: string
#
# [*vcs_revision*]
#   The only optional parameter. This is the revision that the vcsrepo
#   configuration will use. The default of undef equates to use the
#   latest HEAD at all times
#
#   *Type*: string
#
# === Authors
#
# Andrew Grimberg <agrimberg@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2015 Andrew Grimberg
#
# === License
#
# @License Apache-2.0 <http://spdx.org/licenses/Apache-2.0>
#
class nodepool::install (
  Enum['pip', 'vcs'] $install_via,
  String $pip_package,
  String $pip_version,
  String $group,
  String $user,
  String $user_home,
  String $venv_path,
  String $vcs_path,
  String $vcs_source,
  String $vcs_type,
  Optional[String] $vcs_revision,
) {
  # Make sure params are properly passed
  validate_absolute_path($user_home)

  if ($vcs_revision != undef) {
    validate_string($vcs_revision)
  }

#  # add the vcsrepo
#  vcsrepo{ $vcs_path:
#    ensure   => present,
#    provider => $vcs_type,
#    source   => $vcs_source,
#    revision => $vcs_revision,
#  }
#
#  # update the virtualenv on changes to the vcsrepo
#  exec { "install nodepool into ${venv_path}":
#    command     => "source ${venv_path}/bin/activate; pip install .",
#    cwd         => $vcs_path,
#    subscribe   => Vcsrepo[$vcs_path],
#    provider    => shell,
#    path        => ['/usr/bin', '/usr/sbin'],
#    refreshonly => true,
#  }

  # setup the user and group
  group { $group:
    ensure => present,
  }

  user { $user:
    ensure     => present,
    home       => $user_home,
    shell      => '/bin/bash',
    gid        => $group,
    managehome => true,
    require    => Group[$group],
  }

  file { '/etc/nodepool':
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0740',
  }
}
