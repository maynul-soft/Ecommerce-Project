class CategoryModel {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String icon;
  final String parent;
  final String CreatedAt;
  final String updatedAt;
  final int v;

  CategoryModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.icon,
    required this.parent,
    required this.CreatedAt,
    required this.updatedAt,
    required this.v
  });

  factory CategoryModel.fromJosn(Map<String,dynamic> json){
    return CategoryModel(
        id: json['_id']??'',
        title: json['title']??'',
        slug: json['slug']??'',
        description: json['description']??'',
        icon: json['icon']??'',
        parent: json['parent']??'',
        CreatedAt: json['createdAt']??'',
        updatedAt: json['updatedAt']??'',
        v: json['__v']??0
    );
  }

}

//
// {
// "_id": "6812518cea40bfc6edc67356",
// "title": "Apply",
// "slug": "apply",
// "description": "Apply Device",
// "icon": "https://cdn-icons-png.flaticon.com/256/0/747.png",
// "parent": null,
// "createdAt": "2025-04-30T16:36:28.476Z",
// "updatedAt": "2025-04-30T16:36:28.476Z",
// "__v": 0
// },
