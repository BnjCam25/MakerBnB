require_relative 'date_entry'
class DateRepository
    def all
        dates = []

        sql = 'SELECT id, start_date, end_date FROM dates;'
        results = DatabaseConnection.exec_params(sql, [])

        results.each do |record|
            date = DateEntry.new
            date.id = record['id']
            date.start_date = record['start_date']
            date.end_date = record['end_date']

            dates<< date
        end
        return dates
    end

    def create(date)
        sql = 'INSERT INTO dates(start_date, end_date) VALUES ($1, $2);'

        DatabaseConnection.exec_params(sql, [date.start_date, date.end_date])
    end
end