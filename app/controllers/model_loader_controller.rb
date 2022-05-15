class ModelLoaderController < ApplicationController
  def new
  end

  def create
    puts ModelValidator.call(params[:model])

    redirect_to action: :new
  end

  private

  def create_params
    params.permit(:model)
  end
end
