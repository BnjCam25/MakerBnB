require 'date_repository'


def reset_dates_table
    seed_sql = File.read('spec/users_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end
  
  describe DateRepository do
    before(:each) do 
      reset_dates_table
    end

    it "returns all the dates" do
        repo = DateRepository.new

        result = repo.all

        expect(result.length).to eq 3

        expect(result[0].id).to eq '1'
        expect(result[0].start_date).to eq '2022-06-05'
        expect(result[0].end_date).to eq '2022-06-15'
        

        expect(result[1].id).to eq '2'
        expect(result[1].start_date).to eq '2022-06-20'
        expect(result[1].end_date).to eq '2022-06-25'
    end

    it "adds a date" do
        repo = DateRepository.new
        date = DateEntry.new

        date.start_date = '2022/10/10'
        date.end_date = '2022/10/20'

        repo.create(date, 1)

        dates = repo.all

        expect(dates.length).to eq 4

        expect(dates[3].start_date).to eq '2022-10-10'
        expect(dates[3].end_date).to eq '2022-10-20'
        repo = PropertyRepository.new
        property = repo.find_dates_by_id(1)
        expect(property.start_date.last).to eq '2022-10-10'  
        expect(property.end_date.last).to eq '2022-10-20' 
    end
end