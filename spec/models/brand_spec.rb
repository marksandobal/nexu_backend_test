require 'rails_helper'

RSpec.describe Brand, type: :model do
  let(:name) { 'Brand' }

  it { should have_many(:models) }

  it { should validate_uniqueness_of(:name) }
end
