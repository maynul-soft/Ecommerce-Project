class ProductModel {
  final String id;
  final String title;
  final String description;
  final List<String> colors;
  final List<String> sizes;
  final List<String> photos;
  final int originalPrice;
  final int price;

  ProductModel({required this.id, required this.title , required this.colors, required this.sizes, required this.photos,required this.originalPrice, required this.price, required this.description });

  factory ProductModel.fromJson(Map<String,dynamic>json){
    return ProductModel(
        id: json['_id']??'',
        description: json['description'],
        title: json['title']??'',
        colors: List<String>.from(json['colors']) ,
        sizes:  List<String>.from (json['sizes']?? []),
        photos: List<String>.from(json['photos']?? []),
        originalPrice: json['regular_price']??0,
        price: json['current_price']??''
    );
  }
}
