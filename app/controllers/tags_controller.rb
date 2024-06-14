class TagsController < ApplicationController
  def index
    @tags = Tag.default_order
  end
end
