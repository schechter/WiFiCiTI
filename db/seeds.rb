User.delete_all
#Hotspot.delete_all
Rating.delete_all
Hotspot.delete_all

[['Brian', '246 Mott st. Ny, Ny,'],
 ['General Assembly', '10 E 21st st. Ny, Ny,'],
 ['george', '97 Arden st, Ny, Ny,'],
 ['mike', "533 9th ave. Ny, Ny."],
 ['remy', '20 exchange, 10005'],
 ['lee', '533 9th ave. ny. ny.']].map do |user, location|
	User.create(name: user, location: location, password: 'foobar')
end


User.create(email: 'foo@example.com', password: 'bar', admin: true)