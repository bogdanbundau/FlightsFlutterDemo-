import 'package:flutter/material.dart';
import 'package:flutter_application_1/login-page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'login_screen.dart';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';

String generateRandomLetter(){
  var r = Random();
  int valueToConvert = r.nextInt(33) + 89;
  while(valueToConvert == 113 || valueToConvert == 117 || valueToConvert == 120 || valueToConvert == 122 || valueToConvert<97) {
    valueToConvert = r.nextInt(33) + 89;
  }
  String letter = String.fromCharCode(valueToConvert);
  return letter;
}

Future<List<Recipe>> fetchRecipe(String firstLetter) async{
  String randomLetter;
  if (firstLetter == ""){
   randomLetter= generateRandomLetter();}
  else {
    randomLetter = firstLetter;
  }
  final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?f=${randomLetter}'));
  final temporaryResponse = json.decode(response.body);
  if (response.statusCode == 200){
    Recipes recipe = new Recipes.fromJson(temporaryResponse);
    return recipe.listOfRecipes;
    //print(recipe.listOfRecipes[1].recipeName);
  }
  else{
    throw Exception('Failed to load a recipe!');
  }
}


class Recipe{
  final String recipeName;
  final String instructions;
  final String category;
  final String photoLink;
  final String countryOfOrigin;
  final String youtubeLink;
  final List<String>ingredients;
  final List<String>measure;



  const Recipe({
    required this.photoLink,
    required this.recipeName,
    required this.instructions,
    required this.category,
    required this.countryOfOrigin,
    required this.youtubeLink,
    required this.ingredients,
    required this.measure,
  });
  factory Recipe.fromJson(Map<String, dynamic> parsedJson){
    List<String> list = [] ;
    List<String> listMeasure = [];
    for(int i=1;i<21;i++) {
        list.add(parsedJson['strIngredient${i.toString()}'] ?? "" );
        listMeasure.add(parsedJson['strMeasure${i.toString()}']?? "");
    }

      //list.insert(i,"strIngredient"+i.toString());
    return Recipe(
        recipeName: parsedJson['strMeal'],
        instructions: parsedJson['strInstructions'],
        category: parsedJson['strCategory'],
        photoLink: parsedJson['strMealThumb'],
        countryOfOrigin: parsedJson['strArea'],
        youtubeLink: parsedJson['strYoutube']??'',
        ingredients: list,
        measure: listMeasure,
    );
  }
}


class Recipes{
  List <Recipe>listOfRecipes;
  Recipes({
    required this.listOfRecipes
});
  factory Recipes.fromJson(Map <String, dynamic> parsedJson){
    var list = parsedJson['meals'] as List;
    List<Recipe> temporaryList = list.map((i) => Recipe.fromJson(i)).toList();
    return Recipes(
        listOfRecipes: temporaryList
    );
  }
}



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

/*class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        title: "Login Screen",
        //theme: ThemeData(
        //  primarySwatch: Colors
        //),
        home: LoginScreen()

    );
  }
}*/
class MyApp extends StatefulWidget{
  const MyApp({Key? key}) : super(key:key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State <MyApp>{
  late Future <List<Recipe>> futureRecipe;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }

}
/*Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Recipe>>(
            future: futureRecipe,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
              return RecipeList(recipes:snapshot.data!);
              } else {
              return const Center(
              child: CircularProgressIndicator(),
              );
              }
            },
          ),
        ),
      ),*/