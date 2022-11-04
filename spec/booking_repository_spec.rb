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
    context "get all bookings by guest" do
        it "should get a list of bookings the guest has made as an array of objects" do
            repo = BookingRepository.new
            # all_bookings_by_guest(1)
            bookings = repo.all_bookings_by_guest(1)
            
            # check that the method returns an array of bookings by that user
            expect(bookings.length).to eq(4)
            expect(bookings[0].space_id).to eq('2')
            # 06/11/2022
            expect(bookings[-1].date).to eq('06/11/2022')

        end
    end
    context "get all bookings for host" do
        it "should get a list of bookings for all spaces a host has as an array of objects" do
            repo = BookingRepository.new
            # bookings_for_host_spaces(host_id)
            host_bookings = repo.bookings_for_host_spaces(1)
            
            # check that the method returns an array of bookings by that to be checked by the Host
            expect(host_bookings.length).to eq(1)
            expect(host_bookings[0].space_id).to eq('2')
            # 06/11/2022
            expect(host_bookings[-1].date).to eq('05/11/2022')

        end
    end
    context "host :Update the booking status" do
        it "updated status should be reflected for that booking" do
            repo = BookingRepository.new
            # bookings_for_host_spaces(host_id)
            repo.approve_or_deny_booking(2,"Approved")
            host_bookings = repo.bookings_for_host_spaces(1)
            
            # check that the method returns updated value of status
            expect(host_bookings[0].status).to eq('Approved')
        end
    end
end