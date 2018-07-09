require "cielo/api30/request/cielo_request"

module Cielo
  module API30
    module Request
      class QueryCardRequest < CieloRequest
        attr_accessor :environment
        private :environment

        def initialize(merchant, environment)
          super(merchant)
          @environment = environment
        end

        def execute(card_token)
          uri = URI.parse([@environment.api_query, "1", "card", card_token].join("/"))
          Cielo::API30::CreditCard.from_json(send_request("GET", uri))
        end
      end
    end
  end
end
