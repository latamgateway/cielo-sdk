module Cielo
  module API30
    # 3DS Verification Data
    #
    # @attr [String] cavv Signature that is returned in authentication success scenarios
    # @attr [String] xid XID returned in authentication process (3DS version 1 only)
    # @attr [String] eci E-Commerce Indicator returned in authentication process
    # @attr [String] reference_id RequestID returned in authentication process
    # @attr [String] version 3DS version used in authentication process

    class ExternalAuthentication
      attr_accessor :cavv,
                    :xid,
                    :eci,
                    :reference_id,
                    :version

      def to_json(*options)
        hash = as_json(*options)
        hash.reject! {|k,v| v.nil?}
        hash.to_json(*options)
      end

      def self.from_json(data)
        return if data.nil?

        external_authentication = new
        external_authentication.cavv = data["Cavv"]
        external_authentication.xid = data["Xid"]
        external_authentication.eci = data["Eci"]
        external_authentication.reference_id = data["ReferenceID"]
        external_authentication.version = data["Version"]

        external_authentication
      end

      def as_json(options={})
        {
          Cavv: @cavv,
          Xid: @xid,
          Eci: @eci,
          ReferenceID: @reference_id,
          Version: @version
        }
      end
    end
  end
end
