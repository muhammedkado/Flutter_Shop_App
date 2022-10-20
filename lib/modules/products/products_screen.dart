import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cuibt/cuibt.dart';
import 'package:shop_app/layout/cuibt/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCuibt model = HomeCuibt.get(context);
    HomeCuibt favorites = HomeCuibt.get(context);

    return BlocConsumer<HomeCuibt, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: model.homeModel != null &&
              HomeCuibt.get(context).categoriesModel != null,
          builder: (context) => productsBuilder(context, favorites,
              model.homeModel, HomeCuibt.get(context).categoriesModel),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(
    BuildContext context,
    favorites,
    HomeModel? model,
    CategoriesModel? categoriesModel,
  ) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data!.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(
                        e.image,
                      ),
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  height: 230,
                  initialPage: 0,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1
                  // reverse: false,
                  ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 120,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            CategoriesBuidl(categoriesModel.data!.data[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 7,
                            ),
                        itemCount: categoriesModel!.data!.data.length),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.57,
                children: List.generate(
                  model.data!.products.length,
                  (index) => buildGridProduct(
                      model.data!.products[index], context, favorites),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(
          ProductsMode model, BuildContext context, HomeCuibt favorites) =>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(
                    model.image,
                  ),
                  //  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                if (model.discount != 0)
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      color: Colors.red,
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, height: 1.1),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${model.price}',
                        style: const TextStyle(
                          color: defaultColor,
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            HomeCuibt.get(context).changeFavorites(model.id);
                            print(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 13,
                            backgroundColor:
                                HomeCuibt.get(context).favorits[model.id]!
                                    ? defaultColor
                                    : Colors.grey,
                            child: const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 14,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget CategoriesBuidl(DataModel? model) => Container(
        width: 120,
        height: 120,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image(
              image: NetworkImage(
                '${model!.image}',
              ),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: double.infinity,
              color: Colors.black.withOpacity(0.7),
              child: Text(
                '${model.name}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
}
