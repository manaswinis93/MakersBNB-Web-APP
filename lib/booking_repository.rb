# Repository class
# (in lib/booking_repository.rb)
require_relative './booking'

class BookingRepository

    def create(user_id,space_id,date,status)

        check_sql = "SELECT * FROM bookings WHERE space_id = $1 AND date = $2;"
        check_results = DatabaseConnection.exec_params(check_sql, [space_id,date])
        if(check_results.ntuples < 1)

            sql = 'INSERT INTO bookings (space_id, user_id, date, status) VALUES ($1, $2, $3, $4)'
            sql_params = [space_id, user_id, date, status]
            DatabaseConnection.exec_params(sql, sql_params)

            booking = Booking.new
            booking.date=date
            booking.space_id=space_id
            booking.user_id=user_id
            booking.status=status

            return booking

        else

            return nil

        end

    end

end