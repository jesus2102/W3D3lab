require('pg')
require_relative('../db/sql_runner')

class Album

def initialize(options)
  @id = options['id'].to_i if options['id']
  @title = options['title']
  @artist_id = options['artist_id'].to_i
end

def save()
  sql = "INSERT INTO album (title, artist_id) VALUES($1, $2) RETURNING id"
  values = [@title, @artist_id]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
end

def self.all()
  sql = "SELECT * FROM album"
  albums = SqlRunner.run(sql)
  return albums.map{|album| Album.new(album)}
end


end
