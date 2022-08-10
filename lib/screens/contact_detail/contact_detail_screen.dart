import 'package:flutter/material.dart';
import 'package:houzeo_example/common/ui/contact_single_row.dart';
import 'package:houzeo_example/screens/contact_add_edit/contact_add_edit_screen.dart';
import 'package:houzeo_example/common/models/contact_model.dart';
import 'package:houzeo_example/screens/contact_detail/contact_detail_vm.dart';
import 'package:houzeo_example/screens/full_image/full_image_screen.dart';
import 'package:houzeo_example/utils/image_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailScreen extends StatelessWidget {
  static const routeName = 'contact_detail_screen';
  static const paramContactId = 'contactId';
  static const paramRefresh = 'refresh';

  final int id;
  final Function refresh;

  const ContactDetailScreen({
    Key? key,
    required this.id,
    required this.refresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return ContactDetailVM(
          id,
          refresh,
        );
      },
      child: Scaffold(
        appBar: AppBar(elevation: 0),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Consumer<ContactDetailVM>(builder: (context, vm, __) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _contactImage(context, vm),
            const SizedBox(height: 16),
            Text(vm.name, style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 16),
            _optionsRow(context, vm),
            const SizedBox(height: 16),
            ContactSingleInfoRow(
                singleInfo: vm.phone,
                singleIcon: Icons.phone_outlined,
                onTap: () {
                  vm.launchPhone();
                }),
            ContactSingleInfoRow(
              singleInfo: vm.email,
              singleIcon: Icons.email_outlined,
              onTap: () {
                vm.launchEmail();
              },
            ),
            ContactSingleInfoRow(
              singleInfo: vm.name,
              singleIcon: Icons.account_circle_outlined,
              onTap: null,
            )
          ],
        ),
      );
    });
  }

  Widget _contactImage(BuildContext context, ContactDetailVM vm) {
    return InkWell(
      child: CircleAvatar(
        minRadius: 80,
        backgroundImage: vm.image,
      ),
      onTap: () {
        _openImageFullScreen(context, vm);
      },
    );
  }

  Widget _optionsRow(BuildContext context, ContactDetailVM vm) {
    return Row(
      children: [
        _optionItem(
          context,
          "Edit",
          Colors.blueAccent,
          Icons.edit,
          () {
            _openContactEdit(context, vm);
          },
        ),
        _optionItem(
          context,
          "Delete",
          Colors.blue,
          Icons.delete,
          () {
            _deleteContactPopUp(context, vm);
          },
        ),
      ],
    );
  }

  Widget _optionItem(BuildContext context, String heading, Color bgColor,
      IconData icon, Function() onTap) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: bgColor,
        child: InkWell(
          onTap: onTap,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(heading,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Colors.white))
          ]),
        ),
      ),
    );
  }

  Future<void> _openContactEdit(
      BuildContext context, ContactDetailVM vm) async {
    var shouldReload = await Navigator.pushNamed(
      context,
      ContactAddEditScreen.routeName,
      arguments: {
        ContactAddEditScreen.paramContactModel: vm.contactModel,
      },
    );

    if (shouldReload != null) {
      vm.reloadData();
    }
  }

  void _openImageFullScreen(BuildContext context, ContactDetailVM vm) {
    Navigator.pushNamed(
      context,
      FullImageScreen.routeName,
      arguments: {
        FullImageScreen.paramImageUrl: vm.imageUrl,
      },
    );
  }

  Future<void> _deleteContactPopUp(
      BuildContext context, ContactDetailVM vm) async {
    var shouldPop = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Are you sure you want to delete this contact?'),
            elevation: 10,
            children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Yes'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
            ],
            //backgroundColor: Colors.green,
          );
        });

    if (shouldPop != null) {
      await vm.deleteContact();
      refresh();
      Navigator.pop(context);
    }
  }
}
