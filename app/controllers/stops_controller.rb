class StopsController < ApplicationController
  def new
    
  end
	
	def create
		@place = Place.find_by(google_id: @google_id)

		unless @place.present?
			@place = Place.new({
        city: @city, 
        state: @state, 
        country: @country,
        google_id: @google_id,
        latitude: @latitude,
        longitude: @longitude
      })
			@place.photo_url = find_city_photo(@place.latitude, @place.longitude)
			@place.save
		end

		@trip = Trip.find_by(id: params[:trip_id])

		@trip.stops.create(place: @place)
	end

	def find_city_photo(latitude, longitude)

		results = flickr.places.findByLatLon(:lat => latitude, :lon => longitude)  
		place_id = results[0]["place_id"]
		photo_array = flickr.photos.search(:place_id => place_id, :tags => 'landmark', :sort => 'interestingness-desc')
		photo_id = photo_array[0]["id"]
		info = flickr.photos.getInfo(:photo_id => photo_id)  
		url = FlickRaw.url_b(info)  

		return url
	end
end
