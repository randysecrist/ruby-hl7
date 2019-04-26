# encoding: UTF-8
$: << '../lib'
require 'time'
require 'minitest/autorun'
require 'ruby-hl7'

class SpeedParsing < MiniTest::Test
  def setup
    @msg = open( "./test_data/lotsunknowns.hl7" ).readlines
  end

  def test_large_unknown_segments
    start = Time.now
    doc = Ruby::HL7::Message.new @msg
    refute_nil doc
    ends = Time.now
    assert ((ends-start) < 1)
  end 
end                                               
