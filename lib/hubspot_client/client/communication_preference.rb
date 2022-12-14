# frozen_string_literal: true

module HubspotClient
  module Client
    class SubscriptionNotSuccessful < ClientBaseError; end
    class FetchDefinitionsNotSuccessful < ClientBaseError; end

    class CommunicationPreference
      include HTTParty
      base_uri 'https://api.hubapi.com'

      BASE_PATH = '/communication-preferences/v3'

      def definitions
        response = self.class.get("#{BASE_PATH}/definitions",
                                  headers: headers)

        return response if response.code == 200

        raise FetchDefinitionsNotSuccessful, response
      end

      def subscribe(properties)
        response = self.class.post("#{BASE_PATH}/subscribe",
                                   body: properties.to_json,
                                   headers: headers)

        return response if response.code == 200

        raise SubscriptionNotSuccessful, response
      end

      def headers
        { Authorization: "Bearer #{HubspotClient.configuration.access_token}",
          'Content-Type': 'application/json' }
      end
    end
  end
end
