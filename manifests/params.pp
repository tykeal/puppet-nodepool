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
  $manage_python = false
  $manage_vcsrepo = true
  $venv_path = '/opt/venv-nodepool'
  $vcs_path = '/opt/vcs-nodepool'
}
