class User {
  final String name;
  final String userName;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  User(
      {this.name,
      this.userName,
      this.email,
      this.address,
      this.phone,
      this.website,
      this.company});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        name: parsedJson['name'],
        userName: parsedJson['username'],
        email: parsedJson['email'],
        address: Address.fromJson(parsedJson['address']),
        phone: parsedJson['phone'],
        website: parsedJson['website'],
        company: Company.fromJSon(parsedJson['company']));
  }
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipCode;
  final Geo geo;

  Address({this.street, this.suite, this.city, this.zipCode, this.geo});

  factory Address.fromJson(Map<String, dynamic> parsedJson) {
    return Address(
      street: parsedJson['street'],
      suite: parsedJson['suite'],
      city: parsedJson['city'],
      zipCode: parsedJson['zipcode'],
      geo: Geo.fromJson(parsedJson['geo']),
    );
  }
}

class Geo {
  final String lat;
  final String lng;

  Geo({this.lat, this.lng});

  factory Geo.fromJson(Map<String, dynamic> parsedJson) {
    return Geo(
      lat: parsedJson['lat'],
      lng: parsedJson['lng'],
    );
  }
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({this.name, this.catchPhrase, this.bs});

  factory Company.fromJSon(Map<String, dynamic> parsedJson) {
    return Company(
      name: parsedJson['name'],
      catchPhrase: parsedJson['catchPhrase'],
      bs: parsedJson['bs'],
    );
  }
}
