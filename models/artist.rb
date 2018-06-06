require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artist (name) VALUES($1) RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update()
    sql = "UPDATE artist SET (name) = ($1)"
    values = [@name]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM artist"
    artists = SqlRunner.run(sql)
    return artists.map{|person| Album.new(person)}
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    return albums.map {|album| Album.new(album)}
  end

  def delete()
    sql = "DELETE FROM artist WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM artist"
    SqlRunner.run(sql)
  end

  def self.artist_by_id(id_artist)
    sql = "SELECT * FROM artist WHERE id = $1"
    values = [id_artist]
    artist = SqlRunner.run(sql, values).first()
    p Artist.new(artist)
  end
end
