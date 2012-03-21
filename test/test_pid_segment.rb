# encoding: UTF-8
$: << '../lib'
require 'minitest/autorun'
require 'ruby-hl7'

class PidSegment < MiniTest::Unit::TestCase
  def setup
    @base = "PID|||333||LastName^FirstName^MiddleInitial^SR^NickName||19760228|F||||||||||555. 55|012345678"
  end

  def test_create_pid
    pid = Ruby::HL7::PID.new @base
    refute_nil pid
    assert_equal @base, pid.to_s
    assert_equal '333', pid.patient_id
    assert_equal 'LastName^FirstName^MiddleInitial^SR^NickName', pid.patient_name
    assert_equal 'LastName', pid.patient_familyname
    assert_equal 'FirstName', pid.patient_givenname
    assert_equal '19760228', pid.patient_dob
  end

  def test_admin_sex_limits
    pid = Ruby::HL7::PID.new
    vals = %w[F M O U A N] + [ nil ]
    vals.each do |x|
      pid.admin_sex = x
    end
    pid.admin_sex = ""

    assert_raises( Ruby::HL7::InvalidDataError ) do
      ["TEST", "A", 1, 2].each do |x|
        pid.admin_sex = x
      end
    end

  end
end
