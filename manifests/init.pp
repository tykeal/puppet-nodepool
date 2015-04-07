# == Class: nodepool
#
# Manages OpenStack nodepool
#
# === Parameters
#
# [*manage_python*]
#   Should the module configure python and virtualenv
#
#   *Type*: boolean
#
#   *default*: false
#
# [*manage_vcsrepo*]
#   Should the module manage the vcsrepo call
#
#   *Type*: boolean
#
#   *default*: true
#
# === Variables
#
# === Examples
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
class nodepool (
  $manage_python  = $nodepool::params::manage_python,
  $manage_vcsrepo = $nodepool::params::manage_vcsrepo,
  $venv_path      = $nodepool::params::venv_path,
  $vcs_path       = $nodepool::params::vcs_path
) inherits nodepool::params {
  # Make sure that all the params are properly formatted
  validate_bool($manage_python)
  validate_bool($manage_vcsrepo)
  validate_absolute_path($venv_path)
  validate_absolute_path($vcs_path)

  anchor { 'nodepool::begin': }
  anchor { 'nodepool::end': }

  class { 'nodepool::install':
    manage_python  => $manage_python,
    manage_vcsrepo => $manage_vcsrepo,
  }

  include nodepool::config
  include nodepool::service

  Anchor['nodepool::begin'] ->
    Class['nodepool::install'] ->
    Class['nodepool::config'] ->
    Class['nodepool::service'] ->
  Anchor['nodepool::end']
}
