module SQID
  class Purchase
    def initialize(*_args)
    end

    # Refund
    def credit(money_cents, _creditcard, options = {})
      @response = SQID::RefundPayment.new(
        amount: build_amount(money_cents, cents: true),
        currency: 'AUD',
        methodName: 'refundPayment',
        receiptID: options[:originator].payment.receipt_id
      ).call

      process_response
    end

    # Pay
    def purchase(amount, credit_card_or_reference, options = {})
      @response = SQID::ProcessPayment.new(
        referenceID: options[:reference_id],
        amount: build_amount(amount),
        customerName: options[:full_name],
        customerHouseStreet: options[:address1],
        customerSuburb: options[:suburb],
        customerCity: options[:city],
        customerState: options[:state],
        customerCountry: options[:country],
        customerPostCode: options[:zipcode],
        cardNumber: options[:card_number],
        cardExpiry: options[:card_expiry],
        cardName: options[:card_name],
        cardCSC: options[:card_cvv],
        currency: 'AUD',
        methodName: 'processPayment',
        customField1: options[:description],
        customerEmail: options[:email],
        customerIP: options[:ip],
        creds: options[:creds]
      ).call

      process_response
    end

    private

    def process_response
      status = false
      message = 'Payment failed'

      if response
        status = response.success
        message = response.full_message
      end

      ActiveMerchant::Billing::Response.new(
        status,
        message, {},
        authorization: { receipt_id: response.receipt_id }.to_json,
        error_code: response
      )
    end

    def build_amount(amount, cents: false)
      amount /= 100.to_d if cents
      '%.2f' % amount
    end

    attr_accessor :response
  end
end
