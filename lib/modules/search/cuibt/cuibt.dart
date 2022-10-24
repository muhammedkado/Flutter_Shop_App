import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/seach_model.dart';
import 'package:shop_app/modules/search/cuibt/state.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCuibt extends Cubit<SearchStates> {
  SearchCuibt() : super(SearchInitialState());

  static SearchCuibt get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void search({required String text}) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: Token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessesState());
    }).catchError((Error) {
      print(Error.toString());
      emit(SearchErrorState());
    });
  }
}
