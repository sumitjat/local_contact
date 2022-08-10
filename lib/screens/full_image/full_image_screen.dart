import 'package:flutter/material.dart';
import 'package:houzeo_example/utils/image_utils.dart';

class FullImageScreen extends StatelessWidget {
  static const routeName = 'full_image_screen';
  static const paramImageUrl = 'imageUrl';

  final String imageUrl;

  const FullImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        child: Image.memory(
          ImageUtils.dataFromBase64String(imageUrl),
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
