require "cielo/api30/request/cielo_request"

module Cielo
  module API30
    module Request
      class SaveCardRequest < CieloRequest
        attr_accessor :environment
        private :environment

        def initialize(merchant, environment)
          super(merchant)
          @environment = environment
        end

        def execute(credit_card)
          uri = URI.parse([@environment.api, "1", "card"].join("/"))
          params = {}

          params["CustomerName"]   = credit_card.holder
          params["CardNumber"]     = credit_card.card_number
          params["Holder"]         = credit_card.holder
          params["ExpirationDate"] = credit_card.expiration_date
          params["Brand"]          = credit_card.brand

          Cielo::API30::CreditCard.from_json(send_request("POST", uri, params))
        end
      end
    end
  end
end
