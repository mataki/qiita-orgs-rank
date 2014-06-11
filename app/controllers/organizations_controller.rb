class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  def index
    @organizations = Organization.order('stock_count DESC, post_count DESC')
  end

  def show
  end

private

  def set_organization
    @organization = Organization.find(params[:id])
  end
end
