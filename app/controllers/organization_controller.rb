class OrganizationController < ApplicationController
    def index
        @organizations = Organization.all
    end
end
