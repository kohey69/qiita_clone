module ApplicationHelper
  def avatar_path(avatar)
    if avatar.attached?
      avatar.variant(:thumb)
    else
      'default_avatar.svg'
    end
  end

  def generate_article_path(article)
    if article.user == current_user
      user_article_path(article)
    else
      article_path(article)
    end
  end
end
