module SQID
  class ProcessPayment < Request
    # DEFAULT_PARAMS = {
    #   referenceID: ''
    #   amount: 0, #=============
    #   currency: 'AUD',
    #   customerName: '==========',
    #   customerHouseStreet: '-------',
    #   customerSuburb: '--------',
    #   customerCity: '=========',
    #   customerState: '11111',
    #   customerCountry: ,
    #   customerPostCode: ,
    #   customerMobile: ,
    #   customerEmail: ,
    #   cardNumber: ,
    #   cardExpiry: ,
    #   cardName: ,
    #   cardCSC:,
    # }.freeze

    # def self.make_payment(order)
    #   self.new(
    #     referenceID:,
    #     amount: order.item_total.to_s,
    #     customerName: order.bill_address.full_name,
    #     customerHouseStreet: order.bill_address.address1,
    #     customerSuburb: order.bill_address.city,
    #     customerCity: order.bill_address.city,
    #     customerCountry: order.bill_address.country.iso3,
    #     customerPostCode: order.bill_address.zipcode,
    #     customerSuburb: order.bill_address.city,
    #   )
    # end

    def initialize(params)
      @params = params
      super(process_params)
    end

    private

    def process_params
      params.dup.merge(sharp_params: params[:amount].to_s)
    end

    attr_accessor :params
  end
end

#      amount:, reference_id:, customer_name:, customer_house_street:, customer_suburb:, customer_city:,
#      customer_country:, customer_cost_code:, card_number:, card_expiry:, card_Name:, card_CSC:,
