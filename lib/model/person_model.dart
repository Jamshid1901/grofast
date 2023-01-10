

import 'dart:convert';

List<PersonModel?>? personModelFromJson(String str) => json.decode(str) == null ? [] : List<PersonModel?>.from(json.decode(str)!.map((x) => PersonModel.fromJson(x)));

String personModelToJson(List<PersonModel?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class PersonModel {
  PersonModel({
    this.address,
    this.id,
    this.email,
    this.username,
    this.password,
    this.name,
    this.phone,
    this.v,
  });

  Address? address;
  int? id;
  String? email;
  String? username;
  String? password;
  Name? name;
  String? phone;
  int? v;

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
    address: Address.fromJson(json["address"]),
    id: json["id"],
    email: json["email"],
    username: json["username"],
    password: json["password"],
    name: Name.fromJson(json["name"]),
    phone: json["phone"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "address": address!.toJson(),
    "id": id,
    "email": email,
    "username": username,
    "password": password,
    "name": name!.toJson(),
    "phone": phone,
    "__v": v,
  };
}

class Address {
  Address({
    this.geolocation,
    this.city,
    this.street,
    this.number,
    this.zipcode,
  });

  Geolocation? geolocation;
  String? city;
  String? street;
  int? number;
  String? zipcode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    geolocation: Geolocation.fromJson(json["geolocation"]),
    city: json["city"],
    street: json["street"],
    number: json["number"],
    zipcode: json["zipcode"],
  );

  Map<String, dynamic> toJson() => {
    "geolocation": geolocation!.toJson(),
    "city": city,
    "street": street,
    "number": number,
    "zipcode": zipcode,
  };
}

class Geolocation {
  Geolocation({
    this.lat,
    this.long,
  });

  String? lat;
  String? long;

  factory Geolocation.fromJson(Map<String, dynamic> json) => Geolocation(
    lat: json["lat"],
    long: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "long": long,
  };
}

class Name {
  Name({
    this.firstname,
    this.lastname,
  });

  String? firstname;
  String? lastname;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    firstname: json["firstname"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
  };
}
