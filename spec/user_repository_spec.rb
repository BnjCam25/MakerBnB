require 'user_repository'
require 'pg'

def reset_users_table
  seed_sql = File.read('spec/users_seeds.sql')
  connection = DatabaseConnection.connect
  connection.exec(seed_sql)
  seed_sql = File.read('spec/properties_seeds.sql')
  connection.exec(seed_sql)
end

describe PropertyRepository do
  before(:each) do 
    reset_users_table
  end

    it "shows all users" do
        repo = UserRepository.new
        result = repo.all
        expect(result.length).to eq 3
    end

    it "creates a user with given information" do
        repo = UserRepository.new
        user = User.new
        user.name = "Jack Black"
        user.email = "jb@gmail.com"
        user.password = "987654321"
        repo.create(user)
        expect(repo.all.length).to eq 4
    end

end