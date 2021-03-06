require "logger"

module Ezid
  #
  # EZID client configuration.
  #
  # Use `Ezid::Client.configure` to set values.
  #
  # @api private
  #
  class Configuration

    HOST = "ezid.cdlib.org".freeze
    PORT = 443
    TIMEOUT = 300

    # EZID host name
    attr_accessor :host

    # EZID TCP/IP port
    attr_accessor :port

    # HTTP read timeout (seconds)
    attr_accessor :timeout

    # EZID user name
    attr_accessor :user

    # EZID password
    attr_accessor :password

    # Ruby logger instance
    attr_writer :logger

    # Default shoulder for minting (scheme + NAAN + shoulder)
    # @example "ark:/99999/fk4"
    attr_accessor :default_shoulder

    def initialize
      @user             = ENV["EZID_USER"]
      @password         = ENV["EZID_PASSWORD"]
      @host             = ENV["EZID_HOST"] || HOST
      @port             = ENV["EZID_PORT"] || PORT
      @timeout          = ENV["EZID_TIMEOUT"] || TIMEOUT
      @default_shoulder = ENV["EZID_DEFAULT_SHOULDER"]
    end

    def inspect
      ivars = instance_variables.reject { |v| v == :@password }
                                .map { |v| "#{v}=#{instance_variable_get(v).inspect}" }
      "#<#{self.class.name} #{ivars.join(', ')}>"
    end

    def logger
      @logger ||= Logger.new(STDERR)
    end

    def identifier
      Identifier
    end

    def metadata
      Metadata
    end

    def use_ssl
      warn "[DEPRECATION] `use_ssl` is deprecated and will be removed in ezid-client v2.0." \
           " EZID requires SSL as of April 30, 2017."
      true
    end

    def use_ssl=(*)
      warn "[DEPRECATION] `use_ssl=` is deprecated and will be removed in ezid-client v2.0." \
           " EZID requires SSL as of April 30, 2017."
    end

  end
end
