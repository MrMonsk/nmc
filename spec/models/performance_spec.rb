require 'rails_helper'

RSpec.describe Performance, type: :model do
  it 'has factories' do
    expect(build(:performance_valid)).to be_valid
    expect(build(:performance_blank)).to be_invalid
    expect(build(:performance_other)).to be_valid
  end
end
