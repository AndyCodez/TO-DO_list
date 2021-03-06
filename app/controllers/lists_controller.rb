class ListsController < ApplicationController
  before_action :correct_user, only: [:show]
  skip_before_action :verify_authenticity_token, :only => :create

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      flash[:success] = "List successfully created!"
      respond_to do |format|
        #Executes if js is disabled on browser
        format.html { redirect_to lists_path }
        #Executes if js is enabled on browser
        format.js { redirect_to lists_path }
      end
    else
      flash[:danger] = "Something went wrong, please try adding a list again."
      respond_to do |format|
        #Executes if js is disabled on browser
        format.html { redirect_to lists_path }
        #Executes if js is enabled on browser
        format.js { redirect_to lists_path }
      end
    end
  end

  def index
    #Helps create the form
    @list = List.new
    #Gets all lists associated with the current user
    @lists = current_user.lists
  end

  def show
    #To create form
    @card = Card.new

    @list = List.find_by(id: params[:id])
    @cards = @list.cards
  end

  private
    def list_params
      params.require(:list).permit(:title)
    end

    #Confirms list belongs to the correct user
    def correct_user
      @list = current_user.lists.find_by(id: params[:id])
      redirect_to root_url if @list.nil?
    end
end
