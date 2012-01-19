class ArticlesController < ApplicationController
  before_filter :authenticate_user!
  
  check_authorization
  load_and_authorize_resource
  
  # GET /articles
  # GET /articles.json
  def index
    @title = t 'view.articles.index_title'
    @articles = @articles.ordered_list.paginate(
      page: params[:page], per_page: LINES_PER_PAGE
    )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @title = t 'view.articles.show_title'

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @title = t 'view.articles.new_title'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @title = t 'view.articles.edit_title'
  end

  # POST /articles
  # POST /articles.json
  def create
    @title = t 'view.articles.new_title'
    #@article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: t('view.articles.correctly_created') }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @title = t 'view.articles.edit_title'

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: t('view.articles.correctly_updated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
    
  rescue ActiveRecord::StaleObjectError
    flash.alert = t 'view.articles.stale_object_error'
    redirect_to edit_article_url(@article)
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end
end
