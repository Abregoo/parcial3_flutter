import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List lstfoods = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getAppbar(),
      body: bodyApp(),
    );
  }

   @override
  void initState() {
    super.initState();
    if(mounted){
      datosFood();
    }
  }

  void datosFood() {
    var url = Uri.https('themealdb.com','/api/json/v1/1/filter.php?a=French');
    
    http.get(url).then((value) {
      // print(value.body)
      if (value.statusCode == 200) {
        var decodejsonData = jsonDecode(value.body);
        lstfoods = decodejsonData['meals'];
         print(lstfoods[0]['strMeal']);
        setState(() {});
      }else{
        print("Fallee");
      }
    });
  }

  getAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Gastronomía por el Mundo.",
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.food_bank,
              size: 60,
            )
          ],
        ),
      ),
    );
  }

  bodyApp() {
    return Container(
      decoration: fondo(),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          separador(10),
          titulos("Majano Abrego Alejandra Guadaupe. 25-3688-2018", 15.0),
          titulos("Raymundo Hernández Elmer Geovanny. 25-3688-2018", 15.0),
          separador(10),
          //cardComidas(),
          separador(800),
        ]),
      ),
    );
  }

  separador(double number) {
    return SizedBox(
      height: number,
    );
  }

  titulos(String titulo, double size) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 8),
        child: Text(
          titulo,
          style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: size,
              fontWeight: FontWeight.bold),
        ),
      ),
      margin: EdgeInsets.only(left: 25, right: 25),
      width: 400,
      height: 30,
      decoration: BoxDecoration(
          color: Color.fromARGB(108, 255, 255, 255),
          borderRadius: BorderRadius.circular(15)),
    );
  }

  cardComidas() {
    return Column(children: [
      // lstfoods ==null ?
      Expanded(
          child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 3),
        itemCount: lstfoods.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.greenAccent,
            child: Stack(children: [
              // Positioned(
              //     child: Image.asset(
              //   "assets/img/pokeball.png",
              //   height: 100,
              //   fit: BoxFit.fitHeight,
              // )),
              Column(
                children: [
                  Text(
                    lstfoods[index]['strMeal'],
                  ),
                  CachedNetworkImage(
                    imageUrl: lstfoods[index]['strMealThumb'],
                    alignment: Alignment.center,
                  )
                ],
              ),
            ]),
          );
        },
      ))
    ]);
  }

  // =================================================================================

  BoxDecoration fondo() {
    return const BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [
        0.1,
        0.4,
        0.6,
        0.9,
      ],
      colors: [
        Color.fromARGB(255, 245, 232, 93),
        Color.fromARGB(255, 238, 83, 77),
        Color.fromARGB(255, 255, 122, 70),
        Color.fromARGB(255, 54, 255, 232),
      ],
    ));
  }
}
