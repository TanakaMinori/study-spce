require 'net/http'
require 'uri'
require 'rexml/document'

class PlacesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

  def search
    keyword = params[:keyword]
    @appid = ENV["YAHOO_APP_ID"]
    url = URI.parse(URI.escape("https://map.yahooapis.jp/search/local/V1/localSearch?appid=#{@appid}&query=#{keyword}&results=20&detail=full"))
    res = Net::HTTP.start(url.host, url.port, use_ssl: true){|http|
    http.get(url.path + "?" + url.query);}

    doc = REXML::Document.new(res.body)

    @names = doc.elements.each('YDF/Feature/Name'){|i|} 
    @geometries = doc.elements.each('YDF/Feature/Geometry/Coordinates'){|i|}
    @stations = doc.elements.each('YDF/Feature/Property/Station/Name'){|i|}
    @urls = doc.elements.each('YDF/Feature/Property/Detail/PcUrl1'){|i|}
    @addresses = doc.elements.each('YDF/Feature/Property/Address'){|i|}
    num = 0
    @places = []
    while num < 20 do
      unless @names[num].blank? 
        name = @names[num].text
        geometry = @geometries[num].text
        @lat = geometry.split(",")[0].to_f
        @lon = geometry.split(",")[1].to_f
        @station = @stations[num].text
        @url = @urls[num].text
        @address = @addresses[num].text
        a_place = {name: name, lat: @lat, lon: @lon, area: @station, url: @url, address: @address}
        @places << a_place
        num += 1
      else
        break
      end
    end
  end
  
  def index
    @appid = ENV["YAHOO_APP_ID"]
    @reviews = Review.all
    areas = []
    @locations = []
    
    @reviews.each do |review|
    area = review.place[:area_name]
    areas << area
    
    lon = review.place[:lon]
    lat = review.place[:lat]
    id = review.place[:id]
    place_name = review.place[:place_name]
    @locations << {lon: lon, lat: lat, id: id, placeName: place_name}
    end
    @areas = areas.uniq
    gon.locations = @locations
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
    @address = params[:address]
    @url = params[:url]
  end
  
  def edit
    @review = Review.find(params[:id])
    @place = Place.find(@review.place_id)
  end
  
  def update
    place = Place.find(params[:id])
    review = Review.find(params.require(:place)[:reviews_attributes]["0"][:id].to_i)
    
    place.update(place_params_update)
    review.update(review_params_update)
  end
  
  def create
    review_place = params.require(:place)[:place_name]
    
    if Place.find_by(place_name: review_place)
      @place_id = Place.find_by(place_name: review_place)[:id]
      Review.create(review_params)
    else
      Place.create(place_params)
    end
  end
  
  private
  def place_params
      params.require(:place).permit(:place_name, :address, :area_name, :lat, :lon, :url, reviews_attributes: [:category, :recommend_rate, :wifi_rate, :text, :user_id, :image])
  end
  
  def review_params
    params.require(:place)[:reviews_attributes]["0"].permit(:category, :recommend_rate, :wifi_rate, :text,:user_id, :image).merge(place_id: @place_id)
  end
  
  def place_params_update
    params.require(:place).permit(:area_name)
  end
  def review_params_update
  params.require(:place)[:reviews_attributes]["0"].permit(:category, :recommend_rate, :wifi_rate, :text, :user_id, :image)
  end
end
 