import 'package:flutter/material.dart';
import 'package:houzeo_example/common/component/styled_text_field.dart';
import 'package:houzeo_example/common/models/contact_model.dart';
import 'package:houzeo_example/screens/contact_add_edit/contact_add_edit_vm.dart';
import 'package:houzeo_example/utils/image_utils.dart';
import 'package:provider/provider.dart';

class ContactAddEditScreen extends StatefulWidget {
  static const routeName = 'contact_add_edit_screen';
  static const paramContactModel = 'contactModel';

  final ContactModel? contactModel;

  const ContactAddEditScreen({Key? key, required this.contactModel})
      : super(key: key);

  @override
  State<ContactAddEditScreen> createState() => _ContactAddEditScreenState();
}

class _ContactAddEditScreenState extends State<ContactAddEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    var contactModel = widget.contactModel;
    _nameController = TextEditingController(text: contactModel?.name ?? '');
    _emailController = TextEditingController(text: contactModel?.email ?? '');
    _phoneController = TextEditingController(text: contactModel?.phone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return ContactAddEditVM(
          widget.contactModel,
        );
      },
      child: _screen(),
    );
  }

  Widget _screen() {
    return Consumer<ContactAddEditVM>(
      builder: (context, vm, __) {
        return Scaffold(
          appBar: AppBar(),
          body: _body(context, vm),
        );
      },
    );
  }

  Widget _body(BuildContext context, ContactAddEditVM vm) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _imageField(vm),
            const SizedBox(height: 15),
            StyledTextFieldAA(
              title: "Full Name",
              hintText: "Enter Your Name",
              controller: _nameController,
              onChanged: (text) {
                vm.updateName(text);
              },
            ),
            const SizedBox(height: 16),
            StyledTextFieldAA(
              title: "Email",
              hintText: "Enter Your Email",
              controller: _emailController,
              onChanged: (text) {
                vm.updateEmail(text);
              },
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            StyledTextFieldAA(
              title: "Phone",
              hintText: "Enter Your Phone",
              controller: _phoneController,
              onChanged: (text) {
                vm.updatePhone(text);
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  if (await vm.saveData(context)) {
                    Navigator.pop(context, true);
                  }
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Text("Done"),
                ))
          ],
        ),
      ),
    );
  }

  Widget _imageField(ContactAddEditVM vm) {
    return InkWell(
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.0),
          color: Colors.red,
        ),
        child: vm.showImage
            ? CircleAvatar(
                minRadius: 80,
                backgroundImage:
                    ImageUtils.imageFromBase64String(vm.imageString))
            : const Icon(
                Icons.add_a_photo,
                size: 40,
                color: Colors.white,
              ),
      ),
      onTap: () {
        vm.addImage();
      },
    );
  }
}
