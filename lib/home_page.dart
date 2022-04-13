import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'flight_details.dart';
import 'main2.dart';
import 'style.dart';


class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.firstLetter}) : super(key: key);
  final String firstLetter;
  solve(){
  final Future<List<Recipe>> apiCall = fetchRecipe(firstLetter);
  return apiCall;}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text('Food',
              style: GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          foregroundColor: Colors.black,
          backgroundColor: const Color(0xffF3F3EA),
        ),
        body: Container(
          color: const Color(0xffF3F3EA),
          child: Center(
              child: FutureBuilder<List<Recipe>>(
                  future:  solve(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
                      return const Text('An error has ocurred!');
                    } else if (snapshot.hasData) {
                      return (RecipeList(recipes: snapshot.data!));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  })),
        )

        );
  }
}

class RecipeList extends StatelessWidget {
  const RecipeList({Key? key, required this.recipes}) : super(key: key);

  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextInputWidget(),
        Expanded(
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FlightsDetails(recipeDetails: recipes[index],)));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xffFBFBF4),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 13),
                          height: 200,
                          width: 150,
                          decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                            image: DecorationImage(
                              image: NetworkImage(
                                recipes[index].photoLink,
                              ),
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                        Container(
                          //color: Colors.blue,
                          width: 180,
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: recipes[index].recipeName.length < 25 ? Text(recipes[index].recipeName,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    )
                                        //const TextStyle(fontWeight: FontWeight.bold)),
                              ): Text(recipes[index].recipeName.substring(0,18)+'...',
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                                child: Text(recipes[index].category),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                                child: Text('View Details',
                                    style: TextStyle(fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Container(
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                  ),
              itemCount: recipes.length),
        ),
      ],
    );
    /*GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return Text(recipes[1].recipeName);
      },
    );*/
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
  String changeText(text){
    /*setState(() {
      this.text = text;
    });*/
    if(text != "") {
      print(text[0]);
      return text[0];
    }
    else {
      return "";
    }

  }


  @override
  Widget build(BuildContext context) {
    String value ="";
    return SizedBox(
      height: 150,
      child: Column(children: <Widget> [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: this.controller,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),labelText: "Enter a letter"),
            onChanged: (text) => value = this.changeText(text),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
              style: flatButtonStyle,
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(firstLetter: changeText(value),))
                );
              },
              child:  const Text('Get inspiration!')
          ),
        )
      ]),
    );
  }
}



