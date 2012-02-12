module Ruby
  module HL7

    class MSA < Segment
      weight 0 # should occur after the msh segment
      add_field :ack_code, :idx => 1
      add_field :control_id, :idx => 2
      add_field :text
      add_field :expected_seq
      add_field :delayed_ack_type
      add_field :error_cond
    end

  end
end