User.delete_all
#Hotspot.delete_all
Rating.delete_all

[['mike', "10 21st st. Ny, Ny."], ['remy', '20 exchange, 10005'], ['lee', '533 9th ave ny ny']].map do |user, location|
	User.create(name: user, location: location)
end


