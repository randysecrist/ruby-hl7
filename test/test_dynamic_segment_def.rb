# encoding: UTF-8
$: << '../lib'
require 'test/unit'
require 'ruby-hl7'

class DynamicSegmentDefinition < Test::Unit::TestCase
  def setup
  end

  def test_block_definition
    seg = Ruby::HL7::Segment.new do |s|
      s.e0 = "MSK"
      s.e1 = "1234"
      s.e2 = "5678"
    end

    assert_equal( "MSK|1234|5678", seg.to_s )
  end

  def test_ruby_block_initializer 
    seg = Ruby::HL7::Segment.new do
      e0 "MSK"
      e1 "1234"
      e2 "5678"
    end

    assert_equal( "MSK|1234|5678", seg.to_s )
  end

  def test_shouldnt_pollute_caller_namespace
    seg = Ruby::HL7::Segment.new do |s|
      s.e0 = "MSK"
      s.e1 = "1234"
      s.e2 = "5678"
    end

    assert_raises(NoMethodError) do
      e3 "TEST"
    end
    assert_equal( "MSK|1234|5678", seg.to_s )
  end
end
