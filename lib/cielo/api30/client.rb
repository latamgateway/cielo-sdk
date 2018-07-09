module Cielo
  module API30
    #  The Cielo API SDK front-end
    class Client
      attr_accessor :merchant, :environment
      private :merchant, :environment

      # Create an instance of API client by choosing the environment where the
      # requests will be send
      #
      # @param merchant [Merchant] The merchant credentials
      # @param environment [Environment] The environment
      def initialize(merchant, environment = nil)
        environment ||= Environment.production

        @merchant = merchant
        @environment = environment
      end

      # Send the Sale to be created and return the Sale with tid and the status
      # returned by Cielo.
      #
      # @param sale [Sale] The preconfigured Sale
      # @return [Sale] The Sale with authorization, tid, etc. returned by Cielo.
      def create_sale(sale)
        Cielo::API30::Request::CreateSaleRequest.new(merchant, environment).execute(sale)
      end

      # Query a Sale on Cielo by paymentId
      #
      # @param payment_id [String] The payment_id to be queried
      # @return [Sale] The Sale with authorization, tid, etc. returned by Cielo.
      def get_sale(payment_id)
        Cielo::API30::Request::QuerySaleRequest.new(merchant, environment).execute(payment_id)
      end

      # Query the Brand on Cielo by CardBin
      #
      # @param card_bin [String] The 6 first card number
      # @return [Brand] The brand, returned by Cielo.
      def get_brand(card_bin)
        Cielo::API30::Request::QueryBrandRequest.new(merchant, environment).execute(card_bin)
      end

      # Save Card and Return Token
      # @param credit_card [CreditCard] The object CreditCard
      # @return [String] The card Token, returned by Cielo.
      def save_card(credit_card)
        Cielo::API30::Request::SaveCardRequest.new(merchant, environment).execute(credit_card)
      end

      # Get Saved card info
      # @param token [String] The generated token by Cielo
      # @return [Card] The Credit Card, returned By Cielo.
      def card_info(token)
        Cielo::API30::Request::QueryCardRequest.new(merchant, environment).execute(token)
      end

      # Cancel a Payment on Cielo by paymentId and speficying the amount
      #
      # @param payment_id [String] The payment_id to be queried
      # @param amount [Integer] Order value in cents
      # @return [Payment] The cancelled payment
      def cancel_payment(payment_id, amount=nil)
        request = Cielo::API30::Request::UpdateSaleRequest.new("void", merchant, environment)

        request.amount = amount

        request.execute(payment_id)
      end

      # Capture a Sale on Cielo by paymentId and specifying the amount and the
      # serviceTaxAmount
      #
      # @param payment_id [String] The payment_id to be captured
      # @param amount [Integer] Amount of the authorization to be captured
      # @param service_tax_amount [Integer] Amount of the authorization should be destined for the service charge
      # @return [Payment] The captured payment
      def capture_sale(payment_id, amount=nil, service_tax_amount=nil)
        request = Cielo::API30::Request::UpdateSaleRequest.new("capture", merchant, environment)

        request.amount = amount
        request.service_tax_amount = service_tax_amount

        request.execute(payment_id)
      end
    end
  end
end
