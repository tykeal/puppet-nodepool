# == Class: nodepool
#
# Manages OpenStack nodepool. It is expected that python build
# requirements are being managed outside of this module.
#
# === Parameters
#
# [*configuration*]
#   Hash that defines the configuration for nodepool.
#   This will get written to /etc/nodepool/nodepool.yaml so the hash
#   will be converted to YAML
#
#   *Type*: hash
#
#   *default*: none - this is a required parameter
# 
# === Variables
#
# [*group*]
#   The group that nodepool should operate as
#
#   *Type*: string
#
#   *default*: nodepool
#
# [*user*]
#   The user that nodepool should operate as
#
#   *Type*: string
#
#   *default*: nodepool
#
# [*user_home*]
#   The home directory for the nodepool user
# 
#   *Type*: string (absolute path)
#
#   *default*: /home/nodepool
#
# [*venv_path*]
#   Fully qualified path to the virtualenv that nodepool should be
#   installed into. The virtualenv is not managed by this module. It is
#   recommend that a module such as stankevich/python be used to manage
#   in a virtualenv
#
#   *Type*: string (absolute path)
#
#   *default*: /opt/venv-nodepool
#
# [*vcs_path*]
#   Fully qualified path to the vcs repo that nodepool will be checked
#   out into. Nodepool will utilize the virtualenv to execute a pip
#   install out of this vcsrepo
#
#   *Type*: string (absolute path)
#
#   *default*: /opt/vcs-nodepool
#
# [*vcs_source*]
#   vcsrepo source path for nodepool.
#
#   *Type*: string (vcsrepo URL)
#
#   *default*: GitHub nodepool repo from OpenStack
#
# [*vcs_type*]
#   vcsrepo requires a type to be passed to it
#
#   *Type*: string
#
#   *default*: git
#
# [*vcs_revision*]
#   Revision to pass to the vcsrepo configuration
#
#   *Type*: string
#
#   *default*: undef (aka use latest HEAD)
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
  $configuration,
  $group          = $nodepool::params::group,
  $user           = $nodepool::params::user,
  $user_home      = $nodepool::params::user_home,
  $venv_path      = $nodepool::params::venv_path,
  $vcs_path       = $nodepool::params::vcs_path,
  $vcs_source     = $nodepool::params::vcs_source,
  $vcs_type       = $nodepool::params::vcs_type,
  $vcs_revision   = undef
) inherits nodepool::params {
  # Make sure that all the params are properly formatted
  validate_hash($configuration)
  validate_string($group)
  validate_string($user)
  validate_absolute_path($user_home)
  validate_absolute_path($venv_path)
  validate_absolute_path($vcs_path)
  validate_string($vcs_source)
  validate_string($vcs_type)

  if ($vcs_revision != undef) {
    validate_string($vcs_revision)
  }

  anchor { 'nodepool::begin': }
  anchor { 'nodepool::end': }

  class { 'nodepool::install':
    group        => $group,
    user         => $user,
    user_home    => $user_home,
    venv_path    => $venv_path,
    vcs_path     => $vcs_path,
    vcs_source   => $vcs_source,
    vcs_type     => $vcs_type,
    vcs_revision => $vcs_revision,
  }

  class { 'nodepool::config':
    configuration => $configuration,
    group         => $group,
    user          => $user,
  }

  include nodepool::service

  Anchor['nodepool::begin'] ->
    Class['nodepool::install'] ->
    Class['nodepool::config'] ->
    Class['nodepool::service'] ->
  Anchor['nodepool::end']
}
