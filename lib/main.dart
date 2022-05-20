import 'package:flutter/material.dart';
import 'package:pesquisa_produtos_loja/pages/index/index.dart';
import 'package:pesquisa_produtos_loja/utils/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pesquisa Produtos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Index(),
    );
  }
}
