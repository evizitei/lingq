require 'helper'

class TestLesson < Test::Unit::TestCase
  context "lesson" do
    setup do
      Lingq::Client.any_instance.stubs(:load_languages!)
      @client = Lingq::Client.new("apikey")
      @lesson = Lingq::Lesson.new(@client,"ru",{"audio_url"=>"http://m.lingq.com/media/_28/resources/contents/audio/2007/06/21/eating-out-3.mp3", 
                                   "image_url"=>"http://m.lingq.com/media/_28/resources/contents/images/2008/08/26/Eating_Out_______.jpg", 
                                   "id"=> 21730, "cards_count"=> 31, "title"=> "Part 3" })
    end
    
    should "cache audio url" do
      assert @lesson.audio_url =~ /eating-out-3\.mp3/
    end
    
    should "cache image url" do
      assert @lesson.image_url =~ /Eating_Out_______\.jpg/
    end
    
    should "cache id" do
      assert_equal 21730,@lesson.id
    end
    
    should "cache card count" do
      assert_equal 31,@lesson.cards_count
    end
    
    should "cache title" do
      assert_equal "Part 3",@lesson.title
    end
    
    should "cache language" do
      assert_equal "ru",@lesson.language
    end
    
    should "cache the client that created it" do
      assert_equal @client,@lesson.lingq_client
    end
    
    context "loading words" do
      setup do
        @client.expects(:words_for_lesson).with(@lesson).returns([Lingq::Word.new("ru",{})])
        @words = @lesson.words
      end
      
      should "load words from client" do
        assert_equal Lingq::Word,@words.first.class
        assert_equal @lesson.language,@words.first.language
        assert_equal 1,@words.size
      end
    end
  end
end