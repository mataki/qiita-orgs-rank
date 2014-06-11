require 'rails_helper'

RSpec.describe "Organizations", :type => :request do
  describe "GET /organizations" do
    it "works! (now write some real specs)" do
      get organizations_path
      expect(response.status).to be(200)
    end
  end
end
