FactoryGirl.define do
  factory :profile_valid, class: Profile do
    association :user
    bio 'New Bio'
    url 'Nothing Yet'
    stage_name 'Nothing Yet'
    image 'Nothing Yet'
  end
end
