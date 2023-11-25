# frozen_string_literal: true

class ReceivedModelsController < ActionController::Base
  protect_from_forgery with: :null_session

  layout false

  def create
    head :ok
  end
end
