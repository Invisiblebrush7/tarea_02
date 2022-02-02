import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: HomePage(),
        theme: ThemeData(primarySwatch: Colors.green));
  }
}

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String altura = "0.0";
  String peso = "0.0";

  String gender = "";

  Color colorMale = Colors.grey;
  Color colorFemale = Colors.grey;

  Color heightIconColor = Colors.grey;
  Color weightIconColor = Colors.grey;

  var _controllerWeight = TextEditingController();
  var _controllerHeight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcular IMC'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                altura = "0.0";
                peso = "0.0";

                gender = "";
                colorMale = Colors.grey;
                colorFemale = Colors.grey;

                heightIconColor = Colors.grey;
                weightIconColor = Colors.grey;
                _controllerWeight.clear();
                _controllerHeight.clear();
              });
            },
            icon: Icon(Icons.app_blocking),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
        child: Column(
          children: [
            Text(
              "Ingrese sus datos para calcular el IMC",
              style: TextStyle(fontSize: 18.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (this.colorMale == Colors.green) {
                        this.colorMale = Colors.grey;
                        this.gender = "";
                      } else {
                        this.colorMale = Colors.green;
                        this.gender = "Hombre";
                      }
                      if (this.colorFemale == Colors.green) {
                        this.colorFemale = Colors.grey;
                      }
                    });
                  },
                  icon: Icon(
                    Icons.male,
                    color: this.colorMale,
                    size: 32.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (this.colorFemale == Colors.green) {
                        this.colorFemale = Colors.grey;
                        this.gender = "";
                      } else {
                        this.colorFemale = Colors.green;
                        this.gender = "Mujer";
                      }
                      if (this.colorMale == Colors.green) {
                        this.colorMale = Colors.grey;
                      }
                    });
                  },
                  icon: Icon(
                    Icons.female,
                    color: this.colorFemale,
                    size: 32.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controllerHeight,
                cursorColor: Colors.green,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (String value) {
                  this.altura = value;
                },
                decoration: getInputDecoration('Altura', 'Ingresa Altura'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controllerWeight,
                cursorColor: Colors.green,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (String value) {
                  this.peso = value;
                },
                decoration: getInputDecoration('Peso', 'Ingresar Peso'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextButton(
                onPressed: () {
                  showMyDialog(context, calculateIMC(this.altura, this.peso));
                },
                child: Text(
                  "Calcular",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration getInputDecoration(String title, String hintText) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
      icon: Icon(Icons.line_weight),
      labelText: title,
      hintText: hintText,
    );
  }

  Future<void> showMyDialog(BuildContext context, String imc) async {
    return showDialog<void>(
      context: context,
      builder: (_) => buildAlertDialog(imc),
    );
  }

  AlertDialog buildAlertDialog(String imc) {
    Text contentBody;
    if (this.gender == "Hombre") {
      contentBody = Text(
          "Tabla del IMC para hombres:\nEdad\tIMC Ideal\n19-24\t19-24\n25-34\t20-25\n35-44\t21-26\n");
    } else if (this.gender == "Mujer") {
      contentBody = Text(
          "Tabla del IMC para mujeres:\nEdad\tIMC Ideal\n19-24\t19-24\n25-34\t20-25\n35-44\t21-26\n");
    } else {
      contentBody = Text("Valores no válidos. Olvidaste seleccionar género");
    }

    AlertDialog alertDialog = AlertDialog(
      title: imc == "NaN"
          ? Text("No has ingresado valores válidos")
          : Text("Tu IMC es $imc"),
      content: contentBody,
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Aceptar"),
        )
      ],
    );
    return alertDialog;
  }

  String calculateIMC(String height, String weight) {
    double heightParsed = double.parse(height);
    double weightParsed = double.parse(weight);
    return (weightParsed / pow(heightParsed, 2)).toStringAsFixed(1);
  }
}
