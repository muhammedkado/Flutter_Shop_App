class ChangeFavoritesModel{
   bool? status;
   bool? message;
   ChangeFavoritesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }

}