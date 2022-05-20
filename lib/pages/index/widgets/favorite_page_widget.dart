import 'package:flutter/material.dart';
import 'package:pesquisa_produtos_loja/bloc/products_bloc.dart';
import 'package:pesquisa_produtos_loja/helpers/build_information.widget.dart';
import 'package:pesquisa_produtos_loja/models/response/product_model.dart';
import 'package:provider/provider.dart';

import 'error_display_widget.dart';
import 'product_details_widget.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<ProductsBloC>(context);
    _bloc.loadLocalFavoritedProducts();
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey[200],
            child: StreamBuilder<List<ProductModel>>(
              stream: _bloc.listLocalProducts$,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ErrorDisplay(onTryAgain: _bloc.getAllProducts),
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum produto favorito encontrado',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }

                var data = snapshot.data;
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return Row(
                            children: [
                              Expanded(
                                child: InkWell(
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                BuildInformation(
                                                  title: 'Nome',
                                                  information:
                                                      item.name ?? 'Não possui',
                                                  fontSizeTitle: 16,
                                                  fontSizeInformation: 15,
                                                ),
                                                BuildInformation(
                                                  title: 'Valor',
                                                  information:
                                                      (item.priceSign ?? '') +
                                                          ' ' +
                                                          (item.price ?? ''),
                                                ),
                                                BuildInformation(
                                                    title: 'Marca',
                                                    information: item.brand ??
                                                        'Não possui'),
                                                BuildInformation(
                                                    title: 'Categoria',
                                                    information:
                                                        item.category ??
                                                            'Não possui'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: 'Remover Favorito',
                                child: Container(
                                  margin: EdgeInsets.all(6),
                                  child: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      _bloc.removeLocalProduct(item.id ?? 0);
                                      _showSnackBar(context);
                                    },
                                  ),
                                ),
                              )
                            ],
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

  _showSnackBar(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Produto removido com sucesso'),
      duration: const Duration(seconds: 2),
    ));
  }
}
