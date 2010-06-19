module Lingq
  class Lesson
    attr_reader :audio_url,:image_url,:id,:cards_count,:title,:language,:lingq_client
    def initialize(client,language_code,json)
      @lingq_client = client
      @language = language_code
      @audio_url = json["audio_url"]
      @image_url = json["image_url"]
      @id = json["id"]
      @cards_count = json["cards_count"]
      @title = json["title"]
    end
    
    def words
      return @words if @words
      @words = @lingq_client.words_for_lesson(self)
    end
  end
end