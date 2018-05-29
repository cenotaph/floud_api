require 'test_helper'

describe FloudApi::Client, :vcr do
  before(:all) do
    FloudApi.configure do |config|
      config.client_id = ENV['CLIENT_ID']
      config.client_secret = ENV['CLIENT_SECRET']
      config.phone_number = ENV['PHONE_NUMBER']
      config.refresh_token = ENV['REFRESH_TOKEN']
    end
    @client = FloudApi::Client.new
    ENV['REFRESH_TOKEN'] = @client.refresh_token
  end

  after(:each) do
    ENV['REFRESH_TOKEN'] = @client.refresh_token
  end  

  it 'should be able to connect and get access token' do
    expect(@client.access_token).wont_be_nil
  end
end
