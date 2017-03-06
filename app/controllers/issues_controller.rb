class IssuesController < ApplicationController
  include Roar::Rails::ControllerAdditions::Render
  include Roar::Rails::ControllerAdditions
  respond_to :json

  def index
    render json: Issue.outstanding_issues.order('id ASC'), :represent_with => IssuesRepresenter
  end

  def create
    issue = Issue.create(create_params)

    if issue.errors.any?
      puts issue.errors.to_json
      head :unprocessable_entity
    else
      render json: issue, :represent_with => IssueRepresenter
    end
  end

  def start_issue
    issue = Issue.find_by_id(params[:id])

    if issue.nil?
      head :not_found
    else
      issue.update(:status => 'finished')
      if issue.errors.any?
        head :unprocessable_entity
      else
        render json: issue, :represent_with => IssueRepresenter
      end
    end
  end

  private

  def create_params
    params.permit(:issue_type_id, :comment, :priority, :component_id)
  end
end
