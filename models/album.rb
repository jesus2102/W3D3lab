require('pg')
require_relative('../db/sql_runner')

class Album

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO album (title, genre, artist_id) VALUES($1, $2, $3) RETURNING id"
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "UPDATE album SET (name, genre, artist_id) = ($1, $2, $3)"
    values = [@name, @genre, @artist_id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM album"
    albums = SqlRunner.run(sql)
    return albums.map{|album| Album.new(album)}
  end

  def artist()
    sql = "SELECT * FROM artist WHERE id = $1"
    values = [@artist_id]
    artist = SqlRunner.run(sql, values).first()
    return Artist.new(artist)
  end

  def delete()
    sql = "DELETE FROM album WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM album"
    SqlRunner.run(sql)
  end

  def self.album_by_id(id_album)
    sql = "SELECT * FROM album WHERE id = $1"
    values = [id_album]
    album = SqlRunner.run(sql, values).first()
    p Album.new(album)
  end
end
