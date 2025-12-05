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
  @override
  Widget build(BuildContext context) {
    String palabra = "PASTO";
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
                      30,
                      (index) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
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
                    child: Container(
                      height: 60,
                      width: 700,
                      child: _recorrerLista(teclas, 0),
                    ),
                  ),

                  Center(
                    child: Container(
                      height: 60,
                      width: 700,
                      child: _recorrerLista(teclas, 10),
                    ),
                  ),

                  Center(
                    child: Container(
                      height: 60,
                      width: 700,
                      child: _recorrerLista(teclas, 20),
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
}

Row _recorrerLista(List<String> lista, int indice) {
  Row fila = Row();

  if (lista.indexOf(lista[indice]) == 20) {
    List<String> listaTemp = lista.sublist(indice, lista.length);

    fila = Row(
      children: List.generate(9, (index) {
        switch (listaTemp[index]) {
          case "ENVIAR":
            return Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.grey.shade300,
                ),
                child: Center(child: Text(listaTemp[index])),
              ),
            );
            break;
          case "<-":
            return Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.grey.shade300,
                ),
                child: Center(child: Icon(Icons.backspace_outlined)),
              ),
            );
            break;

          default:
            return Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.grey.shade300,
                ),
                child: Center(child: Text(listaTemp[index])),
              ),
            );
        }
      }),
    );
  } else {
    List<String> listaTemp = lista.sublist(indice, indice + 10);

    fila = Row(
      children: List.generate(
        10,
        (index) => Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(3, 0, 3, 10),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.grey.shade300,
            ),
            child: Center(child: Text(listaTemp[index])),
          ),
        ),
      ),
    );
  }
  return fila;
}
