class AppUser {
  String? id;
  String? email;
  String? fName;
  String? lName;
  String? phoneNumber;
  String? imagUrl;
  bool? isMale;

  AppUser(
    this.id,
    this.email,
    this.fName,
    this.lName,
    this.phoneNumber, [
    this.imagUrl,
  ]);

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "fname": fName,
      "lname": lName,
      "phoneNumber": phoneNumber,
      "isMale": isMale,
      "imageUrl": imagUrl,
    };
  }

  AppUser.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    fName = map['fname'];
    lName = map['lname'];
    phoneNumber = map['phoneNumber'];
    imagUrl = map['imageUrl'];
    isMale = map['isMale'];
  }
}
