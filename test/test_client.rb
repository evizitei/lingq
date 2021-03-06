require 'helper'

class TestClient < Test::Unit::TestCase
  context "" do
    setup do
      language_body = %Q{["ru","fr"]}
      stub_api("languages",language_body)
      @client = Lingq::Client.new("api-key")
    end
    
    context "new client" do
    
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
  
    context "prebuilt client for lesson call" do
      setup do
        body = %Q{[ { "audio_url": "http://m.lingq.com/media/_28/resources/contents/audio/2007/06/21/eating-out-3.mp3", "image_url": "http://m.lingq.com/media/_28/resources/contents/images/2008/08/26/Eating_Out_______.jpg", "id": 21730, "cards_count": 31, "title": "Part 3" }, 
                    { "audio_url": "http://m.lingq.com/media/_28/resources/contents/audio/2007/06/21/eating-out-2.mp3", "image_url": "http://m.lingq.com/media/_28/resources/contents/images/2008/08/26/Eating_Out________.jpg", "id": 21729, "cards_count": 5, "title": "Part 2" }, 
                    { "audio_url": "http://m.lingq.com/media/_28/resources/contents/audio/2007/06/21/eating-out-1.mp3", "image_url": "http://m.lingq.com/media/_28/resources/contents/images/2008/07/04/restaurant-120.jpg", "id": 21727, "cards_count": 19, "title": "Part 1" } ]}
        stub_api("ru/lessons",body)
        @lessons = @client.lessons
      end
    
      should "load an array of lessons" do
        assert_equal Lingq::Lesson,@lessons.first.class
      end
      
      should "load one lesson for each json hash" do
        assert_equal 3,@lessons.size
      end
    end
    
    context "prebuilt client for words call" do
      setup do
        body = %Q{[ { "status": 0, "fragment": "вперед и вы найдете его .", "term": "Его", "id": 4259928, "hint": "him" }, 
          { "status": 0, "fragment": "Официант, принесите нам счет , пожалуйста", "term": "Счет", "id": 4259923, "hint": "check " }, 
          { "status": 0, "fragment": "Легко сказать да трудно сделать.", "term": "трудно", "id": 4259919, "hint": "difficult" }, 
          { "status": 0, "fragment": "Легко сказать да трудно сделать.", "term": "Легко", "id": 4259916, "hint": "easily" }, 
          { "status": 0, "fragment": "стараться делать это с радостью .", "term": "радостью", "id": 4259915, "hint": "joy" }]}
        stub_api("ru/lingqs",body)
        @words = @client.words
      end
      
      should "load an array of lessons" do
        assert_equal Lingq::Word,@words.first.class
      end
      
      should "load one lesson for each json hash" do
        assert_equal 5,@words.size
      end
    end
    
    context "prebuilt client for words from lesson call" do
      setup do
        body = %Q{[ { "status": 0, "fragment": "вперед и вы найдете его .", "term": "Его", "id": 4259928, "hint": "him" }, 
          { "status": 0, "fragment": "Официант, принесите нам счет , пожалуйста", "term": "Счет", "id": 4259923, "hint": "check " }, 
          { "status": 0, "fragment": "Легко сказать да трудно сделать.", "term": "трудно", "id": 4259919, "hint": "difficult" }, 
          { "status": 0, "fragment": "Легко сказать да трудно сделать.", "term": "Легко", "id": 4259916, "hint": "easily" }, 
          { "status": 0, "fragment": "стараться делать это с радостью .", "term": "радостью", "id": 4259915, "hint": "joy" }]}
        @lesson = Lingq::Lesson.new(@client,"ru",{"id"=> 123})
        stub_api("ru/123/lingqs",body)
        @words = @client.words_for_lesson(@lesson)
      end
      
      should "load an array of lessons" do
        assert_equal Lingq::Word,@words.first.class
      end
      
      should "load one lesson for each json hash" do
        assert_equal 5,@words.size
      end
    end
    
    context "prebuilt client for updating a word" do
      setup do
        stub_regex_api(/ru\/lingqs/,"",:put)
        @word = Lingq::Word.new(@client,"ru",{ "status"=> 0, "fragment"=> "fragment", "term"=> "Его", "id"=> 4259928, "hint"=> "him" })
        @word.status = 1
        @client.expects(:system_call).with("curl -X PUT -d 'id=4259928;status=1;hint=him;fragment=fragment' http://www.lingq.com/api_v2/ru/lingqs/?apikey=api-key")
        @client.update_word!(@word)
      end

      should "not bomb" do
        assert true
      end
    end
  end
  
  
  def stub_api(path,body,method = :any)
    stub_request(method, "http://lingq.com/api_v2/#{path}/?apikey=api-key").to_return(:body => body, :status => 200,  :headers => { 'Content-Type' => "application/json; charset=utf-8" } )
  end
  
  def stub_regex_api(regex,body,method = :any)
    stub_request(method, regex).to_return(:body => body, :status => 200,  :headers => { 'Content-Type' => "application/json; charset=utf-8" } )
  end
end
