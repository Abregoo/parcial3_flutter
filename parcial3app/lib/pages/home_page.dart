import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:parcial3app/pages/ingrediente_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List lstfoods = [];
  String pais = 'Canadian';

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
    if (mounted) {
      datosFood();
    }
  }

  void datosFood() {
    String dominio = 'themealdb.com', path = '/api/json/v1/1/filter.php';

    Map<String, String> qParams = {'a': pais};
    var url = Uri.https(dominio, path, qParams);

    http.get(url).then((value) {
      // print(value.body)
      if (value.statusCode == 200) {
        var decodejsonData = jsonDecode(value.body);
        lstfoods = decodejsonData['meals'];
        print(lstfoods[0]['strMeal']);

        setState(() {});
      } else {
        print("Fallee");
        print(value.statusCode);
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        separador(10),
        slideNombres("Majano Abrego Alejandra Guadaupe.25-3688-2018"),
        slideNombres("Raymundo Hernández Elmer Giovanni. 25-0491-2018"),
        separador(20),
        titulo2("Resetario de Comidas Canadienses."),
        separador(2),
        // btnError(),
        cardComidas(),
        //slideprueba(),
      ]),
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
              fontFamily: 'JosefinSans',
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

  titulo2(String titulo) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 0, top: 0),
        child: Text(
          titulo,
          style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 20,
              color: Color.fromARGB(255, 68, 2, 2),
              fontWeight: FontWeight.bold),
        ),
      ),
      margin: EdgeInsets.only(left: 10, right: 25),
      width: 400,
      height: 35,
      // decoration: BoxDecoration(
      //     color: Color.fromARGB(108, 255, 255, 255),
      //     borderRadius: BorderRadius.circular(15)),
    );
  }

  cardComidas() {
    return Expanded(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1),
          itemCount: lstfoods.length,
          itemBuilder: (context, index) {
            return Card(
              color: Color.fromARGB(92, 196, 199, 255),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => IngredientePage(
                              idComida: lstfoods[index]['idMeal']))));
                },
                child: Column(
                  children: [
                    Text(
                      lstfoods[index]['strMeal'],
                      style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: lstfoods[index]['strMealThumb'],
                        alignment: Alignment.center,
                        fit: BoxFit.fill,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

slideNombres(String dato) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Text(
              dato,
              style: TextStyle(
              fontFamily: 'JosefinSans',
              fontSize: 18,
              fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
  // =================================================================================
 

  btnError() {
    return ElevatedButton(
        child: Text("Presione el boton"),
        onPressed: () {
          datosFood();
        });
  }

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
        Color.fromARGB(255, 230, 138, 134),
        Color.fromARGB(255, 255, 122, 70),
        Color.fromARGB(255, 120, 255, 239),
      ],
    ));
  }
}
