require 'floud_api/client/event'
require 'floud_api/client/account'
require 'floud_api/client/organization'
require 'pp'
require 'httmultiparty'

module FloudApi
  # Client module
  class Client
    attr_accessor :external_token
    attr_accessor :access_token
    attr_accessor :refresh_token
    attr_accessor :api_prefix
    attr_accessor :host
    include HTTMultiParty
    # include HTTParty
    # debug_output $stdout
    include FloudApi::Client::Event
    include FloudApi::Client::Account
    include FloudApi::Client::Organization

    base_uri ''

    format :json

    def initialize(phone = FloudApi.configuration.phone_number, prefix = 'FIN', confirmation_code = nil, refresh = FloudApi.configuration.refresh_token)
      @api_prefix = '/api/v1/'
      @host = FloudApi.configuration.host
      self.class.base_uri @host
      @external_token = FloudApi.configuration.external_token
      @phone_number = phone
      @client_id = FloudApi.configuration.client_id
      @client_secret = FloudApi.configuration.client_secret
      @refresh_token = refresh
      if @refresh_token.nil? && confirmation_code.nil?
        verify_user(phone, prefix)
      elsif !confirmation_code.nil?
        confirm_code(confirmation_code)
      else
        @access_token = refresh_access_token
        if @access_token =='invalid_grant'
          @refresh_token = 'reconfirm_phone'
        end
      end
      self.class.default_options.merge!(headers: { 'Authorization' => "Bearer #{@access_token}" })
    end

    def resubmit_confirmation
      # puts 'sending to floud phone ' + @phone_number
      response = self.class.post('/api/v1/external/users/verify', body: {
                                  'PhoneNumber' => @phone_number,
                                  'PhonePrefixCode' => 'FIN'
                                })

      return puts JSON.parse(response.body)['error_description'] if JSON.parse(response.body)['error']
    end

    def confirm_code(code)
      # puts 'reconfirming code for ' + @phone_number +  ' with ' + code
      response = self.class.post('/token', body: {
                                   grant_type: 'password',
                                   username: @phone_number,
                                   password: code,
                                   client_id: @client_id,
                                   client_secret: @client_secret
                                 })
      if JSON.parse(response.body)['error']
        if JSON.parse(response.body)['error_description'] =~ /Password expired/
          resubmit_confirmation
          puts "Your phone number must be verified again, please check your SMS messages."
        else
          puts JSON.parse(response.body)['error_description']
        end
      else
        @refresh_token = JSON.parse(response.body)['refresh_token']
        FloudApi.configure do |config|
          config.refresh_token = @refresh_token
        end
        @access_token = JSON.parse(response.body)['access_token']
        self.class.default_options.merge!(headers: { 'Authorization' => "Bearer #{@access_token}" })        
      end
    end

    def refresh_access_token
      # puts 'getting new access token from refresh token ' + @refresh_token
      response = self.class.post('/token', body: {
                                   grant_type: 'refresh_token',
                                   username: @phone_number,
                                   client_id: @client_id,
                                   client_secret: @client_secret,
                                   refresh_token: @refresh_token
                                 })
      if JSON.parse(response.body)['error']
        return JSON.parse(response.body)['error']
      else
        # puts 'ok - refresh token is now ' + @refresh_token
        @refresh_token = JSON.parse(response.body)['refresh_token']
        FloudApi.configure do |config|
          config.refresh_token = @refresh_token
        end
        @access_token = JSON.parse(response.body)['access_token']
        self.class.default_options.merge!(headers:
                                           { 'Authorization' =>
                                            "Bearer #{@access_token}" })
      end
    end

    def verify_user(phone, prefix)
      # puts 'verifying phone...'
      response = self.class.post(@api_prefix + 'external/users/verify',
                                 body: {'PhoneNumber' => phone,
                                        'PhonePrefixCode' => prefix }.to_json,
                                 headers: { 'Content-Type' =>
                                              'application/json' })

      return true if response.code == 200
    end
  end
end
