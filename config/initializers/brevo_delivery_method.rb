require "net/http"
require "json"

class BrevoDeliveryMethod
  API_URL = URI("https://api.brevo.com/v3/smtp/email")

  def initialize(_settings = {})
  end

  def deliver!(mail)
    html_content =
      if mail.html_part
        mail.html_part.body.decoded
      else
        mail.body.decoded
      end

    payload = {
      sender: {
        name: "Biblioteca Municipal",
        email: ENV.fetch("GMAIL_USERNAME")
      },
      to: Array(mail.to).map { |email| { email: email } },
      subject: mail.subject,
      htmlContent: html_content
    }

    request = Net::HTTP::Post.new(API_URL)
    request["accept"] = "application/json"
    request["content-type"] = "application/json"
    request["api-key"] = ENV.fetch("BREVO_API_KEY")
    request.body = JSON.generate(payload)

    response = Net::HTTP.start(
      API_URL.host,
      API_URL.port,
      use_ssl: true,
      open_timeout: 10,
      read_timeout: 10
    ) do |http|
      http.request(request)
    end

    unless response.is_a?(Net::HTTPSuccess)
      raise "Erro Brevo #{response.code}: #{response.body}"
    end
  end
end

ActionMailer::Base.add_delivery_method :brevo_api, BrevoDeliveryMethod