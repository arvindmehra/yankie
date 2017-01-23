Spree::Payment.class_eval do
  # This is the unique ID for a transaction returned with a valid processPayment
  def receipt_id
    JSON.parse(response_code).fetch('receipt_id') # 100% exception
  end
end
