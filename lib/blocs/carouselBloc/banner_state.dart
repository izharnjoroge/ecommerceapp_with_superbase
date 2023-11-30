part of 'banner_cubit.dart';

@immutable
sealed class BannerState {}

final class BannerInitial extends BannerState {}

final class BannerLoading extends BannerState {}

final class BannerLoaded extends BannerState {
  final List<CarouselModel> carouselModel;

  BannerLoaded(this.carouselModel);
}

final class BannerError extends BannerState {
  final String error;

  BannerError(this.error);
}
