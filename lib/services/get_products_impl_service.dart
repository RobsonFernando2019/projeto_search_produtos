import 'package:dio/dio.dart';
import 'package:pesquisa_produtos_loja/models/response/product_model.dart';

import 'interfaces/get_products_service.dart';

class GetProductsImplService implements GetProductsService {
  Future<List<ProductModel>> getAllProducts() async {
    var dio = Dio();
    var url = 'https://makeup-api.herokuapp.com/api/v1/products.json';
    final response = await dio.get(url);
    print(response.data);
    final result = (response.data as List)
        .map((item) => ProductModel.fromJson(item))
        .toList();
    return result;
  }
}
