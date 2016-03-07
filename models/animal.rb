require 'pg'

class Animal

  attr_reader :name, :shop_id, :id, :species, :image_url
  @@db_info = { dbname: 'petstore', host: 'localhost' }

  def initialize(options) 
    @name = options["name"]
    @shop_id = options["shop_id"]
    @id = options["id"] || nil
    @species = options["species"]
    @image_url = options["image_url"]
  end

  def shop
    sql = "SELECT * FROM shops WHERE id = #{@shop_id}"
    result = Animal.run_sql(sql)
    Shop.new(result[0])
  end

  def save
    sql = "INSERT INTO animals ( 
      name,
      shop_id,
      species,
      image_url
      ) VALUES (
      '#{ @name }',
      '#{ @shop_id }',
      '#{ @species }',
      '#{ @image_url }'
      )"
    Animal.run_sql(sql)
  end

  def self.find(id)
   sql = "SELECT * FROM animals WHERE id = #{id.to_i}"
   result = Animal.run_sql(sql)
   return Animal.new(result[0])
  end

  def self.update(params)
    sql = "UPDATE animals SET name = '#{params['name']}', shop_id = '#{params['shop_id']}', species = '#{params['species']}', image_url = '#{params['image_url']}' WHERE id = '#{params['id']}'"
    return Animal.run_sql(sql)
  end

  private

  def self.run_sql(sql)
    begin
      db = PG.connect(@@db_info)
      result = db.exec(sql)
    ensure
      db.close
    end
    return result
  end

end