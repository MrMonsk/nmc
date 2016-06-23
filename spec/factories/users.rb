FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "test_user#{n}@gmail.com"
    end
    password 'volleyballisagirlssport'
    password_confirmation 'volleyballisagirlssport'
  end
end
