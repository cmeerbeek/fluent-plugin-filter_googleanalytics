require 'yaml'

module Fluent
  class GoogleAnalyticsFilter < Filter
    Fluent::Plugin.register_filter('googleanalytics', self)

    # Primary Splunk configuration parameters
    config_param :filter_on, :string, :default => 'hour', :required => true
    config_param :pos_file , :string, :default => '/var/log/td-agent/last_filter_option.yml', :required => false

    def configure(conf)
      super

      filter_on = conf['filter_on']
      log.debug "filter_googleanalytics: filter data for dimension: #{filter_on}"

      pos_file = conf['pos_file']
      log.debug "filter_googleanalytics: get latest position from #{pos_file}"

      if File.exist? (pos_file)
        @last_filter = YAML.load_file(pos_file)
      else
        log.warn "filter_googleanalytics: position file does not exist."
        @last_filter = Hash['last_update' => 33]
      end

      log.debug "filter_googleanalytics: last_update filter value is #{@last_filter['last_update']}"
    end

    def start
      super
    end

    def shutdown
      super
    end

    def filter(tag, time, record)
      result = record

      begin
        timestring = Time.at(time).strftime("%FT%T%:z")
        correct_dt = DateTime.strptime(timestring.to_s, "%FT%T%:z")
        log.debug "filter_googleanalytics: correct_dt #{correct_dt}"

        record_dimension = correct_dt.send(filter_on)
        current_dimension = DateTime.now.send(filter_on)
        log.debug "filter_googleanalytics: record dimension is #{record_dimension} / current dimension is #{current_dimension} / last_update is #{@last_filter['last_update']}"

        if record_dimension != (current_dimension - 1) or record_dimension == @last_filter['last_update']
          log.debug "filter_googleanalytics: drop record!"
          result = nil
        end

        if result != nil
          @last_filter['last_update'] = record_dimension
          log.debug "filter_googleanalytics: last_update is #{record_dimension}"
          file_path = File.expand_path(File.dirname(__FILE__))
          File.open("#{pos_file}", File::WRONLY|File::CREAT) do |h| 
            h.write @last_filter.to_yaml
          end
        end
      rescue => e
        log.warn "failed to grep events", :error_class => e.class, :error => e.message
        log.warn_backtrace
      end

      result
    end
  end
end
