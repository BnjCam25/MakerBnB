require_relative 'property'

class PropertyRepository

  # Selecting all records
  # No arguments
  def all
    properties = []
    # Executes the SQL query:
    sql = 'SELECT id, name, description, price, user_id FROM properties;'
    results = DatabaseConnection.exec_params(sql, [])
    results.each do |result|
      property = Property.new
      property.id = result['id']
      property.name = result['name']
      property.description = result['description']
      property.price = result['price']
      property.user_id = result['user_id']
      properties << property
    end
    # Returns an array of Property objects.
    return properties
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    property = Property.new
    # Executes the SQL query:
    sql = 'SELECT id, name, description, price, user_id FROM properties WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    property.id = result[0]['id']
    property.name = result[0]['name']
    property.description = result[0]['description']
    property.price = result[0]['price']
    property.user_id = result[0]['user_id']

    # Returns a single Property object.
    return property
  end


  def create(property)
    sql = "INSERT INTO properties (name, description, price, user_id) VALUES($1, $2, $3, $4);"
    params = [property.name, property.description, property.price, property.user_id]
    DatabaseConnection.exec_params(sql, params)
  end
end
