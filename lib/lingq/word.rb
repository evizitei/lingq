module Lingq
  class Word
    attr_accessor :hint,:term,:id,:fragment,:status,:language
    def initialize(language_code,json)
      @language = language_code
      @hint = json["hint"]
      @term = json["term"]
      @id = json["id"]
      @fragment = json["fragment"]
      @status = json["status"]
    end
    
    def params
      {:id=>@id,:hint=>@hint,:fragment=>@fragment,:status=>@status}
    end
  end
end