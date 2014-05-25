# http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_statsd
class collectd::plugin::statsd (
  $ensure           = present,
  $host             = '::',
  $port             = 8125,
  $deletecounter    = undef,
  $deletetimers     = undef,
  $deletegauges     = undef,
  $deletesets       = undef,
  $timerpercentile  = undef,
) {

  if versioncmp($::collectd_version, 5.4) == -1 {
    fail('Only collectd v5.4 is supported!')
  }

  if $deletecounter   != undef { validate_bool($deletecounter) }
  if $deletetimers    != undef { validate_bool($deletetimers) }
  if $deletegauges    != undef { validate_bool($deletegauges) }
  if $deletesets      != undef { validate_bool($deletesets) }
  if $timerpercentile != undef { validate_re($timerpercentile, '^\d+(\.\d{1,2})?$') }

  validate_string($host)
  validate_re($port, '^\d+$')

  collectd::plugin {'statsd':
    ensure  => $ensure,
    content => template('collectd/plugin/statsd.conf.erb'),
  }
}
