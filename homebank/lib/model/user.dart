class User {
  String accessToken;
  int id;
  String name;
  String phone;
  String email;

  User({this.accessToken, this.id, this.name, this.phone, this.email});

  String getAccessToken() {
    return accessToken;
  }

  int geteId() {
    return id;
  }

  String getName() {
    return name;
  }

  String getPhone() {
    return phone;
  }

  String getEmail() {
    return email;
  }
}
