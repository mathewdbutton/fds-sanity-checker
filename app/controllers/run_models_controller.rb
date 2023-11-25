# frozen_string_literal: true

class RunModelsController < ApplicationController
  def create
    run = ValidationRun.find_by(run_id: run_model_params[:validation_run_id])
    run.fds_model.open do |file|
      conn = Faraday.new(url: ENV["BASE_MODEL_RUNNER_API"]) do |f|
        f.request :multipart
        f.response :json
        f.response :raise_error
        f.response :logger
      end
      payload = { string: 'value' }
      payload[:file_with_name] = Faraday::Multipart::FilePart.new(File.open(file), 'text/x-ruby', File.basename(file))

      response = conn.post("/received_models", payload)
      @success = response.success?
      render :create
    end
  end

  private

  def run_model_params
    params.permit(:validation_run_id)
  end
end
