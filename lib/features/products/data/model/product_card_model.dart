class ProductCardModel{
  final String name;
  final String id;
  final List<String> imageUrl;
  final int price;

  ProductCardModel({required this.id, required this.name, required this.imageUrl, required this.price});

  factory ProductCardModel.fromJson(Map<String,dynamic> json ){
    return ProductCardModel(
        id: json['_id']??'',
        name: json['title']??'',
        imageUrl: List<String>.from(json['photos']),
        price: json['current_price']??''
    );
  }
}