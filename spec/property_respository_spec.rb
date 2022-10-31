require 'property_repository'
require 'pg'

def reset_properties_table
  seed_sql = File.read('spec/properties_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe PropertyRepository do
  before(:each) do 
    reset_properties_table
  end

  it "gets an array of property obects" do

    repo = PropertyRepository.new

    properties = repo.all

    expect(properties.length).to eq 2

    expect(properties[0].id).to eq '1'
    expect(properties[0].name).to eq 'Sandsend'
    expect(properties[0].description).to eq 'Stunning appartment with a view of the sea front'
    expect(properties[0].price).to eq '200'

    expect(properties[1].id).to eq '2'
    expect(properties[1].name).to eq 'Quaint Cottage'
    expect(properties[1].description).to eq 'Sleepy little cottage with an apple orchard'
    expect(properties[1].price).to eq '150'
  end

  it "returns a single property object by id" do

    repo = PropertyRepository.new

    property = repo.find(1)

    expect(property.id).to eq '1'
    expect(property.name).to eq 'Sandsend'
    expect(property.description).to eq 'Stunning appartment with a view of the sea front'
    expect(property.price).to eq '200'
  end
end