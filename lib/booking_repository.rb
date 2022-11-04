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

    def all_bookings_by_guest(guest_id)
        # selecting from the bookings table
        # where user_id==guest_id
        sql = "SELECT bookings.id, bookings.space_id, bookings.user_id, bookings.date, bookings.status, spaces.name
        FROM bookings
        JOIN spaces ON spaces.id = bookings.space_id
        AND bookings.user_id=$1"
        sql_params=[guest_id]
        sql_result = DatabaseConnection.exec_params(sql, sql_params)
        # return as array
        to_return = []
        sql_result.each do |record|
            booking = Booking.new
            booking.id=record["id"]
            booking.date=record["date"]
            booking.space_id=record['space_id']
            booking.space_name=record['name']
            booking.user_id=record["user_id"]
            booking.status=record['status']
            to_return << booking
        end
        return to_return

    end

    def bookings_for_host_spaces(host_id)
        # selects all spaces that host owns (user_id==host_id)
        # selects all bookings for those spaces (space_id==tbd)
        spaces_sql = 'SELECT * FROM spaces WHERE user_id = $1;'
        spaces_set = DatabaseConnection.exec_params(spaces_sql, [host_id])
        all_bookings = []
        spaces_set.each do |space|
            sql = 'SELECT bookings.id, bookings.space_id, bookings.user_id, bookings.date, bookings.status, spaces.name
            FROM bookings
            JOIN spaces ON spaces.id = bookings.space_id
            AND bookings.space_id = $1;'
            result_set = DatabaseConnection.exec_params(sql, [space["id"]])
            result_set.each do |record|
                booking = Booking.new
                booking.id=record["id"]
                booking.date=record["date"]
                booking.space_id=record['space_id']
                booking.space_name=record['name']
                booking.user_id=record["user_id"]
                booking.status=record['status']
                all_bookings << booking
            end
        end
        return all_bookings

    end

    def approve_or_deny_booking(booking_id,approve_or_deny)
        # update status to "approve_or_deny"
        # UPDATE Customers SET ContactName='Juan' WHERE Country='Mexico';
        sql = 'UPDATE bookings SET status = $1 WHERE id = $2;'
        DatabaseConnection.exec_params(sql, [approve_or_deny, booking_id])
    end

end