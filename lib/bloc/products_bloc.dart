import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pesquisa_produtos_loja/models/response/product_model.dart';
import 'package:pesquisa_produtos_loja/services/interfaces/get_products_service.dart';
import 'package:pesquisa_produtos_loja/utils/disposeable.dart';
import 'package:pesquisa_produtos_loja/utils/locator.dart';
import 'package:pesquisa_produtos_loja/utils/product_storage.mixin.dart';
import 'package:rxdart/rxdart.dart';

class ProductsBloC with ProductStorageMixin implements Disposeable {
  ProductsBloC() {
    getAllProducts();
  }

  final _getProductsService = locator<GetProductsService>();
  final _searchProductController = BehaviorSubject<String>.seeded('');
  final _allProductsController = BehaviorSubject<List<ProductModel>>();
  final _listLocalProductsController = BehaviorSubject<List<ProductModel>>();

  Stream<List<ProductModel>> get allUsers$ => _allProductsController.stream;
  Stream<List<ProductModel>> get listLocalProducts$ =>
      _listLocalProductsController.stream;

  get onChangeSearchProduct => _searchProductController.add;

  Stream<List<ProductModel>> get filterProducts$ => Rx.combineLatest2(
        _allProductsController.stream,
        _searchProductController.stream,
        (
          List<ProductModel> data,
          String search,
        ) {
          if (search.isNotEmpty) {
            var result = data
                .where((item) =>
                    item.name!.toLowerCase().startsWith(search.toLowerCase()))
                .toList();
            return result;
          }

          return data;
        },
      );

  Future getAllProducts() async {
    try {
      final response = await _getProductsService.getAllProducts();
      _allProductsController.add(response);
    } catch (e) {
      _allProductsController.addError(e);
    }
  }

  Future<bool> saveFavoriteUser(ProductModel user) async {
    final favorites = await readFavoritesProductsList();

    if (favorites != null && favorites.isNotEmpty) {
      final containsUser = favorites.firstWhere(
        (item) => item.id == user.id,
        orElse: () => ProductModel(),
      );
      if (containsUser.id == null) {
        await saveToStorage(user);
        return true;
      } else
        return false;
    } else
      saveToStorage(user);
    return true;
  }

  Future<void> loadLocalFavoritedProducts() async {
    final storage = locator<FlutterSecureStorage>();
    try {
      final favorites = await readFavoritesProductsList();
      if (favorites != null && favorites.isNotEmpty) {
        _listLocalProductsController.add(favorites);
      } else
        _listLocalProductsController.add(List.empty());
    } catch (e) {
      await storage.delete(key: 'favoriteProducts');
    }
  }

  Future<void> removeLocalProduct(int id) async {
    if (id != null) {
      await removeToStorage(id);
      loadLocalFavoritedProducts();
    }
  }

  clearSeach() {
    _searchProductController.add('');
  }

  @override
  void dispose() {
    _allProductsController.close();
    _searchProductController.close();
    _listLocalProductsController.close();
  }
}
