class User {
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? avatar;
  String? cinOrPassport;
  String? identityPic;
  String? address;
  String? country;
  String? city;
  String? postalCode;
  String? type;

  User({
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.avatar,
    this.cinOrPassport,
    this.identityPic,
    this.type,
    this.address,
    this.city,
    this.country,
    this.postalCode,
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    avatar = json['avatar'];
    cinOrPassport = json['cinOrPassport'];
    identityPic = json['identityPic'];
    type = json['type'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    postalCode = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['avatar'] = avatar;
    data['cinOrPassport'] = cinOrPassport;
    data['identityPic'] = identityPic;
    data['type'] = type;
    data['address'] = address;
    data['city'] = city;
    data['postalCode'] = postalCode;
    data['country'] = country;
    return data;
  }
}
