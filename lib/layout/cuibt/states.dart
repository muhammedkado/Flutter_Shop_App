abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {}

class HomeErrorState extends HomeState {
  final String Error;

  HomeErrorState(this.Error);
}

class ChangeBottomNavState extends HomeState {}

class CategoriesSuccessState extends HomeState {}

class CategoriesErrorState extends HomeState {
  final String Error;

  CategoriesErrorState(this.Error);

}

class ChangeFavoritesSuccessState extends HomeState {}

class ChangeFavoritesErrorState extends HomeState {
  final String Error;

  ChangeFavoritesErrorState(this.Error);

}

class FavoritesSuccessState extends HomeState {}

class FavoritesErrorState extends HomeState {
  final String Error;

  FavoritesErrorState(this.Error);

}
class FavoritesLoadingState extends HomeState {}