class ModelLoaderController < ApplicationController
  def new
  end

  def create
    ModelPipeline.call(params[:model])
    CurrentValidation.validation_run.update!(fds_model: params[:model])

    redirect_to validation_runs_show_path(run_id: CurrentValidation.validation_run.run_id)
  end

  private

  def create_params
    params.permit(:model)
  end
end
