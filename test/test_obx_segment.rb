# encoding: UTF-8
$: << '../lib'
require 'minitest/autorun'
require 'ruby-hl7'

class ObxSegment < MiniTest::Test
  def setup
    @base = "OBX||TX|FIND^FINDINGS^L|1|This is a test on 05/02/94."
  end

  def test_initial_read
    obx = Ruby::HL7::OBX.new @base
    assert_equal( "", obx.set_id ) 
    assert_equal( "TX", obx.value_type )
    assert_equal( "FIND^FINDINGS^L", obx.observation_id )
    assert_equal( "1", obx.observation_sub_id )
    assert_equal( "This is a test on 05/02/94.", obx.observation_value )
  end
                                          
  def test_creation
    obx = Ruby::HL7::OBX.new
    obx.value_type = "TESTIES"
    obx.observation_id = "HR"
    obx.observation_sub_id = "2"
    obx.observation_value = "SOMETHING HAPPENned"
  end
end
