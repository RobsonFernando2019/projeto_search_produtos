import 'package:flutter/material.dart';
import 'package:pesquisa_produtos_loja/bloc/products_bloc.dart';

import 'package:provider/provider.dart';

class SearchProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _searchUserController = TextEditingController();
    final _bloc = Provider.of<ProductsBloC>(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            child: TextFormField(
              controller: _searchUserController,
              onChanged: _bloc.onChangeSearchProduct,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                hintText: 'Pesquisar produto',
              ),
            ),
          ),
        ),
        Tooltip(
          message: 'Toque aqui limapr sua pesquisa',
          child: Container(
            margin: EdgeInsets.all(10),
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[700],
                onPrimary: Colors.white,
              ),
              onPressed: () {
                _bloc.clearSeach();
                _searchUserController.clear();
              },
              child: Icon(
                Icons.close,
                size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }
}
