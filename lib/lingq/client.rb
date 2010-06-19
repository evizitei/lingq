require 'httparty'

module Lingq
  class Client
    include HTTParty
    base_uri 'lingq.com/api_v2'
    
    attr_reader :target_language
    attr_reader :languages
    
    def initialize(api_key)
      @apikey = api_key
      load_languages!
    end
    
    def learning_language?(language_code)
      @languages.index(language_code)
    end
    
    def load_languages!
      @languages = get_with_key('/languages/').parsed_response
      @target_language = @languages.first
    end
    
    def change_language!(language_code)
      @target_language = language_code if learning_language?(language_code)
    end
    
    def lessons
      get_with_language("lessons/").map{|hash| Lingq::Lesson.new(self,@target_language,hash)}
    end
    
    def words
      get_with_language("lingqs/").map{|hash| Lingq::Word.new(@target_language,hash)}
    end
    
    def words_for_lesson(lesson)
      change_language!(lesson.language)
      get_with_language("#{lesson.id}/lingqs/").map{|hash| Lingq::Word.new(@target_language,hash)}
    end
    
  private
    def get_with_key(path,params={})
      self.class.get(path,{:query=>params.merge({:apikey=>@apikey})})
    end
    
    def get_with_language(path,params={})
      get_with_key("/#{@target_language}/#{path}",params)
    end
  end
end