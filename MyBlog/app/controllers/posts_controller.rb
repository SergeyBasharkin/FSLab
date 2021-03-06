class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
  before_action :authenticate_user!
  # GET /posts
  # GET /posts.json
  def index
    #@posts=Post.order(created_at: :desc)
    @posts = current_user.posts.order(created_at: :desc)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment=Comment.new
    @comments=@post.comments 
  end

  # GET /posts/new
  def new
    #@post = Post.new
    @post=current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post=current_user.posts.new(post_params)
    #@post = Post.new(post_params)
    
    respond_to do |format|
      if @post.save!
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit } 
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id,:body, :title)
    end
end
