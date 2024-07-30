require "kemal"
require "./rest_api"

catalogue = Catalogue.from_file "#{__DIR__}/data/titles.json"
rest_api = RestApi.new catalogue

def handle(resource : String, &action : Hash(String, String) -> Response)
  options resource do
  end
  get resource do |env|
    response = action.call env.params.query.to_h
    env.response.status_code = response.status_code
    response.content
  end
end

handle "/createCart" do |query|
  rest_api.create_cart
end

handle "/addToCart" do |query|
  rest_api.add_to_cart query
end

handle "/listCart" do |query|
  rest_api.list_cart
end

get "/checkOutCart" do
end

get "/listPurchases" do
end

Kemal.run
