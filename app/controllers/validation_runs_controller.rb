class ValidationRunsController < ApplicationController
  def show
    validation_run = ValidationRun.find_by(run_id: params[:run_id])
    @vents = validation_run.vents
    @surfaces = validation_run.surfaces
    @unmapped = validation_run.unmapped_name_lists
  end
end
