import 'package:flutter/material.dart';
import 'package:houzeo_example/common/models/contact_model.dart';
import 'package:houzeo_example/service/db_service.dart';
import 'package:houzeo_example/utils/image_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailVM extends ChangeNotifier {
  final int _id;
  final Function _refresh;

  ContactDetailVM(
    this._id,
    this._refresh,
  ) {
    _fetchContactDetail();
  }

  var db = DBService();

  ContactModel _contactModel = ContactModel();

  String get name => _contactModel.name;

  String get email => _contactModel.email;

  String get phone => _contactModel.phone;

  MemoryImage get image =>
      ImageUtils.imageFromBase64String(_contactModel.image);

  String get imageUrl => _contactModel.image;

  ContactModel get contactModel => _contactModel;

  _fetchContactDetail() async {
    _contactModel = await db.getParticularContact(_id);
    notifyListeners();
  }

  Future<void> deleteContact() async {
    await db.deleteContact(_id);
  }

  void launchPhone() {
    launchUrl(Uri.parse('tel://${_contactModel.phone}'));
  }

  void launchEmail() {
    launchUrl(Uri.parse('mailto:${_contactModel.phone}'));
  }

  void reloadData() {
    _fetchContactDetail();
    _refresh();
  }
}
