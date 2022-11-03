require_relative 'property'

class PropertyRepository

  # Selecting all records
  # No arguments
  def all
    properties = []
    # Executes the SQL query:
    sql = 'SELECT id, name, description, price FROM properties;'
    results = DatabaseConnection.exec_params(sql, [])
    results.each do |result|
      property = Property.new
      property.id = result['id']
      property.name = result['name']
      property.description = result['description']
      property.price = result['price']
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
    sql = 'SELECT id, name, description, price FROM properties WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    property.id = result[0]['id']
    property.name = result[0]['name']
    property.description = result[0]['description']
    property.price = result[0]['price']

    # Returns a single Property object.
    return property
  end


  def create(property)
    sql = "INSERT INTO properties (name, description, price) VALUES($1, $2, $3);"
    params = [property.name, property.description, property.price]
    DatabaseConnection.exec_params(sql, params)
  end

  def find_dates_by_id(id)


    properties = []

    sql = 'SELECT  properties.id, properties.name, properties.description, properties.price, 
      dates.start_date, dates.end_date
    FROM properties 
      JOIN property_dates ON property_dates.property_id = properties.id
      JOIN dates ON property_dates.date_id = dates.id
      WHERE properties.id = $1;'

      results = DatabaseConnection.exec_params(sql, [id])

      property = Property.new

      property.id = results[0]['id']
      property.name = results[0]['name']
      property.description = results[0]['description']
      property.price = results[0]['price']

      property.start_date = []
      property.end_date = []

      results.each do |record|
        property.start_date << record['start_date']
        property.end_date << record['end_date']
      end
      #property.start_date = start_date
      #property.end_date = end_date

      return property
  end
end
