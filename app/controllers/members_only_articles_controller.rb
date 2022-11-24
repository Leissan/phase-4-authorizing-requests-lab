class MembersOnlyArticlesController < ApplicationController
  
  before_action :authorize
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    articles = Article.all
    render json: articles, each_serializer: ArticleListSerializer
  end

  def show
    article = Article.find(params[:id])
    render json: article
  end

  private

  def authorize
    return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :is_member_only
  end

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end

end
