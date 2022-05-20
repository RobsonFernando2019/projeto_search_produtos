import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pesquisa_produtos_loja/services/get_products_impl_service.dart';
import 'package:pesquisa_produtos_loja/services/interfaces/get_products_service.dart';

setupLocator() async {
  locator.registerFactory<GetProductsService>(() => GetProductsImplService());
  locator.registerLazySingleton(() => const FlutterSecureStorage());
}

final GetIt locator = GetIt.instance;
