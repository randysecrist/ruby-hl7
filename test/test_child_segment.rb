# encoding: UTF-8
$: << '../lib'
require 'minitest/autorun'
require 'ruby-hl7'

class ChildSegment < MiniTest::Unit::TestCase
  def setup
    @base = open( './test_data/obxobr.hl7' ).readlines
  end

  def test_access_children
    msg = Ruby::HL7::Message.new @base
    refute_nil msg
    refute_nil msg[:OBR]
    assert_equal( 3, msg[:OBR].length ) 
    refute_nil msg[:OBR].first.children
    assert_equal( 5, msg[:OBR].first.children.length )

    msg[:OBR].first.children.each do |x|
      refute_nil x
    end
  end

  def test_add_children
    msg = Ruby::HL7::Message.new @base
    refute_nil msg
    refute_nil msg[:OBR]
    ob = Ruby::HL7::OBR.new
    refute_nil ob
    
    msg << ob
    refute_nil ob.children
    refute_nil ob.segment_parent
    assert_equal(msg, ob.segment_parent)
    orig_cnt = msg.length
    
    (1..4).each do |x|
      m = Ruby::HL7::OBX.new
      m.observation_value = "taco"
      refute_nil m
      refute_nil /taco/.match( m.to_s )
      ob.children << m
      assert_equal(x, ob.children.length)
      refute_nil m.segment_parent
      assert_equal(ob, m.segment_parent)
    end
    
    refute_equal( @base, msg.to_hl7 )
    refute_equal( orig_cnt, msg.length )
    text_ver = msg.to_hl7
    refute_nil /taco/.match( text_ver )
  end
end

