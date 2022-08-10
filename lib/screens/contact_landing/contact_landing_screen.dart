import 'package:flutter/material.dart';
import 'package:houzeo_example/screens/contact_add_edit/contact_add_edit_screen.dart';
import 'package:houzeo_example/screens/contact_landing/contact_landing_vm.dart';
import 'package:provider/provider.dart';

import '../../common/ui/contact_landing_card.dart';

class ContactLandingScreen extends StatelessWidget {
  static const routeName = 'contact_landing_screen';

  const ContactLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return ContactLandingVM();
      },
      child: _screen(context),
    );
  }

  Widget _screen(BuildContext context) {
    return Consumer<ContactLandingVM>(
      builder: (context, vm, __) {
        return Scaffold(
          appBar: null,
          body: _body(context, vm),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              _openContactAddPage(context, vm);
            },
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context, ContactLandingVM vm) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ContactRow(
          contact: vm.contact(index),
          refresh: () {
            vm.reloadData();
          },
        );
      },
      itemCount: vm.listCount,
    );
  }

  Future<void> _openContactAddPage(
      BuildContext context, ContactLandingVM vm) async {
    var shouldReload = await Navigator.pushNamed(
      context,
      ContactAddEditScreen.routeName,
      arguments: {
        ContactAddEditScreen.paramContactModel: null,
      },
    );

    if (shouldReload != null) {
      vm.reloadData();
    }
  }
}
