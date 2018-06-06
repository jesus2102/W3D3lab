require('pry')
require_relative('models/artist')
require_relative('models/album')

  artist1 = Artist.new({
    'name' => 'Queen'
    })

  artist2 = Artist.new({
    'name' => 'Bon Jovi'
    })

  artist1.save()
  artist2.save()


  album1 = Album.new({
    'title' => 'A King of Magic',
    'artist_id' => artist1.id
    })
  album2 = Album.new({
    'title' => 'Lost Highway',
    'artist_id' => artist2.id
    })

  album1.save()
  album2.save()

  p "artist or album?:"
  variable = gets.chomp().to_s()
  if variable == "artist"
    p "Which ID?:"
    id_artist = gets.chomp().to_i()
    Artist.artist_by_id(id_artist)
  elsif variable == "album"
    p "Which ID?:"
    id_album = gets.chomp().to_i()
    Album.album_by_id(id_album)
  else
    p "Wrong value"
  end


  binding.pry
  nil
