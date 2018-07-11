require('pg')

class SqlRunner
  def self.run( sql, values = [])
    begin
      db = PG.connect({ dbname: 'music', host: 'localhost' })
      db.prepare("trala",sql)
      result = db.exec_prepared("trala", values)
    ensure
      db.close() if db != nil
    end
    return result
  end
end
