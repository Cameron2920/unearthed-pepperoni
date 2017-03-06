class EquipmentController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render
  respond_to :json

  def set_beacon
    beacon_params = set_beacon_params
    equipment_type_name = beacon_params.delete(:name)
    equipment_type = EquipmentType.find_or_create_by(:name => equipment_type_name)

    if equipment_type.errors.any?
      render json: equipment_type.errors, :status => :unprocessable_entity
    else
      beacon_uuid = beacon_params.delete(:beacon_uuid)
      equipment = Equipment.find_or_create_by(:beacon_uuid => beacon_uuid, :equipment_type => equipment_type)
      equipment.update(beacon_params)

      if equipment.errors.any?
        head :unprocessable_entity
      else
        render json: equipment, :represent_with => EquipmentRepresenter
      end
    end
  end

  private

  def set_beacon_params
    params.permit(:beacon_uuid, :name, :beacon_latitude, :beacon_longitude)
  end
end
