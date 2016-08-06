class ListsController < ApplicationController

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      flash[:success] = "List successfully created!"
      redirect_to lists_path
    else
      flash[:danger] = "Something went wrong, please try adding a list again."
      render 'new'
    end
  end

  def index
    #Gets all lists associated with the current user
    @lists = current_user.lists
  end

  def show
    @list = List.find_by(id: params[:id])
    @cards = @list.cards
  end

  private
    def list_params
      params.require(:list).permit(:title)
    end
end
