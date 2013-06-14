User.delete_all
#Hotspot.delete_all
Rating.delete_all
Hotspot.delete_all

[['Brian', '246 Mott st. Ny, Ny,', 'abc@example.com'],
 ['General Assembly', '10 E 21st st. Ny, Ny,', 'abcd@example.com'],
 ['george', '97 Arden st, Ny, Ny,', 'abce@example.com'],
 ['mike', "533 9th ave. Ny, Ny.", 'abcf@example.com'],
 ['remy', '20 exchange, 10005', 'abcg@example.com'],
 ['lee', '533 9th ave. ny. ny.', 'abch@example.com']].map do |user, location, email|
	User.create(name: user, location: location, password: 'foobar', email: email)
end


u = User.new(name: 'foobar', location: '800 mott st, ny, ny', password: 'foobar', email: 'foo@example.com')

u.admin = true
u.save!