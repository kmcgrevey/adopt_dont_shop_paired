require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "relationships" do
    it {should have_many :pets}
  end
end
