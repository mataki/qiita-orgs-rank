class MembersController < ApplicationController
  before_action :set_organization
  before_action :set_member, only: [:show]

  def index
    @members = @organization.members
  end

  def show
  end

private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_member
    @member = @organization.find(params[:id])
  end
end
