import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:houzeo_example/service/db_service.dart';
import 'package:houzeo_example/common/models/contact_model.dart';
import 'package:houzeo_example/utils/image_utils.dart';
import 'package:image_picker/image_picker.dart';

class ContactAddEditVM extends ChangeNotifier {
  ContactModel? _contactModel;

  ContactAddEditVM(this._contactModel) {
    if (_contactModel == null) {
      _contactModel = ContactModel();
    } else {
      _isForEdit = true;
    }
  }

  bool _isForEdit = false;
  var db = DBService();

  get showImage => _contactModel?.image.isNotEmpty;

  String get imageString => _contactModel?.image ?? '';

  Future<void> addImage() async {
    var picker = ImagePicker();
    var pickedFile =
        await picker.pickImage(maxWidth: 300, source: ImageSource.gallery);

    var ui8ListData = await pickedFile?.readAsBytes();
    if (ui8ListData != null) {
      _contactModel?.image = ImageUtils.base64String(ui8ListData);
    }

    notifyListeners();
  }

  void updateName(String text) {
    _contactModel?.name = text;
  }

  void updateEmail(String text) {
    _contactModel?.email = text;
  }

  void updatePhone(String text) {
    _contactModel?.phone = text;
  }

  Future<bool> saveData(BuildContext context) async {
    log("saving");
    if (isValid().isNotEmpty) {
      showSnackBar(context, isValid());
      return false;
    }

    if (_isForEdit) {
      await db.updateMemo(_contactModel!.id, _contactModel!);
    } else {
      await db.addItem(_contactModel!);
    }

    return true;
  }

  String isValid() {
    var email = _contactModel!.email;

    if (_contactModel!.image.isEmpty) return "Please Select Image";
    if (_contactModel!.name.isEmpty) {
      return "Please Enter Name";
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return "Please Enter Correct Email";
    }
    if (_contactModel!.phone.length != 10) {
      return "Please Enter 10 Digit Mobile No";
    }

    return "";
  }

  void showSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(content: Text(message), backgroundColor: Colors.red.shade400);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
