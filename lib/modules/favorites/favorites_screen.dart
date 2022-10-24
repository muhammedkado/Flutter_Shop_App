import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cuibt/cuibt.dart';
import 'package:shop_app/layout/cuibt/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCuibt, HomeState>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! FavoritesLoadingState,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => favoritesItem(
                    HomeCuibt.get(context).favorites!.data!.data![index],
                    context),
                separatorBuilder: (context, index) => SizedBox(
                      height: 1,
                      child: Container(
                        height: 0.5,
                        width: double.infinity,
                        color: Colors.black,
                      ),
                    ),
                itemCount:
                    HomeCuibt.get(context).favorites!.data!.data!.length),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state) {});
  }

  Widget favoritesItem(FavoritesData favoritesData, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage('${favoritesData.product!.image}'),
                    //fit: BoxFit.cover,
                    height: 120,
                    width: 120,
                  ),
                  if (favoritesData.product!.discount != 0)
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
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' ${favoritesData.product!.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, height: 1.1),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${favoritesData.product!.price}',
                          style: const TextStyle(
                            color: defaultColor,
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (favoritesData.product!.discount != 0)
                          Text(
                            '${favoritesData.product!.oldPrice.round()}',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              HomeCuibt.get(context)
                                  .changeFavorites(favoritesData.product!.id);
                              //  print(model.id);
                            },
                            icon: CircleAvatar(
                              radius: 13,
                              backgroundColor: HomeCuibt.get(context)
                                      .favorits[favoritesData.product!.id]!
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
        ),
      );
}
