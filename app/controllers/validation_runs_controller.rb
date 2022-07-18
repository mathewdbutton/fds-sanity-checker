class ValidationRunsController < ApplicationController
  before_action -> { ValidationCleanup.call(Time.current) }

  def show
    @validation_run = ValidationRun.find_by(run_id: params[:run_id])
  end
end
