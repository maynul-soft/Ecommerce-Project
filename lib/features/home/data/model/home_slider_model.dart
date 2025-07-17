class HomeSliderModel {
  final String id;
  final String photoUrl;
  final String description;
  final String product;
  final String brand;
  final String Category;
  final String createdAt;
  final String updateAt;
  final int v;

  HomeSliderModel({
    required this.id,
    required this.photoUrl,
    required this.description,
    required this.product,
    required this.brand,
    required this.Category,
    required this.createdAt,
    required this.updateAt,
    required this.v,
  });

  factory HomeSliderModel.fromJson(Map<String,dynamic>json){
    return HomeSliderModel(
        id: json['_id'] ?? '',
        photoUrl: json['photo_url'] ?? '',
        description: json['description']?? '',
        product: json['product']?? '',
        brand: json['brand']?? '',
        Category: json['category']?? '',
        createdAt: json['createdAt']?? '',
        updateAt: json['updatedAt']?? '',
        v: json['__v']?? 0,
    );
  }
}

