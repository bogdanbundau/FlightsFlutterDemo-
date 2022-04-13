import 'style.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class SearchPage extends StatelessWidget{
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: const Text("Search Page"), backgroundColor: Colors.green,),
        // body: Column(children: <Widget>[TestWidget(), TestWidget(), TestWidget()],));
        body: Center(child: TextInputWidget()));
  }
}
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
      Container(
        height: 300,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: this.controller,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),labelText: "Enter a letter"),
          onChanged: (text) => this.changeText(text),
        ),
      ),
      ElevatedButton(
          style: flatButtonStyle,
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(firstLetter: "",))
            );
          },
          child: const Text("Get inspiration!")
      )
    ]);
  }
}