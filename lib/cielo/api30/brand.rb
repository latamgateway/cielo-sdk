module Cielo
  module API30
    class Brand
      attr_accessor :merchant_order_id,
                    :provider,
                    :card_type,
                    :foreign_card

      def initialize(merchant_order_id)
        @merchant_order_id = merchant_order_id
      end

      def to_json(*options)
        hash = as_json(*options)
        hash.reject! {|k,v| v.nil?}
        hash.to_json(*options)
      end

      def self.from_json(data)
        return if data.nil?

        brand = new(data["MerchantOrderId"])
        brand.provider     = data["Provider"]
        brand.card_type    = data["CardType"]
        brand.foreign_card = data["ForeignCard"]
        brand
      end

      def as_json(options={})
        {
          MerchantOrderId: @merchant_order_id,
          Provider: @provider,
          CardType: @card_type,
          ForeignCard: @foreign_card
        }
      end
    end
  end
end
