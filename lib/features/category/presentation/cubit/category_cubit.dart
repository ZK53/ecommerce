import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/features/category/data/repo/category_repo.dart';

import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo categoryRepo = CategoryRepo();

  CategoryCubit() : super(CategoryInitial());

  Future<void> getCategories() async {
    emit(CategoryLoading());

    try {
      final categories = await categoryRepo.getCategories();

      emit(CategorySuccess(categories));
    } catch (e) {
      emit(CategoryFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
