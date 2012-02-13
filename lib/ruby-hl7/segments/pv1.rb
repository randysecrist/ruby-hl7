module Ruby
  module HL7

    class PV1 < Segment
      weight 2
      add_field :set_id
      add_field :patient_class
      add_field :assigned_location, :idx => 3
      add_field :assigned_location_unit, :idx => 3, :subidx => 0
      add_field :assigned_location_room, :idx => 3, :subidx => 1
      add_field :assigned_location_bed, :idx => 3, :subidx => 2
      add_field :assigned_location_facility, :idx => 3, :subidx => 3
      add_field :admission_type
      add_field :preadmit_number
      add_field :prior_location
      add_field :attending_doctor
      add_field :referring_doctor, :idx => 8
      add_field :referring_doctor_npi, :idx => 8, :subidx => 0
      add_field :referring_doctor_familyname, :idx => 8, :subidx => 1
      add_field :referring_doctor_givenname, :idx => 8, :subidx => 2
      add_field :referring_doctor_middlename, :idx => 8, :subidx => 3
      add_field :referring_doctor_title, :idx => 8, :subidx => 6
      add_field :consulting_doctor
      add_field :hospital_service
      add_field :temporary_location
      add_field :preadmit_indicator
      add_field :readmit_indicator
      add_field :admit_source
      add_field :ambulatory_status
      add_field :vip_indicator
      add_field :admitting_doctor, :idx => 7
      add_field :admitting_doctor_npi, :idx => 7, :subidx => 0
      add_field :admitting_doctor_familyname, :idx => 7, :subidx => 1
      add_field :admitting_doctor_givenname, :idx => 7, :subidx => 2
      add_field :admitting_doctor_middlename, :idx => 7, :subidx => 3
      add_field :admitting_doctor_title, :idx => 7, :subidx => 6
      add_field :patient_type
      add_field :visit_number
      add_field :financial_class
      add_field :charge_price_indicator
      add_field :courtesy_code
      add_field :credit_rating
      add_field :contract_code
      add_field :contract_effective_date
      add_field :contract_amount
      add_field :contract_period
      add_field :interest_code
      add_field :transfer_bad_debt_code
      add_field :transfer_bad_debt_date
      add_field :bad_debt_agency_code
      add_field :bad_debt_transfer_amount
      add_field :bad_debt_recovery_amount
      add_field :delete_account_indicator
      add_field :delete_account_date
      add_field :discharge_disposition
      add_field :discharge_to_location
      add_field :diet_type
      add_field :servicing_facility
      add_field :bed_status
      add_field :account_status
      add_field :pending_location
      add_field :prior_temporary_location
      add_field :admit_date, :idx => 44
      add_field :discharge_date
      add_field :current_patient_balance
      add_field :total_charges
      add_field :total_adjustments
      add_field :total_payments
      add_field :alternate_visit_id
      add_field :visit_indicator
      add_field :other_healthcare_provider
    end

  end
end
