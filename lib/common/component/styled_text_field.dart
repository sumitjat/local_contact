import 'package:flutter/material.dart';

class StyledTextFieldAA extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const StyledTextFieldAA({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.title,
    this.hintText,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(title!, style: Theme.of(context).textTheme.bodyText2),
        if (title != null) const SizedBox(height: 5),
        TextField(
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            enabledBorder: _outlineInputBorder(Colors.grey.shade500),
            focusedBorder: _outlineInputBorder(Colors.blue.shade400),
            hoverColor: Colors.black,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyText1,
            fillColor: Colors.black,
          ),
          style: Theme.of(context).textTheme.headline6,
          controller: controller,
          onChanged: onChanged,
        ),
      ],
    );
  }

  OutlineInputBorder _outlineInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      borderSide: BorderSide(
        color: borderColor,
        width: 1.0,
      ),
    );
  }
}
