class ComponentTypesController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render
  respond_to :json

  def index
    render json: ComponentType.all.joins(:issue_types).uniq.all, :represent_with => ComponentTypesRepresenter
  end
end
