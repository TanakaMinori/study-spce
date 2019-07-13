require 'net/http'
require 'uri'
require 'rexml/document'

class PlacesController < ApplicationController
  
  def search
    keyword = params[:keyword]
    @appid = ENV["YAHOO_APP_ID"]
    url = URI.parse(URI.escape("https://map.yahooapis.jp/search/local/V1/localSearch?appid=#{@appid}&query=#{keyword}&results=10"))
    res = Net::HTTP.start(url.host, url.port, use_ssl: true){|http|
    http.get(url.path + "?" + url.query);}

    doc = REXML::Document.new(res.body)

    @names = doc.elements.each('YDF/Feature/Name'){|i|} 
    @geometries = doc.elements.each('YDF/Feature/Geometry/Coordinates'){|i|}
    @areas = doc.elements.each('YDF/Feature/Property/Area/Name'){|i|}
    num = 0
    @places = []
    while num < 10 do
      unless @names[num].blank? || @areas[num].blank?
        name = @names[num].text
        geometry = @geometries[num].text
        @lat = geometry.split(",")[0].to_f
        @lon = geometry.split(",")[1].to_f
        area = @areas[num].text
        a_place = {name: name, lat: @lat, lon: @lon, area: area}
        @places << a_place
        num += 1
      else
        break
      end
    end
  end
  
  def index
    areas = Place.select(:area_name, :id)
    @areas = areas.group(:area_name)
  end
  
  def show
    @place = Place.find(params[:id])
    @reviews = Review.where(place_id: params[:id])
    @appid = ENV["YAHOO_APP_ID"]
  end
  
  def new
    @place = Place.new
    @place.reviews.build
    @name = params[:name]
    @lat = params[:lat]
    @lon = params[:lon]
    @area = params[:area]
  end
  
  def create
    Place.create(place_params)
  end
  
  private
  def place_params
    params.require(:place).permit(:place_name, :address, :area_name, :lat, :lon, reviews_attributes: [:category, :recommend_rate, :wifi_rate, :text])
  end
end
 