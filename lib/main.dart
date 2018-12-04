import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);

      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("IMC"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.deepPurple,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person, size: 100, color: Colors.white),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Massa (kg)",
                      labelStyle: TextStyle(color: Colors.white)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua massa";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.white)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua altura";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                        onPressed: () {
                          if (_globalKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(
                              color: Colors.deepPurple, fontSize: 25.0),
                        ),
                        color: Colors.white),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
