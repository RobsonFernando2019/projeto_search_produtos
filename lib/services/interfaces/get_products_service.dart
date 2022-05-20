import 'package:pesquisa_produtos_loja/models/response/product_model.dart';

abstract class GetProductsService {
  Future<List<ProductModel>> getAllProducts();
}
