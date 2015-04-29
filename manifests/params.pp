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
  $group      = 'nodepool'
  $user       = 'nodepool'
  $user_home  = '/home/nodepool'
  $venv_path  = '/opt/venv-nodepool'
  $vcs_path   = '/opt/vcs-nodepool'
  $vcs_source = 'https://github.com/openstack-infra/nodepool.git'
  $vcs_type   = 'git'
}
