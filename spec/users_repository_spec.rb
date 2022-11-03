require 'user_repository'
#add gem BCRYPT to handle password encryption
require 'bcrypt'

def reset_users_table
    seed_sql = File.read('spec/seeds/seeds_users.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end
  
  describe UserRepository do

    include BCrypt

    before(:each) do 
      reset_users_table
    end
  
    context "given a existing user email address" do
        it "find method returns single user record for that email address" do
            repo = UserRepository.new
            user = repo.find('qwerty@abc.com')
            
            expect(user.id).to eq('1')
            expect(user.email).to eq('qwerty@abc.com')	
            expect(user.password).to eq('asdfgh123')
        end
      end
    context "given a email address that does not exist" do   
        it " find method returns nil " do 
          repo = UserRepository.new
          user = repo.find('manas@abc.com')
          expect(user).to eq nil
      end
    end
    context "given a user record" do
       it "Create method returns nil if the user account already exists" do
        repo = UserRepository.new
        email = 'qwerty@abc.com'
        password = 'asdfgh123'
        expect(repo.create(email, password)).to eq nil
       end

        it "Create method inserts single user record " do
            repo = UserRepository.new
            email = 'jklhgf@asd.com'
            password = 'mnbvc123'
            repo.create(email, password)
            user_new = repo.find('jklhgf@asd.com')
            user_auth = repo.authenticate(email,password)

            expect(user_auth).to_not eq(false)
            expect(user_auth).to eq("3")
            expect(user_new.email).to eq('jklhgf@asd.com')
        end
    end
    context "check auth rejects an invalid password" do
      it "checks if the password entered is wrong" do
          repo = UserRepository.new
          email = 'jklhgf@asd.com'
          password = 'mnbvc123'
          repo.create(email, password)
          user_auth = repo.authenticate(email,"notpassword")

          expect(user_auth).to eq(false)
      end
    end


  end