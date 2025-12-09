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
  List<dynamic> cuadricula = List.generate(
    30,
    (_) => [Colors.white, Colors.black, ""],
  );
  int cursorCuadricula = 0;
  int inicioFila = 0;

  List<dynamic> teclas = [
    [Colors.grey.shade300, Colors.black, "Q"],
    [Colors.grey.shade300, Colors.black, "W"],
    [Colors.grey.shade300, Colors.black, "E"],
    [Colors.grey.shade300, Colors.black, "R"],
    [Colors.grey.shade300, Colors.black, "T"],
    [Colors.grey.shade300, Colors.black, "Y"],
    [Colors.grey.shade300, Colors.black, "U"],
    [Colors.grey.shade300, Colors.black, "I"],
    [Colors.grey.shade300, Colors.black, "O"],
    [Colors.grey.shade300, Colors.black, "P"],
    [Colors.grey.shade300, Colors.black, "A"],
    [Colors.grey.shade300, Colors.black, "S"],
    [Colors.grey.shade300, Colors.black, "D"],
    [Colors.grey.shade300, Colors.black, "F"],
    [Colors.grey.shade300, Colors.black, "G"],
    [Colors.grey.shade300, Colors.black, "H"],
    [Colors.grey.shade300, Colors.black, "J"],
    [Colors.grey.shade300, Colors.black, "K"],
    [Colors.grey.shade300, Colors.black, "L"],
    [Colors.grey.shade300, Colors.black, "Ñ"],
    [Colors.grey.shade300, Colors.black, "ENVIAR"],
    [Colors.grey.shade300, Colors.black, "Z"],
    [Colors.grey.shade300, Colors.black, "X"],
    [Colors.grey.shade300, Colors.black, "C"],
    [Colors.grey.shade300, Colors.black, "V"],
    [Colors.grey.shade300, Colors.black, "B"],
    [Colors.grey.shade300, Colors.black, "N"],
    [Colors.grey.shade300, Colors.black, "M"],
    [Colors.grey.shade300, Colors.black, "<-"],
  ];

  Widget winner = Text("");
  bool finPartida = false;

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
                      (index) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          color: cuadricula[index][0],
                        ),
                        child: Center(
                          child: Text(
                            cuadricula[index][2],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: cuadricula[index][1],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Center(child: winner),

            Expanded(
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 700,
                      child: _recorrerLista(0),
                    ),
                  ),

                  Center(
                    child: SizedBox(
                      width: 700,
                      child: _recorrerLista(10),
                    ),
                  ),

                  Center(
                    child: SizedBox(
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
    List<int> finFila = [4, 9, 14, 19, 24, 29];

    Row fila = Row();

    if (teclas.indexOf(teclas[indice]) == 20) {
      List listaTemp = teclas.sublist(indice, teclas.length);

      fila = Row(
        children: List.generate(9, (index) {
          switch (listaTemp[index][2]) {
            case "ENVIAR":
              return Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (!finPartida) {
                          int indiceLetra = 0;
                          String palabraImpresa = "";

                          if (finFila.any((p) => cursorCuadricula == p)) {
                            for (
                            int i = cursorCuadricula - 4;
                            i <= cursorCuadricula;
                            i++
                            ) {
                              String letra = cuadricula[i][2];
                              palabraImpresa = palabraImpresa + letra;
                              int indiceTecla = teclas.indexWhere(
                                    (tecla) => tecla[2] == letra,
                              );

                              if (palabra.contains(letra)) {
                                if (palabra.indexOf(letra) == indiceLetra) {
                                  cuadricula[i][0] = Colors.green;
                                  cuadricula[i][1] = Colors.white;

                                  teclas[indiceTecla][0] = Colors.green;
                                  teclas[indiceTecla][1] = Colors.white;
                                } else {
                                  cuadricula[i][0] = Colors.yellow;
                                  cuadricula[i][1] = Colors.white;

                                  if (teclas[indiceTecla][0] != Colors.green) {
                                    teclas[indiceTecla][0] = Colors.yellow;
                                    teclas[indiceTecla][1] = Colors.white;
                                  }
                                }
                              } else {
                                cuadricula[i][0] = Colors.grey[700];
                                cuadricula[i][1] = Colors.white;

                                if (teclas[indiceTecla][0] != Colors.green &&
                                    teclas[indiceTecla][0] != Colors.yellow) {
                                  teclas[indiceTecla][0] = Colors.grey[700];
                                  teclas[indiceTecla][1] = Colors.white;
                                }
                              }

                              indiceLetra++;
                            }
                          }

                          cursorCuadricula++;
                          inicioFila = cursorCuadricula;

                          if (palabraImpresa == palabra) {
                            winner = Text("HAS GANADO", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold));
                            finPartida = true;

                          } else if (palabraImpresa != palabra && cursorCuadricula == cuadricula.length) {
                            winner = Text("HAS PERDIDO", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
                            finPartida = true;
                          }
                        }
                      });
                    },

                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      backgroundColor: listaTemp[index][0],
                    ),
                    child: Center(
                      child: Text(
                        listaTemp[index][2] + inicioFila.toString(),
                        style: TextStyle(
                          color: listaTemp[index][1],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                        if (!finPartida) {
                          if (inicioFila <= cursorCuadricula) {
                            if (cuadricula[cursorCuadricula][2] != "") {
                              cuadricula[cursorCuadricula][2] = "";
                              if (cursorCuadricula > 0) {
                                cursorCuadricula = cursorCuadricula - 1;
                              }
                            }
                          }
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      backgroundColor: listaTemp[index][0],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.backspace_outlined,
                        color: listaTemp[index][1],
                      ),
                    ),
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
                        if (!finPartida) {
                          if ((inicioFila + 4) > cursorCuadricula) {
                            for (
                            int i = cursorCuadricula;
                            i < cuadricula.length;
                            i++
                            ) {
                              if (cuadricula[i][2] == "") {
                                cursorCuadricula = i;
                                break;
                              }
                            }

                            cuadricula[cursorCuadricula][2] =
                            listaTemp[index][2];
                          }
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      backgroundColor: listaTemp[index][0],
                    ),
                    child: Center(
                      child: Text(
                        listaTemp[index][2],
                        style: TextStyle(
                          color: listaTemp[index][1],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
          }
        }),
      );
    } else {
      List listaTemp = teclas.sublist(indice, indice + 10);

      fila = Row(
        children: List.generate(
          10,
          (index) => Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(3, 0, 3, 10),
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (!finPartida) {
                      if ((inicioFila + 4) > cursorCuadricula) {
                        for (int i = cursorCuadricula; i <
                            cuadricula.length; i++) {
                          if (cuadricula[i][2] == "") {
                            cursorCuadricula = i;
                            break;
                          }
                        }

                        cuadricula[cursorCuadricula][2] = listaTemp[index][2];
                      }
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  backgroundColor: listaTemp[index][0],
                ),
                child: Center(
                  child: Text(
                    listaTemp[index][2],
                    style: TextStyle(
                      color: listaTemp[index][1],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return fila;
  }
}
