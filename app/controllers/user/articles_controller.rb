class User::ArticlesController < User::ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = current_user.articles.default_order.page(params[:page])
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

  def update
  end

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :published)
  end

  def set_article
    @article = current_user.articles.find(params[:id])
  end
end