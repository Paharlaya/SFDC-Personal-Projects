import { LightningElement, track } from 'lwc';
import addTodo from '@salesforce/apex/ToDoController.addTodo';
import getCurrentTodos from '@salesforce/apex/ToDoController.getCurrentTodos';

export default class ToDoManager extends LightningElement {

   @track time = "8:15 PM";
   @track greeting = "Good Evening";
   @track todos = [];

    //Using this because it will get called as soon as my component is initialized
    connectedCallback(){
        this.getTime();
        this.fetchTodos();


        setInterval ( () =>{
            this.getTime();
            console.log("Set interval Called"); //to check in console if its changing
        },1000);

    }
    getTime(){
        const date = new Date();
        const hour = date.getHours();
        const min = date.getMinutes();

        this.time = `${this.getHour(hour)} : ${this.getDoubleDigit(min)} ${this.getMidDay(hour)}`;

        this.setGreeting(hour);
    }

    //displaying hour in 12 hr format
    getHour(hour){
        return hour == 0  ? 12 : hour > 12 ?  hour - 12 :hour;     
    }

    getMidDay(hour){
        return hour >= 12 ? "PM" : "AM";
    }

    getDoubleDigit(digit){
        return digit<10 ? "0"+digit : digit;
    }

    setGreeting(hour){
        if(hour<12){
            this.greeting = "Good Morning";
        }else if(hour ==12 && hour < 17){
            this.greeting = "Good AfterNoon";
        }else{
            this.greeting = "Good Evening";
        }
    }

    addToDoHandler(){
        const inputBox = this.template.querySelector("lightning-input");


        //js object
        const todo = {
            todoName: inputBox.value,
            done: false,
        };

        addTodo({payload : JSON.stringify(todo)}).then(response=>{
            console.log('Item inserted successfully' + response);
            this.fetchTodos();//retreiveing latest list;
        }).catch(error=>{
            console.error('Error inserting todo item' + error);
        });
        this.todos.push(todo)
        inputBox.value = '';
      
    }

    fetchTodos(){
        getCurrentTodos().then(result=>{
            if(result){
            console.log('Items fetched successfully :' + result.length);
            this.todos = result;
            }
        })
    .catch(error=>{
            console.error('Error inserting todo item' + error);
        });
    }

    updateHandler(){
        this.fetchTodos();
    }

    deleteHandler(){
        this.fetchTodos();
    }

    get upcomingTasks(){
        return this.todos && this.todos.length
        ? this.todos.filter(todo => !todo.done)
        : [];
    }

    get completedTasks(){
        return this.todos && this.todos.length 
        ? this.todos.filter(todo => todo.done) 
        : [];
    }

    
}