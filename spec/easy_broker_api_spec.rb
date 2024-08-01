require 'rspec'
require 'webmock/rspec'
require_relative '../easy_broker_api'  # Asegúrate de que este nombre coincida con tu archivo principal

RSpec.describe EasyBrokerAPI do
  before do
    @api_key = 'l7u502p8v46ba3ppgvj5y2aad50lb9'
    @buscador = EasyBrokerAPI.new(@api_key)
  end

  it 'fetches titles from the API' do
    # Simula una respuesta de la API con estado 200 y contenido vacío
    stub_request(:get, "https://api.stagingeb.com/v1/properties?page=1&limit=20")
      .with(headers: { 'Accept' => 'application/json', 'X-Authorization' => @api_key })
      .to_return(
        status: 200,
        body: { 'content' => [] }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    # Llama al método y verifica los resultados
    titles = @buscador.buscar_titulos
    expect(titles).to eq([])
  end
end
