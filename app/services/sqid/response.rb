module SQID
  class Response < ::OpenStruct
    def initialize(json_response)
      @response = JSON.parse(json_response.body) rescue {}
      super
      process_response!
    end

    def full_message
      @full_message ||= build_full_message
    end

    private

    def build_full_message
      if success
        'Payment approved'
      elsif validation_error
        'Payment validation errors'
      else
        message
      end
    end

    def process_response!
      self.status = response['sqidResponseCode']
      self.message = response['sqidResponseMessage']
      self.success = response['sqidResponseCode'].zero?
      self.failure = response['sqidResponseCode'].nonzero?.to_b
      self.validation_error = response['sqidResponseCode'] < 0
      self.declined_transaction = response['sqidResponseCode'] > 0
      self.receipt_id = response['receiptNo']
    end

    attr_accessor :response
  end
end
