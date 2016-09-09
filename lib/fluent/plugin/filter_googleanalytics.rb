module Fluent
  class GoogleAnalyticsFilter < Filter
    Fluent::Plugin.register_filter('googleanalytics', self)

    # Primary Splunk configuration parameters
    config_param :filter_on, :string, :default => 'hour', :required => true

    def configure(conf)
      super
    end

    def start
      super
    end

    def shutdown
      super
    end

    def filter(tag, time, record)
      result = record
      begin:
        timestring = time.to_time.strftime("%FT%T%:z")
        log.debug "filter_googleanalytics: time found for event is #{timestring}"
      rescue => e
        log.warn "failed to grep events", :error_class => e.class, :error => e.message
        log.warn_backtrace
      end
      result
    end
  end
end
