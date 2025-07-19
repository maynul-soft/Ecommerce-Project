class CartCheckoutModel{
  final String cartItemId;
  final CheckoutProductModel productModel;
  int quantity;
  final String? color;
  final String? size;

  CartCheckoutModel({required this.cartItemId, required this.productModel, required this.color,required this.size, required this.quantity});

  factory CartCheckoutModel.fromJson(Map<String,dynamic> json){
    return CartCheckoutModel(
        cartItemId: json['_id'] ??'',
        quantity:  json['quantity']?? 1,
        color: json['color'] ,
        size: json['size'],
        productModel: CheckoutProductModel.fromJson(json['product']),
    );
  }
}

class CheckoutProductModel{
  final String productId;
  final String productTitle;
  final List<String> productImage;
  final int productPrice;

  CheckoutProductModel({required this.productId, required this.productTitle, required this.productImage, required this.productPrice});

  factory CheckoutProductModel.fromJson(Map<String,dynamic>json){
    return CheckoutProductModel(
        productId: json['_id']??'',
        productTitle: json['title']??'',
        productImage: List<String>.from(json['photos']),
        productPrice: json['current_price']?? 0
    );
  }
}
