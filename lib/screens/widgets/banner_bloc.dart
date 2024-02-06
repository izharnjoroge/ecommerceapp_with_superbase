import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerceapp/blocs/carouselBloc/banner_cubit.dart';
import 'package:ecommerceapp/repos/advertRepo/advert_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselBLoc extends StatefulWidget {
  const CarouselBLoc({super.key});

  @override
  State<CarouselBLoc> createState() => _CarouselBlocState();
}

class _CarouselBlocState extends State<CarouselBLoc> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannerCubit(CarouselRepository()),
      child: const BannerContent(),
    );
  }
}

class BannerContent extends StatefulWidget {
  const BannerContent({super.key});

  @override
  State<BannerContent> createState() => _BannerContentState();
}

class _BannerContentState extends State<BannerContent> {
  @override
  void initState() {
    super.initState();
    context.read<BannerCubit>().getCarousels();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<BannerCubit, BannerState>(
      builder: (context, state) {
        if (state is BannerLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.purple),
          );
        } else if (state is BannerLoaded) {
          return CarouselSlider.builder(
              itemCount: state.carouselModel.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                          margin: const EdgeInsets.all(10),
                          width: size.width * .85,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: CachedNetworkImage(
                            imageUrl: state.carouselModel[itemIndex].url,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: Colors.purple,
                            )),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: Colors.purple,
                            ),
                          )),
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ));
        } else if (state is BannerError) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const Center(
            child: Text('error'),
          );
        }
      },
    );
  }
}




// ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: state.carouselModel.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: const EdgeInsets.all(10),
//                   width: size.width * .85,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     shape: BoxShape.rectangle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 5,
//                         blurRadius: 7,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: CachedNetworkImage(
//                     imageUrl: state.carouselModel[index].url,
//                     fit: BoxFit.fitWidth,
//                     progressIndicatorBuilder:
//                         (context, url, downloadProgress) => Center(
//                             child: CircularProgressIndicator(
//                       value: downloadProgress.progress,
//                       color: Colors.purple,
//                     )),
//                     errorWidget: (context, url, error) => const Icon(
//                       Icons.error,
//                       color: Colors.purple,
//                     ),
//                   ),
//                 );
//               });