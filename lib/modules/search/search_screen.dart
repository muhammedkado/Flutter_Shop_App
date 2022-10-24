import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cuibt/cuibt.dart';
import 'package:shop_app/modules/search/cuibt/state.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchConrrollar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCuibt(),
      child: BlocConsumer<SearchCuibt, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        onSubmit: (String text) {
                          SearchCuibt.get(context).search(text: text);
                        },
                        controller: searchConrrollar,
                        keybord: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'enter text to search';
                          }
                        },
                        prefix: Icons.search,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      if (state is SearchSuccessesState)
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => productItem(
                                  SearchCuibt.get(context)
                                      .searchModel!
                                      .data!
                                      .data![index],
                                  context,isOldPrice: false),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 1,
                                    child: Container(
                                      height: 0.5,
                                      width: double.infinity,
                                      color: Colors.black,
                                    ),
                                  ),
                              itemCount: SearchCuibt.get(context)
                                  .searchModel!
                                  .data!
                                  .data!
                                  .length),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
