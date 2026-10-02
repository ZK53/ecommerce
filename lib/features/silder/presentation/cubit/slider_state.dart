import 'package:stylish/features/silder/data/models/slider_model.dart';

abstract class SliderState {}

class SliderInitial extends SliderState {}

class SliderLoading extends SliderState {}

class SliderSuccess extends SliderState {
  final List<SliderModel> sliders;

  SliderSuccess(this.sliders);
}

class SliderFailure extends SliderState {
  final String message;

  SliderFailure(this.message);
}
