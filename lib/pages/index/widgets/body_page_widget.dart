import 'package:flutter/material.dart';
import 'package:pesquisa_produtos_loja/pages/index/widgets/products_list_widget.dart';

import 'favorite_page_widget.dart';

class BodyPage extends StatelessWidget {
  const BodyPage({
    required this.tabController,
  });
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        indicatorColor: Colors.black,
        tabs: <Tab>[
          Tab(
            child: Text(
              'Produtos',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Tab(
            child: Text(
              'Favoritos',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        controller: tabController,
      ),
      body: TabBarView(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            child: ProductsList(),
          ),
          FavoritesPage(),
        ],
        controller: tabController,
      ),
    );
  }
}
