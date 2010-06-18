require 'helper'

class TestClient < Test::Unit::TestCase
  context "new client" do
    setup do
      body = %Q{[
          "ru", 
          "fr"
      ]}
      stub_request(:any, "http://lingq.com/api_v2/languages/?apikey=api-key").to_return(:body => body, :status => 200,  :headers => { 'Content-Type' => "application/json; charset=utf-8" } )
      @client = Lingq::Client.new("api-key")
    end
    
    should "cache languages being learned at creation" do
      assert_equal ["ru","fr"],@client.languages
      assert @client.learning_language?("ru")
      assert @client.learning_language?("fr")
    end 
    
    should "exclude languages not being learned" do
      assert !@client.learning_language?("en")
    end
    
    should "pick first in list as current language" do
      assert_equal "ru",@client.target_language
    end
    
    should "be able to change to another valid language" do
      @client.change_language!("fr")
      assert_equal "fr",@client.target_language
    end
    
  end
end
