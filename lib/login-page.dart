import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';
import 'signup-page.dart';
import 'fire_auth.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.white,
  backgroundColor: Colors.green,
  minimumSize: const Size.fromHeight(40),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                height: 100,
                width: double.infinity,
                child: Image.asset('assets/images/google.png')),
            //SizedBox(height: 100),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.fromLTRB(20, 0, 50, 30),
                  child: const Text(
                    'Enter your email and password',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 20),
                  )),
              Container(
                width: 500,
                height: 70,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                alignment: Alignment.topLeft,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              )
            ]),
            Container(
              width: 500,
              height: 70,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              alignment: Alignment.topLeft,
              child: TextField(
                controller: passController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ),
            Container(
                width: 300,
                alignment: Alignment.bottomRight,
                child: const Text('Forgot password?')),
            const SizedBox(height: 10),
            SizedBox(
                width: 300,
                child: ElevatedButton(
                    onPressed: () async {
                      AuthService authserv = AuthService();
                      String? errorMsg = await authserv.login(
                          emailController.text, passController.text);
                      if (errorMsg == null) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage(firstLetter: '')),
                            (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Invalid Email or Password')));

                        /*if (errorMsg != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(errorMsg)));
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                            (route) => false);
                      }*/
                      }
                    },
                    style: flatButtonStyle,
                    child: const Text('Login'))),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  alignment: Alignment.bottomLeft,
                  child: const Text("Don't have an account  ?"),
                ),
                TextButton(
                    child: const Text('Sign Up'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
