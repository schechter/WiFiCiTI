User.delete_all
Hotspot.delete_all
Rating.delete_all
#Hotspot.delete_all

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
#seeds DB
data_response = HTTParty.get('https://nycopendata.socrata.com/api/views/ehc4-fktp/rows.json?accessType=DOWNLOAD')
json = JSON.parse(data_response.body)
records = json['data']
records.each do |record|
  Hotspot.create(
    name: record[10],
    street: record[12],
    city: record[13],
    zip: record[14],
    phone: record[15],
    fee: record[16],
    url: record[17],
    latitude: record[9][1],
  longitude: record[9][2])
end
