import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(TestLayout());
}

class TestLayout extends StatefulWidget {
  const TestLayout({super.key});

  @override
  State<TestLayout> createState() => _TestLayoutState();
}

class _TestLayoutState extends State<TestLayout> {
  List<dynamic> cuadricula = List.generate(30, (_) => [Colors.white, ""]);
  int posCuadricula = 0;
  List<String> teclas = [
    "Q",
    "W",
    "E",
    "R",
    "T",
    "Y",
    "U",
    "I",
    "O",
    "P",
    "A",
    "S",
    "D",
    "F",
    "G",
    "H",
    "J",
    "K",
    "L",
    "Ñ",
    "ENVIAR",
    "Z",
    "X",
    "C",
    "V",
    "B",
    "N",
    "M",
    "<-",
  ];

  String palabra = "PASTO";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "WORDLE (ES)",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          shape: Border(bottom: BorderSide(color: Colors.grey)),
        ),

        body: Column(
          children: [
            Center(
              child: Expanded(
                child: Container(
                  height: 400,
                  width: 320,
                  margin: EdgeInsets.all(20),
                  child: GridView.count(
                    crossAxisCount: 5,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,

                    children: List.generate(
                      cuadricula.length,
                          (index) =>
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              color: cuadricula[index][0],
                            ),
                            child: Center(
                              child: Text(
                                cuadricula[index][1],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: 60,
                      width: 700,
                      child: _recorrerLista(0),
                    ),
                  ),

                  Center(
                    child: SizedBox(
                      height: 60,
                      width: 700,
                      child: _recorrerLista(10),
                    ),
                  ),

                  Center(
                    child: SizedBox(
                      height: 60,
                      width: 700,
                      child: _recorrerLista(20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _recorrerLista(int indice) {
    Row fila = Row();

    if (teclas.indexOf(teclas[indice]) == 20) {
      List<String> listaTemp = teclas.sublist(indice, teclas.length);

      fila = Row(
        children: List.generate(9, (index) {
          switch (listaTemp[index]) {
            case "ENVIAR":
              return Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        List<int> finFila = [4, 9, 14, 19, 24, 29];
                        if (finFila.any((p) => p == posCuadricula)) {
                          for (int i = posCuadricula - 4; i <=
                              posCuadricula; i++) {
                            String letra = cuadricula[posCuadricula][1];
                            if (palabra.contains(letra)) {
                              if (palabra.indexOf(letra) == posCuadricula) {
                                cuadricula[posCuadricula][0] == Colors.green;
                              } else {
                                cuadricula[posCuadricula][0] == Colors.yellow;
                              }
                            } else {
                              cuadricula[posCuadricula][0] == Colors.grey[700];
                            }
                          }
                        };
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      backgroundColor: Colors.grey.shade300,
                    ),
                    child: Center(child: Text(listaTemp[index] + posCuadricula.toString())),
                  ),
                ),
              );

            case "<-":
              return Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (cuadricula[posCuadricula][1] != "") {
                          cuadricula[posCuadricula][1] = "";
                          if (posCuadricula > 0) {
                            posCuadricula = posCuadricula - 1;
                          }
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      backgroundColor: Colors.grey.shade300,
                    ),
                    child: Center(child: Icon(Icons.backspace_outlined)),
                  ),
                ),
              );

            default:
              return Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        for (
                        int i = posCuadricula;
                        i < cuadricula.length;
                        i++
                        ) {
                          if (cuadricula[i][1] == "") {
                            this.posCuadricula = i;
                            break;
                          }
                        }

                        cuadricula[this.posCuadricula][1] = listaTemp[index];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      backgroundColor: Colors.grey.shade300,
                    ),
                    child: Center(child: Text(listaTemp[index])),
                  ),
                ),
              );
          }
        }),
      );
    } else {
      List<String> listaTemp = teclas.sublist(indice, indice + 10);

      fila = Row(
        children: List.generate(
          10,
              (index) =>
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(3, 0, 3, 10),
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        for (int i = posCuadricula; i <
                            cuadricula.length; i++) {
                          if (cuadricula[i][1] == "") {
                            this.posCuadricula = i;
                            break;
                          }
                        }

                        cuadricula[this.posCuadricula][1] = listaTemp[index];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      backgroundColor: Colors.grey.shade300,
                    ),
                    child: Center(child: Text(listaTemp[index])),
                  ),
                ),
              ),
        ),
      );
    }
    return fila;
  }
}
