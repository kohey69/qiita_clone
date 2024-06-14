module ApplicationHelper
  def generate_article_path(article)
    if article.user == current_user
      user_article_path(article)
    else
      article_path(article)
    end
  end
end
