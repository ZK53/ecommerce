import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/features/silder/data/repo/slider_repo.dart';

import 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  final SliderRepo sliderRepo = SliderRepo();

  SliderCubit() : super(SliderInitial());

  Future<void> getSliders() async {
    emit(SliderLoading());

    try {
      final sliders = await sliderRepo.getSliders();

      emit(SliderSuccess(sliders));
    } catch (e) {
      emit(SliderFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
