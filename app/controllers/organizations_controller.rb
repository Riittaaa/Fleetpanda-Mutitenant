class OrganizationsController < ApplicationController
  def index
    @organizations = current_user.organizations
  end

  def show
    # @organizations = current_user.organizations
  end
end
