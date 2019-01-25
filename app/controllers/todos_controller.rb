class TodosController < ApplicationController
    before_action :set_todo, only: [:edit, :update, :show, :destroy]

    def new
        @todo = Todo.new()
    end

    def create
        @todo = Todo.new(todo_params) #todo_params: is private method defined below that specifies 
                                      #a number of todos values to be stored.
        if @todo.save

            flash[:notice] = "Todo created successfully!" #flash is a notification msg. read more about it on https://guides.rubyonrails.org/action_controller_overview.html
            redirect_to todo_path(@todo) #redirecting to todos/:id => so we need to pass the id (@todo) of the todo we just saved
        else
            render 'new'
        end
    end

    def show
    end

    def index
        @todos = Todo.all
    end

    def edit
       # @todo = Todo.find(params[:id]) # since edit route=> /todos/:id/edit : this line fetch the record with id matching the one in the link
       # @todo.update(todo_params)
    end

    def update
        if @todo.update(todo_params)
            flash[:notice] ="Todo updated successfully!"
            redirect_to todo_path(@todo)
        else
            render 'edit'
        end
    end

    def destroy
        @todo.destroy
        flash[:notice]  = "Todo Deleted successfully"
        redirect_to todos_path
    end
    
    private

    #refactoring: cleaning our codes by puting together all the repeating sections
    # in this case the repeating section in this todos_controller is
    # @todo = Todo.find(params[:id]) so we will put it in a private method set_todo
    # and at the beginning we will tel rails to run set_todo method before any action for
    #for the methods of edit, show, update and destroy because were the ones using @todo=Todo.find(params[:id])

    def set_todo
        @todo = Todo.find(params[:id])
    end
    


    def todo_params
        params.require(:todo).permit(:name, :description, :time)
    end
    
end