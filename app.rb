require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
require 'pp'
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "cdd0def2e32890be9e721b76f2fb46e5"

url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9b54a87eb89f4628830626a44ff67370"
news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output

get "/" do
  # show a view that asks for the location
    view "ask"
end

get "/news" do
  # do everything else
    results = Geocoder.search(params["location"])
    @lat_long = results.first.coordinates # => [lat, long]

    @lat = @lat_long[0]
    @long = @lat_long[1]

    @forecast = ForecastIO.forecast(@lat,@long).to_hash

    @top_headlines = pp news

    # pp @top_headlines

    # puts @forecast["currently"]["summary"]    

    # current_summary = forecast["currently"]["summary"]
    # current_temp = forecast["currently"]["temperature"]
    
    # puts "Today it is #{forecast["currently"]["temperature"]} and #{forecast["currently"]["temperature"]}"     

    # forecast_array = forecast["daily"]["data"]
    
    # for weather_for_the_day in forecast_array
    # puts "A high temperature of #{weather_for_the_day["temperatureHigh"]} and #{weather_for_the_day["summary"]}."
    # end

    # "#{@lat_long[0]} #{@lat_long[1]}"  
    # puts @lat_long

    
    view "news"
end