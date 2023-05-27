# Flash Chat App using Flutter Animations and Fire Base
``` bash
flutter create project
```
---
## Animations require
1. Ticker - Looks like a timer 
2. Animation - Controller which controlls the animation
    - Start
    - Stop
    - To go foward
    - To loop back
    - How long to animate for 
3. An Animation Value - This is the thing actually does the animation 
    - Usually it goes from 0 to 1
    - We can change 
        - height 
        - size 
        - color 
        - alpha
        - opacity
---

## Making simple hero animation
``` dart
Hero(
    tag: 'logo',
        child: Container(
            child: Image.asset('images/logo.png'),
            height: 60.0,
        ),
    ),
```
![FlashChat0](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/24fa4e8e-92f4-405b-be31-20571adc3d92)
## How to make Animations 

1. Make the animation controller
``` dart
AnimationController controller;
```
2. We want to run the animation when the state object get initalized 
``` dart
@override
void initState(){
    super.initState();
}
```
3. Here we want to create animation controller 
``` dart
@override
void initState(){
    controller = AnimationController();
    super.initState();
}
```
4. Animation Contoller class have few properties 
    - duration : How long do you want this animation to go for 
    ``` dart
    AnimationController(duration: Duration(seonds:1));
    ``` 
    - vsync : This is a required property and Here we provide the ticker provider
    - vsync : This will be the state object (This is like what will change when animation happens)
        - to change a state class to a ticker provider we have to add 
        ``` dart
        State<WelcomeScreen> with SingleTickerProviderStateMixing{}
        ```
    - upperBound : 
    - lowerBound :   
``` dart
@override
void initState(){
    controller = AnimationController();
    super.initState();
}
```
``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:1)
    );
    super.initState();
}
```
``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:1),
        vsync:this,
    );
    super.initState();
}
```

5. Now we can start the animation 
``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:1),
        vsync:this,
    );
    controller.foward();
    super.initState();
}
```
6. if you want to see what the contoller doing, we have to add a listener to the controller, here listener will take a call back 
``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:1),
        vsync:this,
    );
    controller.foward();
    controller.addListener((){
        print(controller.value);
    });
    super.initState();
}
```
7. we can use this number for number of things 
    - we can apply that value to the background color
``` dart
return Scaffold(
    backgroundColor : Colors.red.withOpacity(controller.value),
);
```
8. this wont work outof the box, because you have to change the state 
``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:1),
        vsync:this,
    );
    controller.foward();
    controller.addListener((){
        setState(() {});
        print(controller.value);
    });
    super.initState();
}
```
![FlashChat1](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/36d26d08-dbe9-4a0e-b778-8b1ccb0ab102)
---
9. changing the lowerbounds and upperbounds of the animation controller
``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:1),
        vsync:this,
        upperBound : 100.0
    );
    controller.foward();
    controller.addListener((){
        setState(() {});
        print(controller.value);
    });
    super.initState();
}
```
10. Here we change the Flash Chat text to a loading percentage 
``` dart
Text('${controller.value.toInt()}%'),
```

![FlashChat2](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/86a38cc5-b2ea-4327-ad18-f2d18fbf757e)

---
11. we can change the size of the logo
``` dart
Hero(
    tag: 'logo',
    child: Container(
        child: Image.asset('images/logo.png'),
        height: controller.value,
        ),
    ),
```
![FlashChat3](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/29b5c33e-61dc-4923-896d-a6c826cebaab)

---
12. the changes are happening in a linear motion, we can change the way to changing the animation value in a curve using CurvedAnimation Class 
[https://api.flutter.dev/flutter/animation/CurvedAnimation-class.html]
13. in order to use curves we need an Animation type variable
``` dart
AnimationController controller;
Animation animation;
```
14. incide the init state we can initialize the animation variable using any type of animation
    - this curved animation class require 2 parameters
        - parent : what will we apply curved to 
        - in this case it will be our controller
        - curve : what kind of curve will we apply
        - curves cannot have upperbount greater than 1   
``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:1),
        vsync:this,
        upperBound : 100.0
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelaration);
    controller.foward();
    controller.addListener((){
        setState(() {});
        print(controller.value);
    });
    super.initState();
}
```
15. now we can use animation value instead of the controller value 
``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:1),
        vsync:this,
        upperBound : 100.0
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelaration);
    controller.foward();
    controller.addListener((){
        setState(() {});
        print(animation.value);
    });
    super.initState();
}
```
``` dart
Hero(
    tag: 'logo',
    child: Container(
        child: Image.asset('images/logo.png'),
        height: animation.value,
        ),
    ),
```
This code wont work. Because the upperbound cannot be greater than 1
``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:1),
        vsync:this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelaration);
    controller.foward();
    controller.addListener((){
        setState(() {});
        print(animation.value);
    });
    super.initState();
}
```
From 0 to 1 we can`t see anything special but if we multiply it by 100 we can
``` dart
Hero(
    tag: 'logo',
    child: Container(
        child: Image.asset('images/logo.png'),
        height: animation.value*100,
        ),
    ),
```
![FlashChat4](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/558df934-8773-4846-ae9b-a267e1229836)

---
16. what if we want our animation to go from large to small
``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:1),
        vsync:this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelaration);
    
    controller.reverse(from: 1.0);
    
    controller.addListener((){
        setState(() {});
        print(animation.value);
    });
    super.initState();
}
```
![FlashChat5](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/0ebbb70f-4feb-4847-9f34-a5cf7a2aea1e)

---
17. what if we want our animation to loop

To do that we want  to know when the reverse animation is compleated and the foward animation compleated 

To do this we can add an animation status listener
``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:1),
        vsync:this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelaration);
    
    controller.foward();

    animation.addStatusListener((status){
        print(status);
    });
    
    controller.addListener((){
        setState(() {});
        print(animation.value);
    });
    super.initState();
}
```
``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:1),
        vsync:this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelaration);
    
    controller.foward();

    animation.addStatusListener((status){
        if(status == AnimationStatus.compleated){
            controller.reverse(from:1.0);
        }else if(status == AnimationStatus.dismissed){
            controller.foward;
        }
    });
    
    controller.addListener((){
        setState(() {});
        print(animation.value);
    });
    super.initState();
}
```
This animation will last forewer unless if we trash the controller forewer 

```dart
@override
void dispose(){
    controller.dispose();
    super.dispose();
}
```
![FlashChat6](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/10a2e863-e25e-4644-bf13-2272cfbaba6b)

--- 
18. Making twin animations 
For a example, we have a starting color and we have an ending color our tween going from starting color to ending color 

``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:3),
        vsync:this,
    );
    animation = ColorTween(begin: Colors.red, end: Colors.blue).animate(controller); 
    
    controller.foward();

   
    
    controller.addListener((){
        setState(() {});
        print(animation.value);
    });
    super.initState();
}
```
``` dart
return Scaffold(
    backgroundColor : animation.value,
);
```
``` dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:3),
        vsync:this,
    );
    animation = ColorTween(begin: Colors.blueGray, end: Colors.white).animate(controller); 
    
    controller.foward();

   
    
    controller.addListener((){
        setState(() {});
        print(animation.value);
    });
    super.initState();
}
```
![FlashChat7](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/7a4c40a3-9abc-4678-ac6c-7807110a9405)

---
## Dart Mixings
Mixings are a way of reusing a class`s code in multiple class hierarchies 

1. lets consider a simple dart code 

``` dart
void main(){

}
```

2. let`s build a class called animal

``` dart
void main(){

}

class Animal{

} 
```
3. animals can move, let`s add that method to the class

``` dart
void main(){

}

class Animal{

    void move(){

    }

} 
```

4. let`s add some functionality to the method 


``` dart
void main(){

}

class Animal{

    void move(){
        print("changed the position");     
    }

} 
```
5. Now we can move the animal 

``` dart
void main(){
    Animal().move();
}

class Animal{

    void move(){
        print("changed the position");     
    }

} 
```
---
7. we can have another class called fish and it can inherit from the animal class

``` dart
void main(){
    Animal().move();
}

class Animal{

    void move(){
        print("changed the position");     
    }

} 

class fish extends Animal{

}

```
8. we can directly say fish move 

``` dart
void main(){
    Animal().move();
    fish().move();
}

class Animal{

    void move(){
        print("changed the position");     
    }

} 

class fish extends Animal{

}

```
9. we can consider another class called Birds, they are also Animals but the way fish moves and birds move is different
``` dart
void main(){
    Animal().move();
    fish().move();
}

class Animal{

    void move(){
        print("changed the position");     
    }

} 

class fish extends Animal{

}

class birds extends Animal{

}

```
10. suppose if we want to change the way of moving of fish and a bird to something else
``` dart
void main(){
    Animal().move();
    fish().move();
}

class Animal{

    void move(){
        print("changed the position");     
    }

} 

class fish extends Animal{
    @override
    void move(){
        super.move();
        print("by swimmming");
    }
}

class birds extends Animal{
    @override
    void move(){
        super.move();
        print("by flying");
    }
}

```
11. we can see the output 
``` dart
void main(){
    Animal().move();
    fish().move();
    bird().move();
}

class Animal{

    void move(){
        print("changed the position");     
    }

} 

class fish extends Animal{
    @override
    void move(){
        super.move();
        print("by swimmming");
    }
}

class birds extends Animal{
    @override
    void move(){
        super.move();
        print("by flying");
    }
}

```
---
12. lets create another class called ducks 
- here ducks can swim and fly 
- with extends you can only inherit from one class
- you can`t extends fish, birds, Animal
13. this will be solved by the with 
- instead of fish having a move method 
- instead of bird having a move method 
- we can anctully create a mixing and we can name it e.g. canSwim 
- this will basically has a method called swim, this will print changing the position by swimming
- we can create another mixing called canFly 
- we can have a fly method 

``` dart
void main(){
    Animal().move();
    fish().move();
    bird().move();
}

class Animal{

    void move(){
        print("changed the position");     
    }

} 

class fish extends Animal{
    @override
    void move(){
        super.move();
        print("by swimmming");
    }
}

class birds extends Animal{
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
```

14. now the duck can inherit from the animal class we can give it can fly and can swim ability by adding in the mixing 
- we encoporate a mixing by adding a keyword with after any class extensions and then we specify the names of the mixings here we have our can swim mixing we can add our can fly mixing

``` dart
void main(){
    Animal().move();
    fish().move();
    bird().move();
}

class Animal{

    void move(){
        print("changed the position");     
    }

} 

class fish extends Animal{
    @override
    void move(){
        super.move();
        print("by swimmming");
    }
}

class birds extends Animal{
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
class Duck extends Animal with CanSwim, CanFly{

}
```
15. we can test this out

``` dart
void main(){
    Animal().move();
    fish().move();
    bird().move();
    Duck().move();
    Duck().fly();
    Duck().swim();
}

class Animal{

    void move(){
        print("changed the position");     
    }

} 

class fish extends Animal{
    @override
    void move(){
        super.move();
        print("by swimmming");
    }
}

class birds extends Animal{
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
class Duck extends Animal with CanSwim, CanFly{
    
}
```
16. here you don`t have to inherit from anybody
``` dart
void main(){
    Animal().move();
    fish().move();
    bird().move();
    Duck().fly();
    Duck().swim();
}

class Animal{

    void move(){
        print("changed the position");     
    }

} 

class fish extends Animal{
    @override
    void move(){
        super.move();
        print("by swimmming");
    }
}

class birds extends Animal{
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
```
![Peek 2023-05-26 23-03](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/6e37f33f-ceee-48bc-8abf-72e08c9dd080)


## Pre Packaged Flutter Animations

Here we are using the package 
- animated_text_kit: ^4.2.2

``` yaml
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.2
  animated_text_kit: ^4.2.2
```
![Screenshot 2023-05-27 042829](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/06927fd7-b977-4e1e-a0e6-2a31518e61a5)

---

1. we can import the animated kit to the welcome screen
```dart
import 'package:animated_text_kit/animated_text_kit.dart';
```
2. we can change the text widget to a typewriter animated text kit
```dart
return SizedBox(
  width: 250.0,
  child: DefaultTextStyle(
    style: const TextStyle(
      fontSize: 30.0,
      fontFamily: 'Agne',
    ),
    child: AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText('Discipline is the best tool'),
        TypewriterAnimatedText('Design first, then code'),
        TypewriterAnimatedText('Do not patch bugs out, rewrite them'),
        TypewriterAnimatedText('Do not test bugs out, design them out'),
      ],
      onTap: () {
        print("Tap Event");
      },
    ),
  ),
);
```

``` dart
TypewriterAnimatedTextKit(
    text:['Flash_Chat'],
    textStyle : TextStyle(
                    color: Colors.black54,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
    ),
),
```
![FlashChat8](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/2b51a123-1b66-4f66-851a-8d431d43f06d)

---
3. refactoring the code 
- making stateless widgets for the buttons in the code 
```dart
class paddingButtons extends StatelessWidget {
  paddingButtons({ this.color , this.text, this.func});

   Color? color;
    String? text;
    VoidCallback? func;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: func,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            "$text",
          ),
        ),
      ),
    );
  }
}
```
```dart
 paddingButtons( color: Colors.lightBlueAccent, text: "Log In", func: (){
              Navigator.pushNamed(context, LoginScreen.id);
            }),
            paddingButtons( color: Colors.blueAccent, text: "Register", func: (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            }),
```