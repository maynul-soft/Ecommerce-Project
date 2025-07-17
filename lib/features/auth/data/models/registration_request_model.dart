

class RegistrationRequestModel{
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String mobile;
  final String city;

  RegistrationRequestModel(
      {required this.email,
        required this.firstName,
        required this.lastName,
        required this.password,
        required this.city,
        required this.mobile
      });


  Map<String,dynamic> toJson(){
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "phone": mobile,
      "city": city
    };
  }
}