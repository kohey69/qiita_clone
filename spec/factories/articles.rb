FactoryBot.define do
  factory :article do
    title { 'テニスが上手くなるためには' }
    content { 'テニスのスキルを向上させたいと思っている方は多いでしょう。ここでは、テニスが上手くなるための効果的な練習方法や心構えについて紹介します。' }
    published { true }

    trait :with_user do
      user
    end

    trait :unpublished do
      published { false }
    end
  end
end
