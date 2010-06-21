module Lingq
  class Word
    attr_accessor :hint,:term,:id,:fragment,:status,:language
    def initialize(client,language_code,json)
      @lingq_client = client
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
    
    def increment_status!
      @status += 1
      @lingq_client.update_word!(self)
    end
  end
end