import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main2.dart';


class FlightsDetails extends StatelessWidget {
  FlightsDetails({Key? key, required this.recipeDetails})
      : super(key: key);
  final Recipe recipeDetails;
  final ScrollController _firstController = ScrollController();

  String determineDifficulty() {
    int counterIngredients = 0;
    for (int i = 0; i < 20; i++) {
      if (recipeDetails.ingredients[i] != "") {
        counterIngredients++;
      }
    }
    if (counterIngredients < 7) {
      return "Simple";
    } else if (counterIngredients > 7 && counterIngredients < 10) {
      return "Medium";
    } else {
      return "Advanced";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Recipe'),
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: const Color(0xffF3F3EA),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: const Color(0xffFBFBF4),
          child: Center(
              child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 13),
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    image: DecorationImage(
                      image: NetworkImage(
                        recipeDetails.photoLink,
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.all(10),
                  child: Text(recipeDetails.recipeName,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.all(10),
                  child: Text('Origin : ${recipeDetails.countryOfOrigin}',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                      ))),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(10),
                child: Text(
                  'Difficulty Level: ${determineDifficulty()}',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.all(10),
                  child: Text('Ingredients',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ))),
              SizedBox(
                height: 200,
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _firstController,
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        if (recipeDetails.ingredients[index] != '') {
                          return Container(
                            color: Color(0xffF3F3EA),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(recipeDetails.ingredients[index]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(recipeDetails.measure[index],
                                  style: GoogleFonts.roboto(),),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          recipeDetails.ingredients[index] != ''
                              ? Container(
                                  height: 3,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: const BoxDecoration(
                                      color: Color(0xffFBFBF4),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
                                )
                              : Container(),
                      itemCount: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(recipeDetails.instructions,
                style: GoogleFonts.roboto(),),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text('Watch on Youtube ${recipeDetails.youtubeLink}',
                style: GoogleFonts.roboto(
                fontStyle: FontStyle.italic,
                fontSize: 14,
                ),),
              ),
            ],
          ))),
        ));
  }
}
