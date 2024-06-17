require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '#with_tags' do
    before do
      article = create(:article, :with_user, title: '指定したタグがついている記事')
      other_article = create(:article, :with_user, title: '指定したタグがついていない記事')
      _not_with_tags_article = create(:article, :with_user, title: 'タグづけされていない記事')
      create(:tag, articles: [article], name: '指定したタグ')
      create(:tag, articles: [article, other_article], name: '指定していないタグ')
    end

    it 'タグの名前で検索できること' do
      expect(Article.with_tags('指定したタグ').pluck(:title)).to contain_exactly('指定したタグがついている記事')
    end

    it '空文字を引数に渡した場合は全ての記事を返すこと' do
      expect(Article.with_tags('').pluck(:title)).to contain_exactly('指定したタグがついている記事', '指定したタグがついていない記事', 'タグづけされていない記事')
    end

    it 'nilを引数に渡した場合は全ての記事を返すこと' do
      expect(Article.with_tags(nil).pluck(:title)).to contain_exactly('指定したタグがついている記事', '指定したタグがついていない記事', 'タグづけされていない記事')
    end
  end
end
