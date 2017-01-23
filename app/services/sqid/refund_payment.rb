module SQID
  class RefundPayment < Request
    def initialize(params)
      @params = params
      super(process_params)
    end

    private

    def process_params
      params.dup.merge({ sharp_params: "#{params[:amount]}" })
    end

    attr_accessor :params
  end
end
