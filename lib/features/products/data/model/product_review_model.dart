class ProductReviewModel{
  final String reviewId;
  final String productId;
  final String userName;
  final String comment;
  final String? avaterUrl;

  ProductReviewModel({required this.reviewId, required this.productId, required this.userName, required this.comment, required this.avaterUrl});

  factory ProductReviewModel.fromJson(Map<String, dynamic >json){
    return ProductReviewModel(
        reviewId: json['_id'],
        productId: json['product']['_id'],
        userName: '${json['user']['first_name']} ${json['user']['last_name']}',
        comment: json['comment'],
        avaterUrl: json['user']['avatar_url']
    );
  }


}