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

  def markdown(text)
    markdown_options = {
      hard_wrap: true,
      link_attributes: { rel: 'nofollow', taget: '_blank' },
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      autolink: true,
      tables: true,
      lax_spacing: true,
      underline: true,
      highlight: true,
      quote: true,
      footnotes: true,
    }
    html_options = {
      filter_html: false,
      no_images: false,
      no_links: true,
      no_styles: true,
      escape_html: false,
      safe_links_only: true,
      with_toc_data: true,
      hard_wrap: true,
      xhtml: true,
      prettify: true, # google-code-prettifyは利用しないが、スタイルと今後のために
      link_attributes: { rel: 'nofollow', taget: '_blank' },
    }
    renderer = Redcarpet::Render::HTML.new(html_options)
    markdown = Redcarpet::Markdown.new(renderer, markdown_options)
    sanitize(markdown.render(text))
  end
end
