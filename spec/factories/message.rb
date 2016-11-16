FactoryGirl.define do
  factory :message do
    sender_name 'John'
    body 'It is just a message.'
    sent_at Time.now

    trait :with_attachments do
      after(:create) do |message|
        message.attachments << build(:attachment, message: message)
        message.attachments << build(:attachment, message: message)
      end
    end
  end
end
