import 'package:supper_fresh_stores/Model/Comment.dart';

class Popular{

  var description;
  var discount;
  var image;
  var categoryId;
  var name;
  var price;
  var previous_price;
  var rating;
  var id;

  List<Comment>? comments_list;



  Popular({this.categoryId,this.discount,this.image,this.price,this.name,this.description,this.previous_price,this.comments_list,this.rating,this.id});

}