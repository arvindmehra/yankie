class SQID::Request
  DEFAULT_CREDS = {
    api_merchant_code: Rails.configuration.sqid['api_merchant_code'],
    api_key:           Rails.configuration.sqid['api_key'],
    api_passphrase:    Rails.configuration.sqid['api_passphrase']
  }.freeze

  DEFAULT_HEADERS = {
    'Content-Type' => 'application/json'
  }.freeze

  attr_reader :params, :creds

  def initialize(params = {})
    @params = params
    @creds  = params[:creds] || DEFAULT_CREDS
  end

  def call
    SQID::Response.new request
  end

  private

  def request
    @request ||= HTTParty.post(
      Rails.configuration.sqid['host'],
      body: build_request_params.to_json,
      headers: DEFAULT_HEADERS
    )
  end

  def build_request_params
    request_params = default_params.merge params
    request_params.merge(calculate_hash_value(request_params)).except(:sharp_params)
  end

  def calculate_hash_value(request_params)
    {
      hashValue: Digest::MD5.hexdigest(
        creds[:api_passphrase] +
        request_params[:sharp_params] +
        creds[:api_key]
      )
    }
  end

  def default_params
    {
      merchantCode: creds[:api_merchant_code],
      apiKey: creds[:api_key],
      hashValue: ''
    }
  end
end
