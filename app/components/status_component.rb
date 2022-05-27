# frozen_string_literal: true

class StatusComponent < ViewComponent::Base
  delegate *%i[scope valid?], to: :status_model

  attr_reader :validation_run, :status_model

  renders_one :title
  renders_one :info
  renders_one :contributing_params

  def initialize(validation_run:, status_model:)
    @validation_run = validation_run
    @status_model = status_model
  end

  def errors
    valid?
    status_model.errors.full_messages
  end

  def box_state
    valid? ? "text-white bg-green-500" : "text-black bg-red-500"
  end

end
