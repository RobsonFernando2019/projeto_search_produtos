import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pesquisa_produtos_loja/models/response/product_model.dart';
import 'package:pesquisa_produtos_loja/utils/locator.dart';

mixin ProductStorageMixin {
  Future<List<ProductModel>?> readFavoritesProductsList() async {
    final storage = locator<FlutterSecureStorage>();
    final favorites = await storage.read(key: 'favoriteProducts');

    if (favorites != null) {
      final productsStorage = (json.decode(favorites) as List)
          .map((i) => ProductModel.fromJson(i))
          .toList();
      return productsStorage;
    }

    return null;
  }

  Future<void> saveToStorage(ProductModel user) async {
    final storage = locator<FlutterSecureStorage>();
    final favoriteProduct = await readFavoritesProductsList();
    var productToStore = <ProductModel>[];
    if (favoriteProduct != null && favoriteProduct.isNotEmpty)
      productToStore = favoriteProduct;

    productToStore.add(user);

    await storage.write(
      key: 'favoriteProducts',
      value: json.encode(productToStore),
    );
  }

  Future<void> removeToStorage(int id) async {
    final storage = locator<FlutterSecureStorage>();
    final productsSaved = await readFavoritesProductsList();
    final removeProduct = productsSaved!.firstWhere(
      (item) => item.id == id,
      orElse: () => ProductModel(),
    );

    if (removeProduct.id != null) {
      productsSaved.remove(removeProduct);
    }

    await storage.write(
      key: 'favoriteProducts',
      value: json.encode(productsSaved),
    );
  }
}
