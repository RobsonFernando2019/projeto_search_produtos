import 'package:flutter/material.dart';
import 'package:pesquisa_produtos_loja/bloc/products_bloc.dart';
import 'package:provider/provider.dart';

import 'widgets/body_page_widget.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ProductsBloC _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = ProductsBloC();
    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto busca produtos',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Busca Produtos'),
          backgroundColor: Colors.blue[900],
          centerTitle: true,
        ),
        body: Provider<ProductsBloC>.value(
          value: _bloc,
          child: BodyPage(tabController: _tabController),
        ),
      ),
    );
  }
}
