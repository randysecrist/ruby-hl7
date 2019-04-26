# encoding: UTF-8
$: << '../lib'
require 'minitest/autorun'
require 'ruby-hl7'

class MsaSegment < MiniTest::Test
  def setup
    @base_msa = "MSA|AR|ZZ9380 ERR"
  end

  def test_create_msa
    msa = Ruby::HL7::MSA.new( @base_msa )
    refute_nil( msa )
    assert_equal( @base_msa, msa.to_s )
  end

  def test_access_msa
    msa = Ruby::HL7::MSA.new( @base_msa )
    assert_equal( "AR", msa.ack_code )
    assert_equal( "ZZ9380 ERR", msa.control_id )
  end

end
