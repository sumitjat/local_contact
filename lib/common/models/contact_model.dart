class ContactModel {
  int id;
  String name;
  String phone;
  String email;
  String image;

  ContactModel({
    this.id = 0,
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      "name": name,
      "phone": phone,
      "email": email,
      "image": image,
    };
  }
}
