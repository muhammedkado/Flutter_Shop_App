import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cuibt/cuibt.dart';
import 'package:shop_app/layout/cuibt/states.dart';
import 'package:shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCuibt, HomeState>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! FavoritesLoadingState,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => productItem(
                    HomeCuibt.get(context)
                        .favorites!
                        .data!
                        .data![index]
                        .product!,
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
}
