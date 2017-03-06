class IssueTypesController < ApplicationController
  include Roar::Rails::ControllerAdditions::Render
  include Roar::Rails::ControllerAdditions
  respond_to :json

  def index
    render json: IssueType.all.includes(:bill_of_material).where.not(bill_of_materials: {id: nil}).order('issue_types.id ASC'), :represent_with => IssueTypesRepresenter
  end
end
