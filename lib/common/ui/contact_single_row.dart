import 'package:flutter/material.dart';

class ContactSingleInfoRow extends StatelessWidget {
  final String singleInfo;
  final IconData singleIcon;
  final Function()? onTap;

  const ContactSingleInfoRow({
    Key? key,
    required this.singleInfo,
    required this.singleIcon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 6, left: 24, bottom: 6),
      leading: IconButton(
        icon: Icon(
          singleIcon,
          size: 28,
        ),
        onPressed: onTap,
      ),
      title: Text(singleInfo),
    );
  }
}
