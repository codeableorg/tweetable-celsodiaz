require 'rails_helper'

describe 'Tweets', :type => :request do
  before do
    # Crea un usuario en la base de datos antes de los tests
    User.create!(name: 'Test User', email: 'test@example.com', password: 'password123', username: 'testuser')
  end
  describe 'index path' do
    it 'respond with http success status code' do
        get '/api/tweets'
        expect(response.status).to eq(200)
    end

    it 'returns a json with all tweets' do
        testino = User.first
        Tweet.create(body: 'Test text', user_id: testino.id)
        get '/api/tweets'
        tweets = JSON.parse(response.body)
        expect(tweets.size).to eq(1)
    end
  end
  describe 'show path' do
    it 'show path respond with http success status code' do
        # Crea un tweet en la base de datos antes de este test
        tweet = Tweet.create(body: 'Test text', user_id: User.first.id)

        # Realiza una solicitud GET al endpoint del tweet recién creado
        get "/api/tweets/#{tweet.id}"
        expect(response.status).to eq(200)
    end

    it 'respond with the correct genre' do
        tweet = Tweet.create(body: 'Test text', user_id: User.first.id)
        get api_tweet_path(tweet)
        actual_tweet = JSON.parse(response.body)
        expect(actual_tweet['id']).to eql(tweet.id)
    end

    it 'returns http status not found' do
        get '/api/tweets/:id', params: { id: 'xxx' }
        expect(response).to have_http_status(:not_found)
    end
  end
end

