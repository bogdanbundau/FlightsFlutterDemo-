import 'package:flutter/material.dart';
import 'package:flutter_application_1/fire_auth.dart';
import 'package:flutter_application_1/home_page.dart';
import 'login-page.dart';




class Signup extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  height: 250,
                  width: 400,
                  child: Image.asset('assets/images/google.png')),
              //SizedBox(height: 100),
              Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 30),
                  )),
              Container(
                width: 500,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                alignment: Alignment.topLeft,
                child: TextField(
                  controller: emailController,
                  decoration:  InputDecoration(labelText: 'Email'),
                ),
              ),
              Container(
                width: 500,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                alignment: Alignment.topLeft,
                child: TextField(
                  controller: passController,
                  decoration:  InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                child: const Text('Register'),
                  onPressed: () async {
                    AuthService authserv = AuthService();
                    String? errorMsg = await authserv.register(emailController.text, passController.text);

                    if(errorMsg != null){
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(errorMsg)));
                    }
                    else {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(firstLetter: '')), (route) => false);
                    }

                  },
                ),
            ],
          ),
        ),
    );
  }
}
