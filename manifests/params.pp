# == Class: nodepool::params
#
# Defaults and defines for use with nodepool
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
class nodepool::params {
  $configuration_file = '/etc/nodepool/nodepool.yaml'

  # user configuration
  $user      = 'nodepool'
  $group     = $user
  $user_home = "/home/${user}"

  # virtualenv info
  $venv_path = '/opt/venv-nodepool'

  # installation picker
  $install_via = 'pip'

  # vcs info
  $vcs_path   = '/opt/vcs-nodepool'
  $vcs_source = 'https://github.com/openstack-infra/nodepool.git'
  $vcs_type   = 'git'
  $vcs_ref    = undef
}
