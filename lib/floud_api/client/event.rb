
module FloudApi
  class Client
    # Floud external endpoints
    module Event
      def events(options = {})
        response = self.class.get(@api_prefix + 'Events/GetMyEvents',
                                 query: options)
        response.parsed_response
      end

      def guests(event_id, filters = {})
        response = self.class.post(@api_prefix + "Events/#{event_id}/Guests",
                                   body: filters.to_json,
                                   headers: { 'Content-Type' =>
                                                'application/json' })
        response.parsed_response
      end

      def guest_count(event_id, model = {})
        response = self.class.post(@api_prefix +
                                    "Events/#{event_id}/GuestCount",
                                   body: model.to_json,
                                   headers: { 'Content-Type' =>
                                                'application/json' })
        response.parsed_response
      end

      def event_stats(event_id)
        response = self.class.get(@api_prefix + "Events/#{event_id}/Stats")
        response.parsed_response
      end

      def event_details(event_id)
        response = self.class.get(@api_prefix + 'Events',
                                  query: { id: event_id })
        response.parsed_response
      end

      def all_events(options = {})
        response = self.class.get(@api_prefix + 'Events/All',
                                  query: options)
        response.parsed_response
      end

      def create_event(event_details)
        response = self.class.post(@api_prefix + 'Events/external',
                                   body:  event_details.to_json,
                                   headers: { 'Content-Type' =>
                                                'application/json' })

        response.parsed_response
      end

      def update_event(event_id, event_details)
        response = self.class.put(@api_prefix + "Events/#{event_id}/external",
                                   body:  event_details.to_json,
                                   headers: { 'Content-Type' =>
                                                'application/json' })

        response.parsed_response
      end      
    end
  end
end
