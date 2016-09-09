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
