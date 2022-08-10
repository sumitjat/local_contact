import 'package:flutter/material.dart';
import 'package:houzeo_example/screens/contact_detail/contact_detail_screen.dart';
import 'package:houzeo_example/common/models/contact_model.dart';
import 'package:houzeo_example/utils/image_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactRow extends StatelessWidget {
  final ContactModel contact;
  final Function refresh;

  const ContactRow({
    Key? key,
    required this.contact,
    required this.refresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _openContactDetail(context);
      },
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: CircleAvatar(
          maxRadius: 20,
          backgroundImage:
              MemoryImage(ImageUtils.dataFromBase64String(contact.image)),
        ),
      ),
      contentPadding: const EdgeInsets.only(top: 6, left: 16, bottom: 6),
      title: Text(
        contact.name,
      ),
      subtitle: Text(
        contact.email,
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 24),
        child: IconButton(
          icon: const Icon(
            Icons.phone_outlined,
            color: Colors.blueAccent,
            size: 28,
          ),
          onPressed: () {
            launchUrl(Uri.parse('tel://${contact.phone}'));
          },
        ),
      ),
    );
  }

  Future<void> _openContactDetail(BuildContext context) async {
    var shouldReload = await Navigator.pushNamed(
      context,
      ContactDetailScreen.routeName,
      arguments: {
        ContactDetailScreen.paramContactId: contact.id,
        ContactDetailScreen.paramRefresh: refresh,
      },
    );

    if (shouldReload != null) {
      refresh();
    }
  }
}
