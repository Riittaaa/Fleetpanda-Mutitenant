class MembershipsController < ApplicationController
  before_action :set_current_organization
  def index
    @membership = @current_organization.memberships

  end

  private 

  def set_current_organization
    @current_organization = Organization.find(params[:organization_id])
  end
end
