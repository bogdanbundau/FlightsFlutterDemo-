import 'package:flutter/material.dart';
import 'style.dart';

class HomePage extends StatelessWidget{
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child:
          Text('Titlu'),),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
                style: flatButtonStyle,
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text('Go back')
            )
          )
        )
    );
  }
}