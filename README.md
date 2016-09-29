# fluent-plugin-filter_googleanalytics, a plugin for [Fluentd](http://fluentd.org)

## Overview

***Google Analytics*** filter plugin.

A filter plugin for Fluentd to make sure only recent data (based on time) is sent to output queue.

## Configuration

```config
<source>
  @type googleanalytics
  id 'ga:GOOGLE_ANALYTICS_PROFILE_ID'
  start_date START_DATETIME
  end_date END_DATETIME
  dimensions 'ga:<metric>,'
  metrics 'ga:<metric>,ga:<metric>,...' #https://developers.google.com/analytics/devguides/reporting/core/v3/reference#metrics
  sort 'ga:<metric>'
</source>

<filter googleanalytics>
  type googleanalytics
  filter_on hour
  pos_file '/var/log/td-agent/last_filter_option.yml'
</filter>

<match **>
  type stdout
</match>
```

## config: filter_on

The date or time variable to filter on.
Possible values:
* day
* hour
* minute

This option is required.

## config: pos_file

The location of a local config-file which captures the last data written.
If the fluentd or td-agent restarts it will not read data which was already parsed.

* The default value is '/var/log/td-agent/last_filter_option.yml'.
* Make sure the user which runs td-agent or fluentd has write permissions to this folder.
* This option is not required

## ChangeLog

See [CHANGELOG.md](CHANGELOG.md) for details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2016 Coen Meerbeek. See [LICENSE](LICENSE) for details.
