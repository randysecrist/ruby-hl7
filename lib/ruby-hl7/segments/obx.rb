module Ruby
  module HL7

    class OBX < Segment
      weight 90
      has_children [:NTE]
      add_field :set_id, :idx => 1
      add_field :value_type, :idx => 2
      add_field :observation_id, :idx => 3
      add_field :observation_sub_id, :idx => 4
      add_field :observation_value, :idx => 5
      add_field :units
      add_field :references_range
      add_field :abnormal_flags
      add_field :probability
      add_field :nature_of_abnormal_test
      add_field :observation_result_status
      add_field :effective_date_of_reference_range
      add_field :user_defined_access_checks
      add_field :observation_date
      add_field :producer_id
      add_field :responsible_observer
      add_field :observation_method
      add_field :equipment_instance_id
      add_field :analysis_date
    end

  end
end