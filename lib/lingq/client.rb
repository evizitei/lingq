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
    
  private
    def get_with_key(path,params={})
      self.class.get(path,{:query=>params.merge({:apikey=>@apikey})})
    end
  end
end