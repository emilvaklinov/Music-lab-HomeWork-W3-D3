require_relative('db/sql_runner')

class Artists

  attr_reader :id, :name
  attr_writer :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO Artists (name) VALUES ($1)
    RETURNING id"
    values = [ @name ]
    customers = SqlRunner.run(sql, values)
    @id = customers[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM Artists"
    results = SqlRunner.run(sql)
    return results.map { |result| Albums.new(result) }
  end

  def albums()
    sql = "SELECT * FROM Albums WHERE artist_id = $1"
    values = [@id]
    array_of_hashes = SqlRunner.run(sql,values)
    return array_of_hashes.map { |album_hash| Albums.new(album_hash) }
  end

  def update()
    sql = "UPDATE customers SET
    name
    =
    $1
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM Artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM Artists"
    SqlRunner.run(sql)
  end

  def self.find(id)
     sql = "SELECT * FROM Artists WHERE id = $1"
     values = [id]
     artists = SqlRunner.run(sql,values)
     artist = Artists.new(artist.first)
     return artist
   end


end
