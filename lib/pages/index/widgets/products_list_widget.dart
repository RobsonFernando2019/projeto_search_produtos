import 'package:flutter/material.dart';
import 'package:pesquisa_produtos_loja/bloc/products_bloc.dart';
import 'package:pesquisa_produtos_loja/models/response/product_model.dart';
import 'package:pesquisa_produtos_loja/pages/index/widgets/search_product.widget.dart';
import 'package:provider/provider.dart';

import 'error_display_widget.dart';
import 'product_details_widget.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<ProductsBloC>(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          child: SearchProduct(),
        ),
        Expanded(
          child: Container(
            child: StreamBuilder<List<ProductModel>>(
              stream: _bloc.filterProducts$,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ErrorDisplay(
                        onTryAgain: _bloc.getAllProducts,
                      ),
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'Nenhum produto encontrado',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
                var data = snapshot.data;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                  data: item,
                                  bloc: _bloc,
                                ),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                top: 4,
                                bottom: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(2.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF000000)
                                        .withOpacity(0.10),
                                    blurRadius: 1,
                                    offset: const Offset(0, 1),
                                  )
                                ],
                              ),
                              child: Card(
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      height: 80,
                                      width: 80,
                                      child: Image.network(('https:') +
                                          (item.apiFeaturedImage ?? '')),
                                    ),
                                    Expanded(
                                      child: Text(
                                        item.name ?? 'undefined',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
