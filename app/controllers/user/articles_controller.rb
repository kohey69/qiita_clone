class User::ArticlesController < User::ApplicationController
  def index
  end

  def show
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to user_article_path(@article), notice: t('controllers.created')
    else
      flash.now[:alert] = t('controllers.failed')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :published)
  end
end
