<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

## Date of birth 

 DateofBirth package is a package that doesnt need to be described :D everything is clear

## Installation

 1. Add the latest version of package to your pubspec.yaml (and run dart pub get):
 ```yaml
dependencies:
  dateofbirth: ^0.0.3
 ```

 ## Features

    You can change:
    - Text Size
    - Text Color
    - Background Color
    - Border color 
    and much more 

## Example

 There are a number of properties that you can modify:
```dart

class TestingDateBirth extends StatelessWidget {
  const TestingDateBirth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ 
          DateOfBirth(
            backgroundColor: Colors.pinkAccent,
            borderColor: Colors.black,
           onDateTimeChanged: (datetime) {
             // here you get the Result as DateTime format 
           },
          ),
        ],
      ),
    );
  }
}
```
<img src="https://user-images.githubusercontent.com/36598259/220198226-6bb393f6-acb8-40b9-903d-f14ecf9405c8.jpg" height='600px' />

## Note

Please make sure to like it if you find it usefull for you 
Add Feedback and suggestions .
thanks a lot

## 🧑 Credits
This packages has been created by[Nine Hichem].
-`Github`: https://github.com/ninehichem
-`Email`: ninehichem10@gmail.com
-`Whatsapp`: +213561875818
-`Linkedin`: https://www.linkedin.com/in/hichem-nine-5b9a98175/