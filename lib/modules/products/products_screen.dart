import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cuibt/cuibt.dart';
import 'package:shop_app/layout/cuibt/states.dart';
import 'package:shop_app/models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCuibt model = HomeCuibt.get(context);
    return BlocConsumer<HomeCuibt, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: model.homeModel != null,
          builder: (context) => productsBuilder(model.homeModel),
          fallback: (context) =>
              Center(child: const CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel? model) => Column(
        children: [
          CarouselSlider(
            items: model!.data!.banners!
                .map(
                  (e) => Image(
                    image: NetworkImage(
                      e.image,
                    ),
                   fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ).toList(),
            options: CarouselOptions(
                height: 250,
                initialPage: 0,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1
                // reverse: false,
                ),
          ),
        ],
      );
}
