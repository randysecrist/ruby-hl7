require 'test/unit'
require 'ruby-hl7'

class MshSegment < Test::Unit::TestCase
  def setup
    @base_msh = 'MSH|^~\&|STAR|1154302487|TESTAPP|TESTHOSP|201105010200||ADT^A01|56364182|D|2.3|56364182||AL'
  end

  def test_create_msh
    assert_nothing_raised do
      msh = Ruby::HL7::MSH.new @base_msh
      assert_not_nil msh
      assert_equal @base_msh, msh.to_s
    end
  end

  def test_access_msh
    assert_nothing_raised do
      msh = Ruby::HL7::MSH.new @base_msh
      assert_equal '56364182', msh.message_control_id
      assert_equal 'ADT', msh.message_class
      assert_equal 'A01', msh.message_type
    end
  end

end
