class LoginModel {
  final int code;
  final String status;
  final String message;
  DataModel userData;

  LoginModel({
    required this.code,
    required this.status,
    required this.message,
    required this.userData,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      code: json['code'] ?? 0,
      status: json['status'] ?? '',
      message: json['msg'] ?? '',
      userData: DataModel.fromJosn(json['data'])
    );
  }
}

class DataModel {
  final String token;
  UserModel user;

  DataModel({required this.token, required this.user});

  factory DataModel.fromJosn(Map<String, dynamic> json) {
    return DataModel(
        token: json['token'],
        user: UserModel.fromJson(json['user'])
    );
  }
}

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final bool emailVerified;
  final bool phoneVerified;
  final String avaterUrl;
  final String city;
  final int role;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.emailVerified,
    required this.phoneVerified,
    required this.avaterUrl,
    required this.city,
    required this.role,
  });

  factory UserModel.fromJson (Map<String,dynamic>json){
    return UserModel(
        id: json['_id']??'',
        firstName: json['first_name']??'',
        lastName: json['last_name']??'',
        email: json['email']??'',
        phone: json['phone']??'',
        emailVerified: json['email_verified'] ?? false,
        phoneVerified: json['phone_verified'] ?? false,
        avaterUrl: json['avatar_url'] ??'' ,
        city: json['city']?? '',
        role: json['role']?? 0
    );
  }

  Map<String,dynamic> toJson () {
    return {
      "_id": id,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "email_verified": emailVerified,
      "phone": phone,
      "phone_verified": phoneVerified,
      "avatar_url": avaterUrl,
      "city": city,
      "role": role
    };
  }

}



