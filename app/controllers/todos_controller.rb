class TodosController < ApplicationController
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
        @todo = Todo.find(params[:id])
    end

    def index
        @todos = Todo.all
    end

    def edit
        @todo = Todo.find(params[:id]) # since edit route=> /todos/:id/edit : this line fetch the record with id matching the one in the link
       # @todo.update(todo_params)
    end

    def update
        @todo = Todo.find(params[:id])
        if @todo.update(todo_params)
            flash[:notice] ="Todo updated successfully!"
            redirect_to todo_path(@todo)
        else
            render 'edit'
        end
    end

    def destroy
        @todo = Todo.find(params[:id])
        @todo.destroy
        flash[:notice]  = "Todo Deleted successfully"
        redirect_to todos_path
    end
    
    private
    def todo_params
        params.require(:todo).permit(:name, :description, :time)
    end
    
end