module Lingq
  class Lesson
    attr_reader :audio_url,:image_url,:id,:cards_count,:title,:language
    def initialize(language_code,json)
      @language = language_code
      @audio_url = json["audio_url"]
      @image_url = json["image_url"]
      @id = json["id"]
      @cards_count = json["cards_count"]
      @title = json["title"]
    end
  end
end