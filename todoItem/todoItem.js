import { api, LightningElement } from 'lwc';
import updateTodo from '@salesforce/apex/ToDoController.updateTodo';
import deleteTodo from '@salesforce/apex/ToDoController.deleteTodo';



//Child component of todoManager
export default class TodoItem extends LightningElement {

@api todoId;
@api todoName;
@api done = false;

updateHandler(){

    //creating this JS obj to parse into a string  and again parse that string to apex obj in the apex class
    const todo = {
        todoId : this.todoId,
        todoName : this.todoName,
        done : !this.done //updating the completed field
};
updateTodo({payload:JSON.stringify(todo)}).then(result => {
  
        console.log('Item updated Successfully');
        //custom event child-to-parent communication
        const updateEvent = new CustomEvent("update")
        this.dispatchEvent(updateEvent);   
}).catch(error => {
    console.log('Error in update :' +error);
});
}

deleteHandler(){
    deleteTodo({todoId : this.todoId}).then(result => {
        console.log('Item deleted Successfully' +result);
        //custom event child-to-parent communication
        const deleteEvent = new CustomEvent("delete")
        this.dispatchEvent(deleteEvent);
    }).catch(error => {
        console.log('Error in deleting item'+error)
    });
}

get containerClass() {
    return this.done ? "todo completed" : "todo upcoming";
  }

get iconName(){
    return this.done ? "utility:check" : "utility:add";
}

}