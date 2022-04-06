import 'package:flutter/material.dart';
import 'home_page.dart';
import 'style.dart';

class LoginScreen extends StatelessWidget{
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title :const Center(
          child: Text('Login Screen'),),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
       child:  Container(
         margin: const EdgeInsets.symmetric(horizontal: 20.0),
    child: ElevatedButton(
          style: flatButtonStyle,
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage())
            );
        },
            child: const Text("Log In")
        )
      ))
    );
  }
}

