module FloudApi
  class Client
    # Floud Organizations endpoint
    module Organization
      def get_organization(options = {})
        response = self.class.get(@api_prefix + 'Organizations', query: options)
        response.parsed_response
      end

      def create_organization(options = {})
        response = self.class.post(@api_prefix + 'Organizations', body: options)
        response.parsed_response
      end

      def update_organization(id, options = {})
        response = self.class.put(@api_prefix + 'Organizations', query: {id: id }, body: options)
        response.parsed_response
      end

      def my_organizations(options ={})
        response = self.class.get(@api_prefix + 'Organizations/GetMyOrganizations', query: options)
        response.parsed_response
      end
    end
  end
end
