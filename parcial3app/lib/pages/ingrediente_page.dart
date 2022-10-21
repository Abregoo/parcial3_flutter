import 'package:cached_network_image/cached_network_image.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class IngredientePage extends StatefulWidget {
  IngredientePage({Key? key, required this.idComida}) : super(key: key);

  final String idComida;
  @override
  State<IngredientePage> createState() => _IngredientePageState();
}

class _IngredientePageState extends State<IngredientePage> {
  late List lstingred = [];
  late List lstdatosIngr = [];
  String nomcomida = '';
  String urlImg = 'https://www.themealdb.com/images/ingredients/';
  String urlPortada = 'https://www.pngmart.com/files/5/Snow-PNG-Transparent-Image.png';

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
    String dominio = 'themealdb.com', path = '/api/json/v1/1/lookup.php';

    Map<String, String> qParams = {'i': widget.idComida};
    var url = Uri.https(dominio, path, qParams);

    http.get(url).then((value) {
 
      if (value.statusCode == 200) {
        var decodejsonData = jsonDecode(value.body);
        lstingred = decodejsonData['meals'];
        nomcomida = lstingred[0]['strMeal'];
        urlPortada = lstingred[0]['strMealThumb'];


        lstdatosIngr.add(lstingred[0]['strIngredient1']);
        lstdatosIngr.add(lstingred[0]['strIngredient2']);
        lstdatosIngr.add(lstingred[0]['strIngredient3']);
        lstdatosIngr.add(lstingred[0]['strIngredient4']);
        lstdatosIngr.add(lstingred[0]['strIngredient5']);
        lstdatosIngr.add(lstingred[0]['strIngredient6']);
        lstdatosIngr.add(lstingred[0]['strIngredient7']);
        lstdatosIngr.add(lstingred[0]['strIngredient8']);
        lstdatosIngr.add(lstingred[0]['strIngredient9']);
        lstdatosIngr.add(lstingred[0]['strIngredient10']);
        lstdatosIngr.add(lstingred[0]['strIngredient11']);
        lstdatosIngr.add(lstingred[0]['strIngredient12']);
        lstdatosIngr.add(lstingred[0]['strIngredient13']);
        lstdatosIngr.add(lstingred[0]['strIngredient14']);
        lstdatosIngr.add(lstingred[0]['strIngredient15']);
        lstdatosIngr.add(lstingred[0]['strIngredient16']);
        lstdatosIngr.add(lstingred[0]['strIngredient17']);
        lstdatosIngr.add(lstingred[0]['strIngredient18']);
        lstdatosIngr.add(lstingred[0]['strIngredient19']);
        lstdatosIngr.add(lstingred[0]['strIngredient20']);



        setState(() {});
      } else {

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
        portadaComida(),
        titulos(nomcomida, 25.0),
        separador(10),
        titulo2("Ingredientes"),
        cardComidas(),
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
        padding: const EdgeInsets.only(left: 20, top: 12),
        child: Text(
          titulo,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'JosefinSans',
              fontSize: size,
              color: Color.fromARGB(255, 8, 32, 139),
              fontWeight: FontWeight.bold),
        ),
      ),
      margin: EdgeInsets.only(left: 25, right: 25),
      width: 400,
      height: 45,
      decoration: BoxDecoration(
          color: Color.fromARGB(24, 255, 255, 255),
          borderRadius: BorderRadius.circular(15)),
    );
  }

  cardComidas() {
    return Expanded(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1),
          //itemCount: lstingred.length,
          itemCount: lstdatosIngr.length,
          itemBuilder: (context, index) {
            // String keyimg = 'strIngredient'+i.toString();

            if (lstdatosIngr[index] != "" && lstdatosIngr[index] != null) {
              return Card(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: urlImg + lstdatosIngr[index] + ".png",
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
                    ),
                    Text(
                      lstdatosIngr[index],
                      style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Visibility(
                visible: false,
                child: Text(""),
              );
            }
          }),
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
      margin: EdgeInsets.only(left: 30, right: 25),
      width: 400,
      height: 35,
      // decoration: BoxDecoration(
      //     color: Color.fromARGB(108, 255, 255, 255),
      //     borderRadius: BorderRadius.circular(15)),
    );
  }

  portadaComida() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      width: 400,
      height: 200,
      child: CachedNetworkImage(
        imageUrl: urlPortada,
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
    );
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
        Color.fromARGB(255, 117, 210, 253),
        Color.fromARGB(255, 125, 136, 233),
        Color.fromARGB(255, 255, 122, 70),
        Color.fromARGB(255, 120, 255, 239),
      ],
    ));
  }
}
