import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cuibt/cuibt.dart';
import 'package:shop_app/layout/cuibt/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategorieScreen extends StatelessWidget {
  const CategorieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCuibt, HomeState>(
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => buildCatItme(
                  HomeCuibt.get(context).categoriesModel!.data!.data[index]),
              separatorBuilder: (context, index) => SizedBox(
                    height: 1,
                    child: Container(
                      height: 0.5,
                      width: double.infinity,
                      color: Colors.black,
                    ),
                  ),
              itemCount:
                  HomeCuibt.get(context).categoriesModel!.data!.data.length);
        },
        listener: (context, state) {});
  }

  Widget buildCatItme(DataModel dataModel) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              width: 100,
              height: 80,
              fit: BoxFit.cover,
              image: NetworkImage(
                '${dataModel.image}',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              '${dataModel.name}',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ],
        ),
      );
}
