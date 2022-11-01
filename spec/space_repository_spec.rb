require 'space_repository'

def reset_spaces_table
    seed_sql = File.read('spec/seeds/seeds_spaces.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end
  
  describe SpaceRepository do
    before(:each) do 
      reset_spaces_table
    end
    context " all method " do
        it "returns list of all spaces available " do
            repo = SpaceRepository.new
            spaces = repo.all

            expect(spaces.length).to eq(4)
            expect(spaces[0].id).to eq(1)
            expect(spaces[0].name).to eq('cottage_4')
            expect(spaces[0].description).to eq('some description')
            expect(spaces[0].price).to eq('200')
            expect(spaces[0].user_id).to eq(1)
        end
    end
    context " given a space id" do
        it "returns the space record for that id " do
            repo = SpaceRepository.new
            space = repo.find(1)
                    
            expect(space.id).to eq(1)
            expect(space.name).to eq('cottage_4')
            expect(space.description).to eq('some description')
            expect(space.price).to eq('200')
            expect(space.user_id).to eq(1)
        end
    end
    #
    context "when given details for a new space" do
        it "inserts a new space record into the spaces table" do
            repo = SpaceRepository.new

            space = Space.new
            space.name = 'cottage_5'
            space.description =  'Just description'
            space.price = 300
            space.user_id =  3
            repo.create(space)
            spaces = repo.all


            expect(spaces.length).to eq(5)
            expect(spaces[-1].id).to eq(5)
            expect(spaces[-1].name).to eq('cottage_5')
            expect(spaces[-1].description).to eq('Just description')
            expect(spaces[-1].price).to eq('300')
            expect(spaces[-1].user_id).to eq(3) #will be a session variable
        end
    end
  end