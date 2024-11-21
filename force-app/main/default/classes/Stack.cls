public class Stack {
  
  List<Object> stackList = new List<Stack>();
    public void push(Object obj) {
        //implement push
        
        stackList.add(obj);
    }
    
    public Object pop() {
        //implement pop
        
            return stackList.remove(stackList.size() - 1);
        

    }
    
    public Integer size() {
        //implement size
        return stackList.size();
    }
    
    public Object peek(){
        //implement peek
        
            return stackList[stackList.size() - 1];
        
    }
    
    public Boolean isEmpty() {
        //implement isEmpty
        boolean isEmpty = false;
        if(stackList.size() == 0 || stackList == null){
            isEmpty  = true;
        }

        return isEmpty;
    }
}