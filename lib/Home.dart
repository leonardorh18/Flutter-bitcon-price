import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String resultado;

Future<Map> _atualizarPreco() async{

    String url = 'https://blockchain.info/ticker';
    http.Response response =  await http.get(url);
    return json.decode(response.body);


}
void preco() async{
  String url = 'https://blockchain.info/ticker';
  http.Response response =  await http.get(url);
  Map<String, dynamic> lista = json.decode(response.body);
  setState(() {
    resultado = lista['BRL']['buy'].toString();
  });



}
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _atualizarPreco(),
      builder: (context, snapshot){

        switch(snapshot.connectionState){

          case ConnectionState.none:
              resultado = 'Vazio';
            break;

          case ConnectionState.waiting:
            resultado = 'Carregando';

            break;
          case ConnectionState.done:

              resultado = snapshot.data['BRL']['buy'].toString();
            break;

          case ConnectionState.active:

            break;
        }
      return Scaffold(
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Image.asset('imagens/bitcoin.png'),

             Padding(
               padding: EdgeInsets.fromLTRB(15, 20, 15, 30),
               child: Text("R\$ "+ resultado,
               style: TextStyle(
                 color: Colors.lightGreen,
                 fontSize: 30,
               ),)
             ),
              RaisedButton(
                 child: Text("Atualizar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  ),
                  onPressed: preco,
                  color: Colors.amber,
                  padding:  EdgeInsets.fromLTRB(20, 10, 20, 10),
                  ),
            ],


          ),

        ),

      );
      }
    );
  }
}
