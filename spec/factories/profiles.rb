FactoryGirl.define do
  factory :profile do
    factory :profile_valid, class: Profile do
      association :user
      bio 'New Bio'
      url 'Nothing Yet'
      stage_name 'Nothing Yet'
      image 'Nothing Yet'
    end

    factory :profile_blank, class: Profile do
      to_create { |instance| instance.save(validate: false) }
      association :user
      bio ''
      url 'Nothing Yet'
      stage_name 'Nothing Yet'
      image 'Nothing Yet'
    end

    factory :profile_other, class: Profile do
      bio 'Performerless'
      url 'n/a'
      stage_name 'n/a'
      image 'n/a'
    end
  end
end
