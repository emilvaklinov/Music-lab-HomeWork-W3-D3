require_relative('db/sql_runner')

class Albums

  attr_accessor :artists_id, :name, :genre
  attr_reader :id

  def initialize(options)
    @artists_id = options['artists_id'].to_i
    @name = options['name']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO Albums
    (
      artists_id,
      name,
      genre
    ) VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@artists_id, @name, @genre]
    artists = SqlRunner.run(sql, values)
    @id = artists[0]["id"].to_i

  end

  def self.all()
    sql = "SELECT * FROM Albums"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Albums.new(album) }
  end

  def artist()
     sql = "SELECT * FROM Artists WHERE id = $1"
     values = [@artists_id]
     array_of_hashes = SqlRunner.run(sql,values)
     artist_hash = array_of_hashes[0]
     artist = Artist.new(artist_hash)
   return artist
   end

def update
  sql = "UPDATE Albums SET
  (
    artists_id,
    name,
    genre
  ) =
  (
    $1, $2, $3
  )
  WHERE id = $4 "
  values = [@artists_id, @name, @genre]
  artists = SqlRunner.run(sql, values)
  @id = artists[0]["id"].to_i

end

def delete()
  sql = "DELETE FROM Albums WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
    sql = "DELETE FROM Albums"
    SqlRunner.run(sql)
  end

  def self.find(id)
     sql = "SELECT * FROM Albums WHERE id = $1"
     values = [id]
     albums = SqlRunner.run(sql,values)
     album = Albums.new(albums.first)
     return album
   end

end
