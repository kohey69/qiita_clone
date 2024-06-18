FactoryBot.define do
  factory :following do
    following_user { nil }
    followed_user { nil }

    trait :with_following_user do
      following_user { FactoryBot.create(:user) }
    end
  end
end
