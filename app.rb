require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "cdd0def2e32890be9e721b76f2fb46e5"

get "/" do
  # show a view that asks for the location
    view "ask"
end

get "/news" do
  # do everything else
    results = Geocoder.search(params["location"])
    @lat_long = results.first.coordinates # => [lat, long]

    # lat = lat_long[0]
    # long = lat_long[1]
    # "#{lat_long[0]} #{lat_long[1]}"  
    # puts @lat_long
 
end