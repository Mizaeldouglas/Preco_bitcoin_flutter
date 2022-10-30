import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _precoBitcoin = "R\$ 0";

  _atualizarBitcoin() async{
    var url = "https://blockchain.info/ticker";
    http.Response response;
    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode( response.body );
    String bitcoin = retorno["BRL"]["buy"].toString();

    setState(() {
     _precoBitcoin = retorno["BRL"]["buy"].toString();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/bitcoin.png",fit: BoxFit.cover,),
            Padding(padding: EdgeInsets.only(top: 35)),
            Text("R\$ $_precoBitcoin",style: TextStyle(fontSize: 35),),
            RaisedButton(
              color: Colors.orange,
             child: Text("Atualizar",style: TextStyle(fontSize: 25)),
                onPressed: _atualizarBitcoin
            )
          ],
        ),
      ),
    );
  }
}
