import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/features/product/data/repo/product_repo.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepo productRepo = ProductRepo();

  ProductCubit() : super(ProductInitial());

  Future<void> getProducts() async {
    emit(ProductLoading());

    try {
      final products = await productRepo.getProducts();

      emit(ProductSuccess(products));
    } catch (e) {
      emit(ProductFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
