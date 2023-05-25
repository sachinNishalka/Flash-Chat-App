# Flutter Animation 
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


