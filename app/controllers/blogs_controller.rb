class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]
  # before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.where(organization_id: current_user.organizations.pluck(:id))
  end
  
  def my_blogs
    @blogs = Blog.where(user_id: current_user.id, organization_id: current_user.organizations.pluck(:id))
  end

  # GET /blogs/1 or /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    @blog = Blog.new(blog_params)
    # @blog.organization_id = current_user.organization_id 
    @blog.organization_id = current_user.organizations.first.id
    @blog.user_id = current_user.id 

    respond_to do |format|
    if @blog.save
      format.html { redirect_to blog_url(@blog), notice: "Blog was successfully created." }
      format.json { render :show, status: :created, location: @blog }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @blog.errors, status: :unprocessable_entity }
    end
  end
end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy!

    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_blog
      @blog = Blog.find(params[:id])
    end
  
    def authorize_user!
      unless @blog.user == current_user
        redirect_to blogs_path, alert: "You are not authorized to perform this action."
      end
    end
  
    def blog_params
      params.require(:blog).permit(:title, :body, :organization_id, :user_id)
    end
end
