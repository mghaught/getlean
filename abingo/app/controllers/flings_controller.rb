class FlingsController < ApplicationController
  
  before_filter :load_payloads, :only => [:new, :create]
  before_filter :authenticate_user!, :except => :show 
  
  def new
    @fling = Fling.new
    if params[:target_id]
      @target = User.find_by_id(params[:target_id])
      if @target
        @fling.target_email = @target.email
        @fling.target_name = @target.name
      end
    end
    
    @fling.payload = @payloads.first
  end
  
  def create
    @fling = current_user.flings.build(params[:fling])
    if @fling.save
      bingo! "messaged_fling"
      flash[:notice] = "Flung away!"
      redirect_to fling_path(@fling)
    else
      render :action => 'new'
    end    
  end
  
  def show
    @fling = Fling.find(params[:id])
  rescue Exception => e
    rescue_action_in_public e
  end
  
protected
  
  def load_payloads
    @payloads = Payload.all
  end
  
end
