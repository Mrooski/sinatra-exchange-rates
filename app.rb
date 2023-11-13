require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)

  @currencies = parsed_data.fetch("currencies")

  erb(:home_page)

end

get("/:from_currency") do
  @first = params.fetch("from_currency")

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)

  @currencies = parsed_data.fetch("currencies")

  erb(:first)
end

get("/:from_currency/:to_currency") do
  @first = params.fetch("from_currency")
  @last = params.fetch("to_currency")

  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@first}&to=#{@last}&amount=1"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)
  @output = parsed_data.fetch("result")
  erb(:output)

end
