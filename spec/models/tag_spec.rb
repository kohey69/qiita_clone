require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe '#with_published_articles' do
    it '記事に紐づいているタグのみ取得できること' do
      tag = create(:tag, name: '記事に紐づいているタグ')
      create(:tag, name: '記事に紐づいていないタグ')
      create(:article, :with_user, tags: [tag])

      expect(Tag.with_published_articles.pluck(:name)).to contain_exactly('記事に紐づいているタグ')
    end
  end
end
