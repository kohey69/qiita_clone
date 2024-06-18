FactoryBot.define do
  factory :favorite do
    user { nil }
    article { nil }

    trait :with_user do
      user
    end

    trait :with_article do
      article
    end
  end
end
