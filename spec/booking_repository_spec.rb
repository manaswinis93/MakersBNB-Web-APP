require 'booking_repository'

def reset_booking_table
    seed_sql = File.read('spec/seeds/seeds_bookings.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
end

describe BookingRepository do
    before(:each) do 
        reset_booking_table
    end
    context "create a booking" do
        it "should add a booking with the passed arguments" do
            
            repo = BookingRepository.new
            booking_result = repo.create(1,2,"02/11/2022","Requested")

            # check that the method has returned a booking instance
            expect(booking_result.date).to eq('02/11/2022')
            expect(booking_result.status).to eq('Requested')
        end
        it "should reject a booking that already exists" do
            
            repo = BookingRepository.new
            booking_result_first = repo.create(1,2,"02/11/2022","Requested")
            # attempting to create a duplicate booking
            booking_result_second = repo.create(1,2,"02/11/2022","Requested")

            # should return nil, as no booking could be created
            # due to it already existing
            expect(booking_result_second).to eq(nil)
        end
    end
end