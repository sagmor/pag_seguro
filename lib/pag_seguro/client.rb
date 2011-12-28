module PagSeguro
  class Client
    API_HOST = "https://ws.pagseguro.uol.com.br/v2/"
    REDIRECT_URL = "https://pagseguro.uol.com.br/v2/checkout/payment.html?code="

    attr_accessor :email, :token

    def initialize(options)
      @email = options[:email]
      @token = options[:token]
    end

    def payment(attributes)
      payment = Payment.new(attributes)
      payment.client = self
      payment
    end

    def notification(params)
      Transaction.new(
        self.get("transactions/notifications/#{params[:notificationCode]}")["transaction"]
      )
    end

    def transaction(id)
      Transaction.new(
        self.get("transactions/#{id}")["transaction"]
      )
    end

    def redirect_url_for(code)
      REDIRECT_URL + code
    end

    def get(url,params = {})
      url = API_HOST+url

      params = params.merge({
        :email => self.email,
        :token => self.token
      })

      MultiXml.parse(
        RestClient.get(url, params)
      )
    end

    def post(url, data)
      url = API_HOST + url + "?email=#{self.email}&token=#{self.token}"
      headers = {
        :content_type => "application/xml; charset=UTF-8"
      }

      MultiXml.parse(
        RestClient.post(url, data, headers)
      )
    end
  end
end
