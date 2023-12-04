/**
 * test
 */
public interface Animal {
    abstract void sound(){}

} 

class Dog implements Animal{
    @Override
    void sound(){
        System.out.println('HAB HAB HAB');
    }
}


class Cat implements Animal{
    @Override
    void sound(){
        System.out.println('Meoow Meoow');
    }
}