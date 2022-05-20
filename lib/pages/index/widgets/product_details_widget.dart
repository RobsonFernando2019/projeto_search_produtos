import 'package:flutter/material.dart';
import 'package:pesquisa_produtos_loja/bloc/products_bloc.dart';
import 'package:pesquisa_produtos_loja/helpers/build_information.widget.dart';
import 'package:pesquisa_produtos_loja/models/response/product_model.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    required this.data,
    required this.bloc,
  });
  final ProductModel data;
  final ProductsBloC bloc;

  @override
  Widget build(BuildContext context) {
    bool result;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Detalhes do Produto'),
      ),
      body: Container(
        alignment: Alignment.center,
        height: double.maxFinite,
        color: Colors.grey[200],
        child: Column(
          children: [
            _buildProfile(data),
            Container(
              width: 230,
              child: ElevatedButton.icon(
                onPressed: () async {
                  result = await bloc.saveFavoriteUser(data);
                  if (result == true) {
                    _showSnackBar(context, 'Produto favoritado com sucesso');
                  } else {
                    _showSnackBar(context, 'Produto já se encontra favoritado');
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                icon: Icon(Icons.star_border_outlined),
                label: Text('Adicionar aos Favoritos'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 230,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                icon: Icon(Icons.arrow_back),
                label: Text('Voltar'),
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  _showSnackBar(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  _buildProfile(ProductModel data) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(15),
      child: Card(
        child: Column(
          children: [
            if (data.apiFeaturedImage != null)
              Container(
                margin: EdgeInsets.only(top: 25, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 110,
                width: 110,
                child: Image.network('https:' + (data.apiFeaturedImage ?? '')),
              ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildInformation(
                      title: 'Nome', information: data.name ?? 'Não possui'),
                  BuildInformation(
                    title: 'Valor',
                    information:
                        (data.priceSign ?? '') + ' ' + (data.price ?? ''),
                  ),
                  BuildInformation(
                      title: 'Marca', information: data.brand ?? 'Não possui'),
                  BuildInformation(
                      title: 'Categoria',
                      information: data.category ?? 'Não possui'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
