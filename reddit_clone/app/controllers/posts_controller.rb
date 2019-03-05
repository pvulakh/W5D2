class PostsController < ApplicationController
    before_action :ensure_log_in
    before_action :ensure_author, only: [:edit, :update]

    def ensure_author
        @post = Post.find(params[:id])
        redirect_to subs_url unless @post.user_id == current_user.id
    end

    def new
        @post = Post.new
        render :new
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        if @post.save
            redirect_to post_url(@post)
        else  
            flash.now[:errors] = @post.errors.full_messages
            render :new 
        end 
    end
    
    def show
        @post = Post.find(params[:id])
        render :show
    end

    def edit
        @post = Post.find(params[:id])
        render :edit
    end

    def update
        @post = Post.find(params[:id])
        if @post.update_attributes(post_params)
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :edit
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.sub_ids = []
        @post.delete 
        redirect_to subs_url
    end

    private
    def post_params
        params.require(:post).permit(:title, :url, :content, sub_ids: [])
    end
end