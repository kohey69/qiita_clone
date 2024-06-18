class TagsController < ApplicationController
  def index
    @tags = Tag.has_published_articles.default_order
  end
end
