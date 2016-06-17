FactoryGirl.define do
  sequence(:id) { |n| n }
  
  factory :user_valid, class: User do
    id :id
    email 'rjsucks@yowon.com'
    password 'rjsocool'
    password_confirmation 'rjsocool'
  end
end
