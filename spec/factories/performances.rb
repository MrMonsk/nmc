FactoryGirl.define do
  factory :performance_valid, class: Performance do
    association :user
    title 'Test Title'
    image 'Nothing Yet'
    video 'Nothing Yet'
    audio 'Nothing Yet'
  end

  factory :performance_blank, class: Performance do
    to_create { |instance| instance.save(validate: false) }
    association :user
    title ''
    image 'Nothing Yet'
    video 'Nothing Yet'
    audio 'Nothing Yet'
  end

  factory :performance_other, class: Performance do
    title 'Performerless'
    image 'n/a'
    video 'n/a'
    audio 'n/a'
  end
end
