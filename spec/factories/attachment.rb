FactoryGirl.define do
  factory :attachment do |a|
    title 'Google'
    title_url 'http://google.com'
    description 'Some description.'
    message

    trait :image_attachment do
      image_url 'logo-google.jpg'
    end
  end
end
