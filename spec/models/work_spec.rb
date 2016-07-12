require 'rails_helper'

RSpec.describe Work, type: :model do
  it 'has factories' do
    expect(build(:work_valid)).to be_valid
    expect(build(:work_blank)).to be_invalid
    expect(build(:work_other)).to be_valid
  end
end
