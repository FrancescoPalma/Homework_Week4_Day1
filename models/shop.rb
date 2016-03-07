require 'pg'
require_relative 'animal.rb'

class Shop

  attr_reader :name, :address, :stock_type, :image_url, :id
  @@db_info = { dbname: 'petstore', host: 'localhost' }

  def initialize(params)
    @name = params['name']
    @address = params['address']
    @stock_type = params['stock_type']
    @image_url = params['image_url']
    @id = nil || params['id']
  end

  def animals
    sql = "SELECT * FROM animals WHERE shop_id=#{@id} ORDER BY name"
    data = Shop.run_sql(sql)
    result = data.map { |animal| Animal.new(animal) }
  end

  def self.all
    sql = "SELECT * FROM shops ORDER BY name"
    data = Shop.run_sql(sql)
    result = data.map { |shop| Shop.new(shop) }
  end

  def save
    sql = "INSERT INTO shops (
      name,
      address,
      stock_type
      )
      VALUES (
      '#{ @name }',
      '#{ @address }',
      '#{ @stock_type }'
      )"
    return Shop.run_sql(sql)
  end

  def self.find(id)
   sql = "SELECT * FROM shops WHERE id = #{id.to_i}"
   data = Shop.run_sql(sql)
   result = Shop.new(data[0])
  end

  def update
    sql = "UPDATE shops SET name='#{ @name }', address='#{ @address }', stock_type='#{ @stock_type }' WHERE id = #{@id}"
    return Shop.run_sql(sql)
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