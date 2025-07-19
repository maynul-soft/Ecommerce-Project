class WishListProductCardModel{
  final String name;
  final String itemId;
  final String productId;
  final List<String> imageUrl;
  final int price;

  WishListProductCardModel({required this.itemId, required this.name, required this.imageUrl, required this.price, required this.productId});

  factory WishListProductCardModel.fromJson(Map<String,dynamic> json ){
    return WishListProductCardModel(
        itemId: json['_id']??'',
        productId: json['product']['_id']??'',
        name: json['product']['title']??'',
        imageUrl: List<String>.from(json['product']['photos']),
        price: json['product']['current_price']??''
    );
  }
}