module Ruby
  module HL7
    VERSION = "0.5.1"
    def self.ParserConfig
      @parser_cfg ||= { :empty_segment_is_error => true }
    end
  end
end
