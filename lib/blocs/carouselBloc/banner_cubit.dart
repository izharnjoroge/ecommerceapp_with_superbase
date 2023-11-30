import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/models/carousel_model.dart';
import 'package:meta/meta.dart';

import '../../repos/advertRepo/advert_repo.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  final CarouselRepository carouselRepository;
  BannerCubit(this.carouselRepository) : super(BannerInitial());

  void getCarousels() async {
    emit(BannerLoading());
    try {
      List<CarouselModel> carouselModel =
          await carouselRepository.getCarousels();
      emit(BannerLoaded(carouselModel));
    } catch (e) {
      emit(BannerError(e.toString()));
    }
  }
}
