class HL7::Message::Segment::OBR < HL7::Message::Segment
  weight 89 # obr.weight-1
  has_children [:OBX]
  add_field :set_id, :idx => 1
  add_field :placer_order_number, :idx => 2
  add_field :filler_order_number, :idx => 3
  add_field :universal_service_id, :idx => 4
  add_field :priority
  add_field :requested_date
  add_field :observation_date
  add_field :observation_end_date
  add_field :collection_volume
  add_field :collector_identifier
  add_field :specimen_action_code
  add_field :danger_code
  add_field :relevant_clinical_info
  add_field :specimen_received_date
  add_field :specimen_source
  add_field :ordering_provider
  add_field :order_callback_phone_number
  add_field :placer_field_1
  add_field :placer_field_2
  add_field :filer_field_1
  add_field :filer_field_2
  add_field :results_status_change_date
  add_field :charge_to_practice
  add_field :parent_result
  add_field :quantity_timing
  add_field :result_copies_to
  add_field :parent
  add_field :transport_mode
  add_field :reason_for_study
  add_field :principal_result_interpreter
  add_field :assistant_result_interpreter
  add_field :technician
  add_field :transcriptionist
  add_field :scheduled_date
  add_field :number_of_sample_containers
  add_field :transport_logistics_of_sample
  add_field :collectors_comment
  add_field :transport_arrangement_responsibility
  add_field :transport_arranged
  add_field :escort_required
  add_field :planned_patient_transport_comment
  add_field :procedure_code
  add_field :procedure_code_modifier
  add_field :placer_supplemental_service_info
  add_field :filler_supplemental_service_info
  add_field :medically_necessary_dup_procedure_reason #longest method name ever. sry.
  add_field :result_handling
end
