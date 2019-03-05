class SubsController < ApplicationController
    before_action :ensure_log_in
    before_action :ensure_moderator, only: [ :edit, :update ]

    def ensure_moderator
        @sub = Sub.find(params[:id])
        @sub.moderator_id == current_user.id
    end 

    def new
        render :new 
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.moderator_id = current_user.id

        if @sub.save 
            redirect_to sub_url(@sub)
        else  
            flash.now[:errors] = @sub.errors.full_messages
            render :new 
        end 
    end

    def index
        @subs = Sub.all 
        render :index
    end

    def show
        @sub = Sub.find(params[:id])
        render :show
    end
    
    def edit
        @sub = Sub.find(params[:id])

        if @sub 
            render :edit 
        else  
            redirect_to subs_url
        end
    end

    def update
        @sub = Sub.find(params[:id])
        
        if @sub.update_attributes(sub_params)
            redirect_to sub_url(@sub)
        else  
            flash.now[:errors] = @sub.errors.full_messages
            render :edit 
        end 
    end

    private 
    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end