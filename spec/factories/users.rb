FactoryGirl.define do
<<<<<<< HEAD
  sequence(:id) { |n| n }
  
  factory :user_valid, class: User do
    id :id
    email 'rjsucks@yowon.com'
    password 'rjsocool'
    password_confirmation 'rjsocool'
  end
end
=======
  factory :user do
    sequence :email do |n|
      "test_user#{n}@gmail.com"
    end
    password "volleyballisagirlssport"
    password_confirmation "volleyballisagirlssport"
  end
end
>>>>>>> 4a2e11e3a2f192b66b40859a4c04c1d57047c528
