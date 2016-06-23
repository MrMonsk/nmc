FactoryGirl.define do
  factory :work_valid, class: Work do
    association :user
    title 'Op. 1'
    description 'no. 1'
    instrumentation 'for solo piano'
  end
  
  factory :work_blank, class: Work do
    to_create { |instance| instance.save(validate: false) }
    association :user
    title ''
    description 'no. 1'
    instrumentation 'for solo piano'
  end
end
