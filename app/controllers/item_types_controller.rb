class ItemTypesController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :json

  def index
    respond_with ItemType.all.order('id ASC'), :represent_with => ItemTypesRepresenter
  end
end
