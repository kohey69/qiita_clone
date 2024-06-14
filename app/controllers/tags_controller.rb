class TagsController < ApplicationController
  def index
    @tags = Tag.with_published_articles.default_order
  end
end
