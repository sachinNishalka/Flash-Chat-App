# Flash Chat App using Flutter Animations and Fire Base

```bash
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

```dart
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

```dart
AnimationController controller;
```

2. We want to run the animation when the state object get initalized

```dart
@override
void initState(){
    super.initState();
}
```

3. Here we want to create animation controller

```dart
@override
void initState(){
    controller = AnimationController();
    super.initState();
}
```

4. Animation Contoller class have few properties
   - duration : How long do you want this animation to go for
   ```dart
   AnimationController(duration: Duration(seonds:1));
   ```
   - vsync : This is a required property and Here we provide the ticker provider
   - vsync : This will be the state object (This is like what will change when animation happens)
     - to change a state class to a ticker provider we have to add
     ```dart
     State<WelcomeScreen> with SingleTickerProviderStateMixing{}
     ```
   - upperBound :
   - lowerBound :

```dart
@override
void initState(){
    controller = AnimationController();
    super.initState();
}
```

```dart
@override
void initState(){
    controller = AnimationController(
        duration: Duration(seconds:1)
    );
    super.initState();
}
```

```dart
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

```dart
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

```dart
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

```dart
return Scaffold(
    backgroundColor : Colors.red.withOpacity(controller.value),
);
```

8. this wont work outof the box, because you have to change the state

```dart
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

## ![FlashChat1](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/36d26d08-dbe9-4a0e-b778-8b1ccb0ab102)

9. changing the lowerbounds and upperbounds of the animation controller

```dart
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

```dart
Text('${controller.value.toInt()}%'),
```

![FlashChat2](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/86a38cc5-b2ea-4327-ad18-f2d18fbf757e)

---

11. we can change the size of the logo

```dart
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

```dart
AnimationController controller;
Animation animation;
```

14. incide the init state we can initialize the animation variable using any type of animation
    - this curved animation class require 2 parameters
      - parent : what will we apply curved to
      - in this case it will be our controller
      - curve : what kind of curve will we apply
      - curves cannot have upperbount greater than 1

```dart
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

```dart
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

```dart
Hero(
    tag: 'logo',
    child: Container(
        child: Image.asset('images/logo.png'),
        height: animation.value,
        ),
    ),
```

This code wont work. Because the upperbound cannot be greater than 1

```dart
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

```dart
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

```dart
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

To do that we want to know when the reverse animation is compleated and the foward animation compleated

To do this we can add an animation status listener

```dart
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

```dart
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

```dart
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

```dart
return Scaffold(
    backgroundColor : animation.value,
);
```

```dart
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

```dart
void main(){

}
```

2. let`s build a class called animal

```dart
void main(){

}

class Animal{

}
```

3. animals can move, let`s add that method to the class

```dart
void main(){

}

class Animal{

    void move(){

    }

}
```

4. let`s add some functionality to the method

```dart
void main(){

}

class Animal{

    void move(){
        print("changed the position");
    }

}
```

5. Now we can move the animal

```dart
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

```dart
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

```dart
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

```dart
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

```dart
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

```dart
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

```dart
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

```dart
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

```dart
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

```dart
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

```yaml
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

```dart
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

---

4. changing the project folder structure

![Peek 2023-05-27 12-56](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/5e5ea824-8ead-474f-b206-6c78e0060b9c)

---

# Google Firebase

![Screenshot from 2023-05-27 15-41-53](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/d811669c-5df0-468d-ae29-3a4419c22c26)

1. to create the application for the android devices we need the app id

- its in build.gradle appId

```gradle
defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.example.flashchat"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
        minSdkVersion flutter.minSdkVersion
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
```

```gradle
defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.sachin.flashchat"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
        minSdkVersion flutter.minSdkVersion
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
```

2. add the google.json file to the project

![Screenshot 2023-05-27 112358](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/2c2391f6-272d-4345-8dec-23f6494d427c)

3. adding firebase

- firebase core should be added
- firebase auth
- cloud fire store

4. Additional changes I made for this project

- build.gradle

```gradle
defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.sachin.flashchat"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
        minSdkVersion 19
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        multiDexEnabled true
    }
```

- gradle.properties

```gradle
dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    implementation platform('com.google.firebase:firebase-bom:32.0.0')
    implementation 'androidx.multidex:multidex:2.0.1'
}
apply plugin: 'com.google.gms.google-services'
```

---

## User Authentication

### Registering User

1. in registration screen make two variables for username and password

```dart
class _RegistrationScreenState extends State<RegistrationScreen> {
  late String userName;
  late  String password;
```

2. set them according to the values change in text fields

```dart
        TextField(
        onChanged: (value) {
            userName = value;
            },
            decoration: kInputDecoration.copyWith(hintText: "Enter your email"),
        ),
),
```

3. to check things up we can print out the email and password when the button pressed

```dart
paddingButtons(
    color: Colors.blueAccent,
    func: () {
        print("username : $userName");
        print("passeord : $password");
    },
    text: 'Register',
),
```

4. then we can center the text in the text fields

```dart
TextField(
    textAlign: TextAlign.center,
    onChanged: (value) {
        userName = value;
    },
    decoration:
      kInputDecoration.copyWith(hintText: "Enter your email"),
),
```

5. we can change the password field to a password field by using obsecure text

```dart
TextField(
    textAlign: TextAlign.center,
    obscureText: true,
        onChanged: (value) {
            password = value;
    },
    decoration:
    kInputDecoration.copyWith(hintText: "Enter your password"),
),
```

6. we can take email typing keyboard for email field using keyboard type : text input type . email address

```dart
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,

              onChanged: (value) {
                userName = value;
              },
              decoration:
                  kInputDecoration.copyWith(hintText: "Enter your email"),
            ),
```

7. apply the same features to the loggin screen
8. import the firebase authentication

```dart
import 'package:firebase_auth/firebase_auth.dart';
```

9. incide the registration screen state create new instance of firebase auth

```dart
class _RegistrationScreenState extends State<RegistrationScreen> {
  late String userName;
  late String password;

  FirebaseAuth registeredUser = FirebaseAuth.instance;
```

10. incide the regisration button use the firebase authentication instance and one of its method called create user with authentication

```dart
class _RegistrationScreenState extends State<RegistrationScreen> {
  late String userName;
  late String password;

  FirebaseAuth registeredUser = FirebaseAuth.instance;
```

```dart
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}
```

11. put the email and password to the method and get the async output and put in to another variable like user

```dart
            paddingButtons(
              color: Colors.blueAccent,
              func: () {
                registeredUser.createUserWithEmailAndPassword(email: userName, password: password);
              },
              text: 'Register',
            ),
```

12. we can use a try and catch to catch any errors that might occur we can print the exception

```dart
            paddingButtons(
              color: Colors.blueAccent,
              func: () {
               try {
                 Future user = registeredUser.createUserWithEmailAndPassword(email: userName, password: password);
               } on Exception catch (e) {
                 print(e);
               }
              },
              text: 'Register',
            ),
```

13. if the new user is created then navigate the user to the chat screen

```dart
            paddingButtons(
              color: Colors.blueAccent,
              func: () async{
               try {
                var user = await registeredUser.createUserWithEmailAndPassword(email: userName, password: password);
                 if(user != null ){
                    Navigator.pushNamed(context, ChatScreen.id);
                 }
               } on Exception catch (e) {
                 print(e);
               }
              },
              text: 'Register',
            ),
```

14. now start coding the chat screen
15. now we need the current users email address
16. import the auth package
17. create another firebase auth instance
18. create a method to get the current user

```dart
  void getCurrentUser(){

  }
```

19. this method will check is there any current user who is singed in
20. usually when the registration is success, that user will be saved to auth object as the current user
21. create a final variable called user and set it to auth object and get the current user by the method

```dart
  void getCurrentUser() async{
    final user = await registeredUser.currentUser;
  }
```

22. this function will also be an async function
23. create a varibale called firebase user called logged in user and assign the user to that logged in user

```dart
late final User loggedInUser;

  void getCurrentUser() async{
    final user = await registeredUser.currentUser;
    loggedInUser = user!;
  }

```

24. wrap the entire thing in a try and a catch block

```dart
void getCurrentUser() async{
    try {
      final user = await registeredUser.currentUser;
      loggedInUser = user!;
    } on Exception catch (e) {
      print(e);
    }
  }
```

25. trigger the method when the state is initialized

```dart
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

```

26. to enable this loggin in method go to the firebase console
27. go to the develop section
28. click on the authentication section
29. create a sing in method
30. enable email password sign in
31. happy hacking test the app! 😊

![FlashChat9](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/c6341add-4be6-45c9-baa5-cf2951bd8217)

---

### Authenticating User

1. import the firebase authentication package

```dart
import 'package:firebase_auth/firebase_auth.dart';
```

2. create variables for username and password

```dart
class _LoginScreenState extends State<LoginScreen> {

  late String username;
  late String password;
```

3. getting username and password to the variables from the text field

```dart
            TextField(
              style: TextStyle(color: Colors.black54),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                //Do something with the user input.
                username = value.toString();
              },
              decoration:
                  kInputDecoration.copyWith(hintText: "Enter your email"),
            ),

```

```dart
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
                password = value.toString();
              },
              decoration:
                  kInputDecoration.copyWith(hintText: "Enter your password"),
            ),
```

4. creating an instance of the firebaseauth

```dart
FirebaseAuth checkUser =  FirebaseAuth.instance;
```

5. checking the weather the user is valid or not

```dart
            paddingButtons(
              text: 'Log In',
              func: () async{
                var user = await checkUser.signInWithEmailAndPassword(email: username, password: password);
                if(user != null){
                  print("valid user");
                }else{
                  print('not a valid user');
                }
              },
              color: Colors.lightBlueAccent,
            ),
```

6. making the instance private

```dart
  FirebaseAuth _checkUser =  FirebaseAuth.instance;
```

7. taking the user to the chat screen

```dart
            paddingButtons(
              text: 'Log In',
              func: () async{
                var user = await _checkUser.signInWithEmailAndPassword(email: username, password: password);
                if(user != null){
                  // print("valid user")
                  Navigator.pushNamed(context, ChatScreen.id);
                }else{
                  print('not a valid user');
                }
              },
              color: Colors.lightBlueAccent,
            ),
```

8. error handling using try and catch

```dart
            paddingButtons(
              text: 'Log In',
              func: () async{
                try {
                  var user = await _checkUser.signInWithEmailAndPassword(email: username, password: password);
                  if(user != null){
                    // print("valid user")
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } on Exception catch (e) {
                  // TODO
                  print(e);
                }
              },
              color: Colors.lightBlueAccent,
            ),
```

![FlashChat10](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/21afe2cc-a467-49b0-b3ac-698df62b6fac)

9. making the sign out function

```dart
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _registeredUser.signOut();
                Navigator.pop(context);
                //Implement logout functionality
            }),
```

![FlashChat11](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/0654c97d-317f-4712-a424-169eaf02aca2)

---

## Waiting Spinner

1. to add a loading screen we use package model progress hud

```yaml
modal_progress_hud_nsn: ^0.4.0
```

2. now we can import it to the registration screen

```dart
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
```

3. to use it, we can wrap it around the body

   ```dart
   body: ModalProgressHUD(
       inAsyncCall: showSpinner,
       child: Padding(
         padding: EdgeInsets.symmetric(horizontal: 24.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: <Widget>[
             Hero(
               tag: 'logo',
               child: Container(
                 height: 200.0,
                 child: Image.asset('images/logo.png'),
               ),
             ),
             SizedBox(
               height: 48.0,
             ),
             TextField(
               textAlign: TextAlign.center,
               keyboardType: TextInputType.emailAddress,
               onChanged: (value) {
                 userName = value;
               },
               decoration:
                   kInputDecoration.copyWith(hintText: "Enter your email"),
             ),
             SizedBox(
               height: 8.0,
             ),
             TextField(
               textAlign: TextAlign.center,
               obscureText: true,
               onChanged: (value) {
                 password = value;
               },
               decoration:
                   kInputDecoration.copyWith(hintText: "Enter your password"),
             ),
             SizedBox(
               height: 24.0,
             ),
             paddingButtons(
               color: Colors.blueAccent,
               func: () async {
                 try {
                   var user =
                       await registeredUser.createUserWithEmailAndPassword(
                           email: userName, password: password);
                   if (user != null) {
                     Navigator.pushNamed(context, ChatScreen.id);
                   }
                 } on Exception catch (e) {
                   print(e);
                 }
               },
               text: 'Register',
             ),
           ],
         ),
       ),
     ),
   );
   ```

4. to do this we have to create a boolean called showSpinner

   ```dart
   bool showSpinner = false;
   ```

5. wrap the entire body with model progess hud widget

   ```dart
   body: ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                userName = value;
              },
              decoration:
                  kInputDecoration.copyWith(hintText: "Enter your email"),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration:
                  kInputDecoration.copyWith(hintText: "Enter your password"),
            ),
            SizedBox(
              height: 24.0,
            ),
            paddingButtons(
              color: Colors.blueAccent,
              func: () async {
                try {
                  var user =
                      await registeredUser.createUserWithEmailAndPassword(
                          email: userName, password: password);
                  if (user != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } on Exception catch (e) {
                  print(e);
                }
              },
              text: 'Register',
            ),
          ],
        ),
      ),
    ),
   );
   ```

6. then we can call the inAsyncCall property and this can be set to the showSpinner property

```dart
body: ModalProgressHUD(
        inAsyncCall: showSpinner,
```

7. when the user clicks the button, the spinner should start spinning, to do that make a setState when the button pressed and make the showSpinner property to true

```dart
paddingButtons(
                color: Colors.blueAccent,
                func: () async {
                  setState(() {
                    showSpinner = true;
                  });

                  try {
                    var user =
                        await registeredUser.createUserWithEmailAndPassword(
                            email: userName, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
```

8. after getting the registered user the spinner should stop, for that create another setState and set the property to false

```dart
              paddingButtons(
                color: Colors.blueAccent,
                func: () async {
                  setState(() {
                    showSpinner = true;
                  });

                  try {
                    var user =
                        await registeredUser.createUserWithEmailAndPassword(
                            email: userName, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } on Exception catch (e) {
                    print(e);
                  }
                },
                text: 'Register',
              ),
```

## ![FlashChat12](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/d7665217-22ba-46e5-9c27-536f17b5c0d8)

---

# Registering Data in FireStore

1. start coding in chat screen
2. import cloud firestrore package

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
```

3. create a variable to store message text

4. set the value of the text field to message text

```dart
Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                        message = value.toString();
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
```

5. to send data we need message and sender , the logged in user
6. create an instance of firestore

```dart
CollectionReference firebase_messages = FirebaseFirestore.instance.collection('/messages');
```

7. tap in to firestore collection and use the add method

```dart
CollectionReference firebase_messages = FirebaseFirestore.instance.collection('/messages');
                      firebase_messages.add({
                        'message': message,
                        'sender':loggedInUser.email
                      });
```

![FlashChat12](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/be124a97-5e30-4005-af5b-edb3f6cc5979)

---

# Listening to the data from firestore

1. create a method to get messages from the firestore

```dart
void getMessages(){

  }

```

2. to get the data get into the firestore collection and select the document and call the get document method

```dart
void getMessages() async{
     final message = await _fireStore.collection('/message').get();
  }

```

3. this will return a future query snapshot and this is a data type comes in firebase

4. to use the result we have to await for it
5. get the data to a final variable and call it messages

```dart
 void getMessages() async{
     final message = await _fireStore.collection('/message').get();
     for(var message in message.docs){

     }
  }

```

6. this messages will be a list and we can use a for in loop to loop throught the list

```dart
  void getMessages() async{
     final message = await _fireStore.collection('/message').get();
     for(var message in message.docs){
        print(message);
     }
  }

```

7. to check this we can print and see the data

```dart
void getMessages() async {
    final message = await _fireStore.collection('/messages').get();
    for (var message in message.docs) {
      print(message.id);
    }
  }
```

8. to get real time data from the database we can use streams
9. create a method called messages stream

```dart
void messageStream(){

}
```

10. for this we can use query snapshot stream using the snapshot method , this will be a like a list of future objects
11. we can loop throught that list of future object and get snapshot.documents
12. then we can loop thorught snapshot documents and get the messages

```dart
void messageStream() async {
    await for (var snapshot in _fireStore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }
```

![FlashChat13](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/ef43c5a4-b276-48da-ad9e-1173d5b12278)

---

# Using Stream Builders

1. We can use a widget called stream builder to show up messages when there is new message.

```dart
StreamBuilder(builder: builder),
```

2. steam builder will have two colunms, stream : where is the data come from, next thing is a builder : have to provide a build stratergy, other wise the logic to build something.
3. provide context and snapshot

```dart
StreamBuilder<QuerySnapshot>(
                      stream: _fireStore.collection('messages').snapshots(),
                      builder: (context, snapshot) {

                      })
```

4. check if snapshot has the data
5. take messages from snapshot.data
6. change the data type of the streamBuilder to <QuerySnapshot>
7. access the document of snapshot.data.document

```dart
StreamBuilder<QuerySnapshot>(
                      stream: _fireStore.collection('messages').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final message = snapshot.data!.docs;
                        }
                      }),
```

8. to store the message data create a list of text widgets

```dart
List<Text> messageWidgets=[];
```

9. using a for in loop
10. take the final messageText = message.data['text']
11. next we have to take the message sender
12. make the final messageWidget
13. add the widget into the list
14. return the column with text widgets

```dart
StreamBuilder<QuerySnapshot>(
                stream: _fireStore.collection('/messages').snapshots(),
                builder: (context, snapshot) {
                  List<Text> messageWidgets = [];
                  if (!snapshot.hasData) {}

                  final messages = snapshot.data!;
                  for (var message in messages.docs) {
                    final messageText = message['message'];
                    final messageSender = message['sender'].toString();
                    final messageWidget =
                        Text('$messageText from $messageSender');
                    messageWidgets.add(messageWidget);
                  }
                  return Column(
                    children: messageWidgets,
                  );
                }),
```

![FlashChat14](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/02375aff-8be2-4f40-a548-f918842d2b1d)

---

# Flutter List Views

1. list view is used to scroll through the messages
2. instead of using a column widget use a list view widget

```dart
return ListView(
                    children: messageWidgets,
                  );
```

3. wrap the list view using expanded widget

```dart
return Expanded(
                    child: ListView(
                      children: messageWidgets,
                    ),
                  );
```

4. add horizontal 10 and vertical 20 padding to list view

```dart
return Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                      children: messageWidgets,
                    ),
                  );
```

5. create a new stateless widget called message bubble

```dart
class MessageBubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text('');
  }
}

```

6. return the text widget through the message bubble
7. create two final string variables called sender and text

```dart
class MessageBubble extends StatelessWidget {

  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Text('$text from $sender');
  }
}

```

8. use a constructor to initialize these values

```dart
class MessageBubble extends StatelessWidget {

  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Text('$text from $sender');
  }
}

```

9. wrap the text widget using a material widget

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Text('$text from $sender'),
    );
  }
}
```

10. pass message bubble to the message widget

```dart
StreamBuilder<QuerySnapshot>(
                stream: _fireStore.collection('/messages').snapshots(),
                builder: (context, snapshot) {
                  List<Widget> messageWidgets = [];
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }

                  final messages = snapshot.data!;
                  for (var message in messages.docs) {
                    final messageText = message['message'];
                    final messageSender = message['sender'].toString();

                    final messageWidget =
                        MessageBubble(text: messageText, sender: messageSender);
                    messageWidgets.add(messageWidget);
                  }
                  return Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      children: messageWidgets,
                    ),
                  );
                }),
```

11. refactor the messagewidget to message bubble

```dart
final messageBubble = MessageBubble(text: messageText, sender: messageSender);
messageWidgets.add(messageBubble);
```

12. refactoe the messagewidgets to list of message bubbles

```dart
 List<Widget> messageBubbles = [];
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }

                  final messages = snapshot.data!;
                  for (var message in messages.docs) {
                    final messageText = message['message'];
                    final messageSender = message['sender'].toString();

                    final messageBubble =
                        MessageBubble(text: messageText, sender: messageSender);
                    messageBubbles.add(messageBubble);
                  }
                  return Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      children: messageBubbles,
```

13. change the data type of the list widget to message bubble widget

```dart
List<MessageBubble> messageBubbles = [];
```

14. for material widget give it e color of light blue

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlue,
      child: Text('$text from $sender'),
    );
  }
}
```

15. add padding to the material widget from edge insets all 10px

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        color: Colors.lightBlue,
        child: Text('$text from $sender'),
      ),
    );
  }
}
```

16. change the text styele color to white and font size to 15px

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        color: Colors.lightBlue,
        child: Text('$text from $sender', style: TextStyle(color: Colors.white, fontSize: 15.0),),
      ),
    );
  }
}

```

17. wrap the text wiget using padding widget and use vertical padding of 10px and horizontal padding of 20px

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        color: Colors.lightBlue,
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Text('$text from $sender', style: TextStyle(color: Colors.white, fontSize: 15.0),),
        ),
      ),
    );
  }
}

```

18. add 5px of elevation to material

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        elevation: 5.0,
        color: Colors.lightBlue,
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Text('$text from $sender', style: TextStyle(color: Colors.white, fontSize: 15.0),),
        ),
      ),
    );
  }
}
```

19. add 30px of circular radius to the material

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        color: Colors.lightBlue,
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Text('$text from $sender', style: TextStyle(color: Colors.white, fontSize: 15.0),),
        ),
      ),
    );
  }
}
```

20. wrap the material incide a column widget

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 5.0,
            color: Colors.lightBlue,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text('$text from $sender', style: TextStyle(color: Colors.white, fontSize: 15.0),),
            ),
          ),
        ],
      ),
    );
  }
}

```

21. add a text widget at the top of the bubble

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text('$sender'),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 5.0,
            color: Colors.lightBlue,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text('$text', style: TextStyle(color: Colors.white, fontSize: 15.0),),
            ),
          ),
        ],
      ),
    );
  }
}
```

22. change the font size of the text widget to 12

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12.0),
          ),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 5.0,
            color: Colors.lightBlue,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

23. change the color to black54

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 5.0,
            color: Colors.lightBlue,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

24. change the cross axis allignment of the column to end

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 5.0,
            color: Colors.lightBlue,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

25. create another stateless widget called messagesstream

```dart
class SteamBuilder extends StatelessWidget {
  const SteamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```

26. return the steam builder through that widget

```dart
class SteamBuilder extends StatelessWidget {
  const SteamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('/messages').snapshots(),
        builder: (context, snapshot) {
          List<MessageBubble> messageBubbles = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }

          final messages = snapshot.data!;
          for (var message in messages.docs) {
            final messageText = message['message'];
            final messageSender = message['sender'].toString();

            final messageBubble =
            MessageBubble(text: messageText, sender: messageSender);
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        });
  }
}
```

27. call the message steam

```dart
 body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SteamBuilder(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
```

28. move the fire store to a place all the files can access

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


FirebaseFirestore _fireStore = FirebaseFirestore.instance;

```

29. create a text editing controller for message text field

```dart
class _ChatScreenState extends State<ChatScreen> {
  FirebaseAuth _registeredUser = FirebaseAuth.instance;
  late final User loggedInUser;
  late String message;
  final messageTextController = TextEditingController();
```

30. set the controller to the text field

```dart
  child: TextField(
                      controller: messageTextController,
```

31. tap in to the messagetext contorller and clear the text

```dart
TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      CollectionReference firebase_messages =
                          FirebaseFirestore.instance.collection('/messages');
                      firebase_messages.add(
                          {'message': message, 'sender': loggedInUser.email});
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
```

![FlashChat15](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/c701b45a-ba3f-47af-86f5-07ee785092a6)

---

# Managing Display Ratio For Different Screens

1. To handle diffent screen sizes we can use Flexible widget
2. Wrap the Hero widget with the flexible widget

```dart
Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
```

3. wrap the login screen hero with a flexible widget too

---

# Changing the color and the allignment of message bubbles

1. change the border radius of the material app to border radius only
2. change the top left, bottom left, bottom right to 30.0

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  late String text;
  late String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30.0),),
            elevation: 5.0,
            color: Colors.lightBlue,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

3. move the logged in user to a global state

```dart

FirebaseFirestore _fireStore = FirebaseFirestore.instance;
late final User loggedInUser;

```

4. take the email of the current user
5. check wheather the current user is the message user

```dart
 currentUser = loggedInUser.email;

            if(currentUser == messageSender){

            }
```

6. create a boolean variable in message bubble widget called is me
7. check whether the current user is sending user incide the message bubble widget use if else or something else
8. change the color according to the user

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender, required this.isMe});

  late String text;
  late String sender;
  late bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isMe? Colors.lightBlue : Colors.green,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

```dart
class SteamBuilder extends StatelessWidget {
  const SteamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('/messages').snapshots(),
        builder: (context, snapshot) {
          List<MessageBubble> messageBubbles = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }

          final messages = snapshot.data!;
          for (var message in messages.docs) {
            final messageText = message['message'];
            final messageSender = message['sender'].toString();

            final currentUser = loggedInUser.email;

            if (currentUser == messageSender) {}

            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        });
  }
}

```

9. move the others messages to the right

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender, required this.isMe});

  late String text;
  late String sender;
  late bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isMe? Colors.lightBlue : Colors.green,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

10. chaanging the others messages corners

```dart
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender, required this.isMe});

  late String text;
  late String sender;
  late bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: isMe? BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30.0),
            ): BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isMe? Colors.lightBlue : Colors.green,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

11. Taking the new messages to the bottom of the list
12. make the list view reverse true
13. make the snapshot also reversed

```dart
class SteamBuilder extends StatelessWidget {
  const SteamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('/messages').snapshots(),
        builder: (context, snapshot) {
          List<MessageBubble> messageBubbles = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }

          final messages = snapshot.data!;
          for (var message in messages.docs.reversed) {
            final messageText = message['message'];
            final messageSender = message['sender'].toString();

            final currentUser = loggedInUser.email;

            if (currentUser == messageSender) {}

            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        });
  }
}
```

# Happy Hacking 😊 !

![FlashChat16](https://github.com/sachinNishalka/Flash-Chat-App/assets/72740598/75c24ae3-035d-45a9-8465-a0018de60f41)
