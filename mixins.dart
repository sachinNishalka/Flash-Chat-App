void main(){
  Animal().move();
  Fish().move();
  Bird().move();
  Duck().fly();
  Duck().swim();
}

class Animal{

  void move(){
    print("changed the position");
  }

}

class Fish extends Animal{
  @override
  void move(){
    super.move();
    print("by swimmming");
  }
}

class Bird extends Animal{
  @override
  void move(){
    super.move();
    print("by flying");
  }
}

mixin CanSwim{
void swim(){
  print("change the position by swimming");
}
}

mixin CanFly{
void fly(){
  print("change the position by flying");
}
}
class Duck  with CanSwim, CanFly{

}