require 'helper'

class TestWord < Test::Unit::TestCase
  context "word" do
    setup do
      @word = Lingq::Word.new("ru",{ "status"=> 0, 
                                     "fragment"=> "вперед и вы найдете его .",
                                     "term"=> "Его", 
                                     "id"=> 4259928, 
                                     "hint"=> "him" })
    end
    
    should "cache status" do
      assert_equal 0,@word.status
    end
    
    should "cache fragment" do
      assert_equal "вперед и вы найдете его .",@word.fragment
    end
    
    should "cache id" do
      assert_equal 4259928,@word.id
    end
    
    should "cache term" do
      assert_equal "Его",@word.term
    end
    
    should "cache hint" do
      assert_equal "him",@word.hint
    end
    
    should "cache language" do
      assert_equal "ru",@word.language
    end
  end
end