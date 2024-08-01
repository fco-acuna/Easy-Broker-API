require 'uri'
require 'net/http'
require 'json'

# Define la clase EasyBrokerAPI
class EasyBrokerAPI

  # Iniciamos la clase
  def initialize(api_key)
    @api_key = api_key
  end

  # Método para extraer los titulos
  def buscar_titulos
    url = URI("https://api.stagingeb.com/v1/properties?page=1&limit=20")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["X-Authorization"] = @api_key
    response = http.request(request)
    data = JSON.parse(response.body)
    properties = data['content']
    properties.map { |property| property['title'] }
  end
end

# Código para ejecutar la clase y método
api_key = 'l7u502p8v46ba3ppgvj5y2aad50lb9'
buscador = EasyBrokerAPI.new(api_key)
titles = buscador.buscar_titulos
puts "Titles: #{titles}"
