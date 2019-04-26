# encoding: UTF-8
require 'minitest/autorun'
require 'ruby-hl7'

class BasicParsing < MiniTest::Test
  def setup
    @empty_txt = open( './test_data/empty.hl7' ).readlines.first
    @empty_segments_txt = open( './test_data/empty_segments.hl7' ).readlines.first
    @simple_msh_carriage_returns = open( './test_data/carriage_returns.hl7' ).readlines.first
    @simple_msh_end_lines = File.read('./test_data/end_lines.hl7')
    @empty_at_end = File.read('./test_data/empty_at_end.hl7')
    @base_msh = "MSH|^~\\&|LAB1||DESTINATION||19910127105114||ORU^R03|LAB1003929"
    @base_msh_alt_delims = "MSH$@~\\&|LAB1||DESTINATION||19910127105114||ORU^R03|LAB1003929"
  end

  def test_simple_msh
    msg = Ruby::HL7::Message.new
    msg.parse @simple_msh_carriage_returns
    assert_equal( @simple_msh_carriage_returns, msg.to_hl7 )
  end

  def test_empty_at_end
    msg = Ruby::HL7::Message.new
    msg.parse @empty_at_end
    assert_equal( @empty_at_end, msg.to_hl7 )
    assert_equal 'A01', msg[:MSH].message_type
  end
  
  def test_parse_delims
    msg = Ruby::HL7::Message.new( @base_msh )
    assert_equal( "|", msg.element_delim )
    assert_equal( "^", msg.item_delim )
    
    msg = Ruby::HL7::Message.new( @base_msh_alt_delims )
    assert_equal( "$", msg.element_delim )
    assert_equal( "@", msg.item_delim )
  end

  def test_constructor_parse
    msg = Ruby::HL7::Message.new( @simple_msh_carriage_returns )
    assert_equal( @simple_msh_carriage_returns, msg.to_hl7 )
    #msg = Ruby::HL7::Message.new( @simple_msh_end_lines )
    #assert_equal( @simple_msh_end_lines, msg.to_hl7 )
  end

  def test_class_parse
    msg = Ruby::HL7::Message.parse( @simple_msh_carriage_returns )
    assert_equal( @simple_msh_carriage_returns, msg.to_hl7 )
  end

  def test_not_string_or_enumerable
    assert_raises( Ruby::HL7::ParseError ) do
      msg = Ruby::HL7::Message.parse( :MSHthis_shouldnt_parse_at_all )
    end
  end

  def test_parse_empty
    msg = Ruby::HL7::Message.new @empty_txt
  end

  def test_message_to_string
    msg = Ruby::HL7::Message.new
    msg.parse @simple_msh_carriage_returns
    orig = @simple_msh_carriage_returns.gsub( /\r/, "\n" )
    assert_equal( orig, msg.to_s )
  end

  def test_to_s_vs_to_hl7
    msg = Ruby::HL7::Message.new( @simple_msh_carriage_returns )
    refute_equal( msg.to_s, msg.to_hl7 )
  end

  def test_segment_numeric_accessor
    msg = Ruby::HL7::Message.new
    msg.parse @simple_msh_carriage_returns
    assert_equal( @base_msh, msg[0].to_s ) 
  end

  def test_segment_string_accessor
    msg = Ruby::HL7::Message.new
    msg.parse @simple_msh_carriage_returns
    assert_equal( @base_msh, msg["MSH"].to_s ) 
  end

  def test_segment_symbol_accessor
    msg = Ruby::HL7::Message.new
    msg.parse @simple_msh_carriage_returns
    assert_equal( @base_msh, msg[:MSH].to_s ) 
  end

  def test_segment_numeric_mutator
    msg = Ruby::HL7::Message.new
    msg.parse @simple_msh_carriage_returns
    inp = Ruby::HL7::Default.new
    msg[1] = inp
    assert_equal( inp, msg[1] )

    assert_raises( Ruby::HL7::Exception ) do
      msg[2] = Class.new
    end
  end

  def test_segment_missing_accessor
    msg = Ruby::HL7::Message.new
    msg.parse @simple_msh_carriage_returns
    assert_nil msg[:does_not_exist]
  end

  def test_segment_string_mutator
    msg = Ruby::HL7::Message.new
    msg.parse @simple_msh_carriage_returns
    inp = Ruby::HL7::NTE.new
    msg["NTE"] = inp
    assert_equal( inp, msg["NTE"] )

    assert_raises( Ruby::HL7::Exception ) do
      msg["NTE"] = Class.new
    end
  end

  def test_segment_symbol_accessor
    msg = Ruby::HL7::Message.new
    msg.parse @simple_msh_carriage_returns
    inp = Ruby::HL7::NTE.new
    msg[:NTE] = inp
    assert_equal( inp, msg[:NTE] )

    assert_raises( Ruby::HL7::Exception ) do
      msg[:NTE] = Class.new
    end
  end

  def test_element_accessor
    msg = Ruby::HL7::Message.new
    msg.parse @simple_msh_carriage_returns
    assert_equal( "LAB1", msg[:MSH].sending_app )
  end

  def test_element_mutator
    msg = Ruby::HL7::Message.new
    msg.parse @simple_msh_carriage_returns
    msg[:MSH].sending_app = "TEST"
    assert_equal( "TEST", msg[:MSH].sending_app )
  end

  def test_element_missing_accessor
    msg = Ruby::HL7::Message.new
    msg.parse @simple_msh_carriage_returns
    assert_raises( Ruby::HL7::Exception, NoMethodError ) do
      msg[:MSH].does_not_really_exist_here
    end
  end

  def test_element_missing_mutator
    msg = Ruby::HL7::Message.new
    msg.parse @simple_msh_carriage_returns
    assert_raises( Ruby::HL7::Exception, NoMethodError ) do
      msg[:MSH].does_not_really_exist_here = "TEST"
    end
  end

  def test_element_numeric_accessor
    msg = Ruby::HL7::Message.new( @simple_msh_carriage_returns )
    
    assert_equal( "LAB1", msg[:MSH].e2 ) 
    assert_equal( "", msg[:MSH].e3 )
  end

  def test_element_numeric_mutator
    msg = Ruby::HL7::Message.parse( @simple_msh_carriage_returns )
    msg[:MSH].e2 = "TESTING1234"
    assert_equal( "TESTING1234", msg[:MSH].e2 )
  end

  def test_segment_append
    msg = Ruby::HL7::Message.new
    msg << Ruby::HL7::MSH.new
    msg << Ruby::HL7::NTE.new

    assert_raises( Ruby::HL7::Exception ) do
      msg << Class.new
    end
  end

  def test_segment_sort
    msg = Ruby::HL7::Message.new
    pv1 = Ruby::HL7::PV1.new
    msg << pv1
    msh = Ruby::HL7::MSH.new
    msg << msh
    nte = Ruby::HL7::NTE.new
    msg << nte
    nte2 = Ruby::HL7::NTE.new
    msg << nte
    msh.sending_app = "TEST"
    

    initial = msg.to_s
    sorted = msg.sort
    final = sorted.to_s
    refute_equal( initial, final )
  end

  def test_segment_auto_set_id
    msg = Ruby::HL7::Message.new
    msh = Ruby::HL7::MSH.new
    msg << msh
    ntea = Ruby::HL7::NTE.new
    ntea.comment = "first"
    msg << ntea
    nteb = Ruby::HL7::NTE.new
    nteb.comment = "second"
    msg << nteb
    ntec = Ruby::HL7::NTE.new
    ntec.comment = "third"
    msg << ntec
    assert_equal( "1", ntea.set_id )
    assert_equal( "2", nteb.set_id )
    assert_equal( "3", ntec.set_id )
  end

  def test_enumerable_parsing
    test_file = open( './test_data/carriage_returns.hl7' )
    refute_nil( test_file )

    msg = Ruby::HL7::Message.new( test_file )
    assert_equal( @simple_msh_carriage_returns, msg.to_hl7 )
  end

  def test_segment_to_info
    msg = Ruby::HL7::Message.new( @simple_msh_carriage_returns )
    refute_nil( msg[1].to_info )
  end

  def test_segment_use_raw_array
    inp = "NTE|1|ME TOO"
    nte = Ruby::HL7::NTE.new( inp.split( '|' ) )
    assert_equal( inp, nte.to_s )
  end

  def test_mllp_output
    msg = Ruby::HL7::Message.new( @simple_msh_carriage_returns )
    expect = "\x0b%s\x1c\r" % msg.to_hl7
    assert_equal( expect, msg.to_mllp )
  end

  def test_parse_mllp
    raw = "\x0b%s\x1c\r" % @simple_msh_carriage_returns
    msg = Ruby::HL7::Message.parse( raw )
    refute_nil( msg )
    assert_equal( @simple_msh_carriage_returns, msg.to_hl7 )
    assert_equal( raw, msg.to_mllp )
  end

  def test_mllp_output_parse
    msg = Ruby::HL7::Message.parse( @simple_msh_carriage_returns )
    refute_nil( msg )
    post_mllp = Ruby::HL7::Message.parse( msg.to_mllp )
    refute_nil( post_mllp )
    assert_equal( msg.to_hl7, post_mllp.to_hl7 )
  end

  def test_child_segment_accessor
    obr = Ruby::HL7::OBR.new
    refute_nil( obr.children )
    assert_equal( 0, obr.children.length )
  end

  def test_child_segment_addition
    obr = Ruby::HL7::OBR.new
    assert_equal( 0, obr.children.length )
    (1..5).each do |x|
      obr.children << Ruby::HL7::OBX.new
      assert_equal( x, obr.children.length )
    end
  end

  def test_child_segment_invalid_addition
    obr = Ruby::HL7::OBR.new
    assert_raises(Ruby::HL7::Exception) do
      obr.children << Class.new
    end
  end

  def test_grouped_sequenced_segments
    #multible obr's with multiple obx's
    msg = Ruby::HL7::Message.parse( @simple_msh_carriage_returns )
    refute_nil( msg )
    refute_nil( msg[:OBX] )
    orig_output = msg.to_hl7
    orig_obx_cnt = msg[:OBX].length
    (1..10).each do |obr_id|
      obr = Ruby::HL7::OBR.new
      msg << obr
      (1..10).each do |obx_id|
        obx = Ruby::HL7::OBX.new
        obr.children << obx
      end
    end

    refute_nil( msg[:OBR] )
    assert_equal( 11, msg[:OBR].length )
    refute_nil( msg[:OBX] )
    assert_equal( 102, msg[:OBX].length ) 
    assert_equal( "2", msg[:OBR][4].children[1].set_id ) # confirm the id's
    assert_equal( "2", msg[:OBR][5].children[1].set_id ) # confirm the id's

    final_output = msg.to_hl7
    refute_equal( orig_output, final_output )
  end

  def test_index_accessor
    msg = Ruby::HL7::Message.parse( @simple_msh_carriage_returns )
    assert_equal( 1, msg.index( "PID" ) )
    assert_equal( 1, msg.index( :PID ) )
    assert_equal( 2, msg.index( "PV1" ) )
    assert_equal( 2, msg.index( :PV1 ) )
    assert_nil msg.index( "TACOBELL" )
    assert_nil msg.index( nil )
    assert_nil msg.index( 1 )
  end

  def test_end_line_parse
    raw = @simple_msh_end_lines
    msg = Ruby::HL7::Message.new raw
    assert_equal '000698172', msg[:PID].patient_id
  end

  def test_carriage_return_parse
    raw = @simple_msh_carriage_returns
    msg = Ruby::HL7::Message.new raw
    assert_equal '3131313', msg[:PID].patient_id
  end

  def test_segment_field_block
    pid = Ruby::HL7::PID.new
    assert_raises( Ruby::HL7::InvalidDataError ) do
      pid.admin_sex = "TEST"
    end
    pid.admin_sex = "F"
  end

  def test_empty_segment
    msg = Ruby::HL7::Message.new @empty_segments_txt

  end

end
