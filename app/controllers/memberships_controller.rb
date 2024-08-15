class MembershipsController < ApplicationController
  before_action :set_current_organization

  def index
    @membership = @current_organization.memberships
  end

  def invite
    email = params[:email] 
    return redirect_to organization_memberships_path(@current_organization), alert: "No email provided" if email.blank?
    user = User.find_by(email:) || User.invite!({ email:}, current_user) 
    return redirect_to organization_memberships_path(@current_organization), alert: "Email invalid" unless user.valid?

    user.memberships.find_or_create_by(organization: @current_organization)
    # binding.b
    redirect_to organization_memberships_path(@current_organization),  notice: "Invite sent"
  end

  private 

  def set_current_organization
    @current_organization = Organization.find(params[:organization_id])
  end
end
