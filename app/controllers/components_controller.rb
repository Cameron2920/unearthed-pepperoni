class ComponentsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render
  respond_to :json

  def index
    render json: Component.where(:equipment => Equipment.first), :represent_with => ComponentsRepresenter
  end

  def set_beacon
    beacon_params = set_beacon_params
    component_type_name = beacon_params.delete(:name)
    component_type = ComponentType.find_or_create_by(:name => component_type_name)

    if component_type.errors.any?
      render json: component_type.errors, :status => :unprocessable_entity
    else
      beacon_uuid = beacon_params.delete(:beacon_uuid)
      component = Component.find_or_create_by(:beacon_uuid => beacon_uuid, :component_type => component_type)
      component.update(beacon_params)

      if component.errors.any?
        render json: component.errors, :status => :unprocessable_entity
      else
        # respond_with component
        render json: component, :represent_with => ComponentRepresenter
      end
    end
  end

  private

  def set_beacon_params
    params.permit(:beacon_uuid, :name, :beacon_latitude, :beacon_longitude, :equipment_id)
  end
end
