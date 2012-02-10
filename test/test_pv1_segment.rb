require 'test/unit'
require 'ruby-hl7'

class Pv1Segment < Test::Unit::TestCase
  def setup
    @base = "PV1||I|3ST^P001^A|3|||1234567890^LastName^FirstName^^^^MD|9876543210^LastName^FirstName^M^^^MD||RAD||||6||""|2345678901^LastName^FirstName^^^^MD|RT|1112100001|SP|||||||||||||||||||A|||||02/06/2012||||||ADM"
  end

  def test_create_pv1
    assert_nothing_raised do
      pv1 = HL7::Message::Segment::PV1.new @base
      assert_not_nil pv1
      assert_equal @base, pv1.to_s
      assert_equal '3ST^P001^A', pv1.assigned_location
      assert_equal '3ST', pv1.assigned_location_dept
      assert_equal 'P001', pv1.assigned_location_room
      assert_equal 'A', pv1.assigned_location_loc


      assert_equal '1234567890^LastName^FirstName^^^^MD', pv1.admitting_doctor
      assert_equal '1234567890', pv1.admitting_doctor_npi
      assert_equal 'LastName', pv1.admitting_doctor_familyname
      assert_equal 'FirstName', pv1.admitting_doctor_givenname
      assert_equal '', pv1.admitting_doctor_middlename
      assert_equal 'MD', pv1.admitting_doctor_title

      assert_equal '9876543210^LastName^FirstName^M^^^MD', pv1.referring_doctor
      assert_equal '9876543210', pv1.referring_doctor_npi
      assert_equal 'LastName', pv1.referring_doctor_familyname
      assert_equal 'FirstName', pv1.referring_doctor_givenname
      assert_equal 'M', pv1.referring_doctor_middlename
      assert_equal 'MD', pv1.referring_doctor_title


      assert_equal '02/06/2012', pv1.admit_date
    end
  end
end
