require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "relationships" do
    it {should belong_to :shelter}
  end
end
