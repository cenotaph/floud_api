module FloudApi
  class Client
    # Floud external endpoints
    module Account
      def get_my_profile(options = {})
        response = self.class.get(@api_prefix + 'Account/GetMyProfile',
                                  query: options)
        response.parsed_response
      end

      def update_my_profile(profile_data)
        response = self.class.put(@api_prefix + 'Account/UpdateMyProfile',
                                   query:  profile_data)                   
        response.parsed_response
      end
    end
  end
end
