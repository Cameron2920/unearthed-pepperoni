class ImagesController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render
  respond_to :json

  def create_equipment_image
    image_params = create_equipment_image_params
    equipment_id = image_params[:equipment_id]
    equipment = Equipment.find_by_id(equipment_id)

    if equipment.nil?
      head :not_found
    else
      image = Image.create(:parent => equipment, :image => image_params[:image], :tag => image_params[:tag])

      if image.errors.any?
        head :unprocessable_entity
      else
        render json: image, :represent_with => ImageRepresenter
      end
    end
  end

  def create_component_image
    image_params = create_equipment_image_params
    component_id = image_params[:component_id]
    component = Component.find_by_id(component_id)

    if component.nil?
      head :not_found
    else
      image = Image.create(:parent => component, :image => image_params[:image], :tag => image_params[:tag])

      if image.errors.any?
        head :unprocessable_entity
      else
        render json: image, :represent_with => ImageRepresenter
      end
    end
  end

  def detect_component_type
    image = params[:image]

    if image
      aws_client = Aws::Rekognition::Client.new(access_key_id: ENV['AWS_ACCESS_KEY'], secret_access_key: ENV['AWS_SECRET_KEY'], region: 'us-east-1')

      if image.respond_to?(:read)
        rekognition_response = aws_client.detect_labels(image: { bytes: image.read })

        rekognition_response.labels.each do |label|
          type = ComponentType.where("name ILIKE ?", "%#{label.name}%").first

          if type != nil
            render json: type.components, :represent_with => ComponentsRepresenter
            return
          end
        end
        head :no_content
      else
        head :unprocessable_entity
      end
    else
      head :unprocessable_entity
    end
  end

  private

  def create_equipment_image_params
    params.permit(:image, :equipment_id, :tag)
  end


  def create_component_image_params
    params.permit(:image, :component_id, :tag)
  end
end
