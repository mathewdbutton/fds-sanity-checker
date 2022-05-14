class ModelLoaderController < ApplicationController
  def new
  end

  def create
    redirect_to action: :new
  end

  private

  def create_params
    params.permit(:model)
  end
end
