import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage() ,
    );
  }
}

class MyHomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: Text("Hello World!")),
       // body: Column(children: <Widget>[TestWidget(), TestWidget(), TestWidget()],));
        body: TextInputWidget());
  }
}
/*

class TestWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Text('Ce marfa');
  }
}*/
class TextInputWidget extends StatefulWidget{
  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}
class _TextInputWidgetState extends State<TextInputWidget>{

  final controller =  TextEditingController();
  String text = "";

  @override
  void dispose(){
    super.dispose();
        controller.dispose();
  }
  void changeText(text){
    if( text == "Merge") {
      controller.clear();
      text = "";
    }
    setState(() {
      this.text = text;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget> [
      TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.message),labelText: "Introdu un mesaj"),
        onChanged: (text) => this.changeText(text),
      ),
    Text(this.text)
    ]);
  }
}