require "cielo/api30/request/cielo_request"

module Cielo
  module API30
    module Request
      class QueryBrandRequest < CieloRequest
        attr_accessor :environment
        private :environment

        def initialize(merchant, environment)
          super(merchant)
          @environment = environment
        end

        def execute(card_bin)
          uri = URI.parse([@environment.api_query, "1", "cardBin", card_bin].join("/"))
          Cielo::API30::Brand.from_json(send_request("GET", uri))
        end
      end
    end
  end
end
