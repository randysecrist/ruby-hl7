# encoding: UTF-8
$: << '../lib'
require 'minitest/autorun'
require 'ruby-hl7'

class MsaSegment < MiniTest::Unit::TestCase
  def setup
    @base_msa = "MSA|AR|ZZ9380 ERR"
  end

  def test_storing_existing_segment
    seg = Ruby::HL7::Default.new( @base_msa )
    assert_equal( @base_msa, seg.to_s )
  end

  def test_to_s
    seg = Ruby::HL7::Default.new( @base_msa )
    assert_equal( @base_msa, seg.to_s )
    assert_equal( seg.to_s, seg.to_hl7 )
  end

  def test_create_raw_segment
    seg = Ruby::HL7::Default.new
    seg.e0 = "NK1"
    seg.e1 = "INFO"
    seg.e2 = "MORE INFO"
    seg.e5 = "LAST INFO"
    assert_equal( "NK1|INFO|MORE INFO|||LAST INFO", seg.to_s )
  end

end
