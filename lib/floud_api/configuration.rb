module FloudApi
  # Configuration parameters
  class Configuration
    attr_accessor :client_id, :host, :client_secret, :phone_number, :external_token, :refresh_token, :confirmation_code

    def initialize
      @host = nil
      @client_id = nil
      @client_secret = nil
      @phone_number = nil
      @external_token = nil
      @confirmation_code = nil
      @refresh_token = nil
    end
  end
end
