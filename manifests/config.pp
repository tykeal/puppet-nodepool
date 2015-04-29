# == Class: nodepool::config
#
# Configures nodepool
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
class nodepool::config (
  $configuration,
  $group,
  $user
) {
  # Make sure the params are properly formatted
  validate_hash($configuration)
  validate_string($group)
  validate_string($user)
}
