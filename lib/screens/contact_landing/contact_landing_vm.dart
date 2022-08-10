import 'package:flutter/material.dart';
import 'package:houzeo_example/common/models/contact_model.dart';
import 'package:houzeo_example/service/db_service.dart';
import 'package:houzeo_example/utils/image_utils.dart';

class ContactLandingVM extends ChangeNotifier {
  var db = DBService();

  ContactLandingVM() {
    _fetchContacts();
  }

  List<ContactModel> _contactList = [];

  _fetchContacts() async {
    _contactList = await db.fetchMemos();
    notifyListeners();
  }

  int get listCount => _contactList.length;

  MemoryImage getImage(index) {
    return ImageUtils.imageFromBase64String(_contactList[index].image);
  }

  String name(int index) {
    return _contactList[index].name;
  }

  ContactModel contact(int index) {
    return _contactList[index];
  }

  void reloadData() {
    _fetchContacts();
  }
}
