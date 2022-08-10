import 'package:flutter/material.dart';
import 'package:houzeo_example/screens/contact_add_edit/contact_add_edit_screen.dart';
import 'package:houzeo_example/screens/contact_detail/contact_detail_screen.dart';
import 'package:houzeo_example/screens/contact_landing/contact_landing_screen.dart';
import 'package:houzeo_example/common/models/contact_model.dart';
import 'package:houzeo_example/screens/full_image/full_image_screen.dart';

String getInitialRoute() {
  return ContactLandingScreen.routeName;
}

Route<dynamic> routeGenerator(RouteSettings settings) {
  dynamic route;
  switch (settings.name) {
    case ContactLandingScreen.routeName:
      route = const ContactLandingScreen();
      break;
    case ContactAddEditScreen.routeName:
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      ContactModel? model = args[ContactAddEditScreen.paramContactModel];
      route = ContactAddEditScreen(
        contactModel: model,
      );
      break;
    case ContactDetailScreen.routeName:
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      int id = args[ContactDetailScreen.paramContactId];
      Function refresh = args[ContactDetailScreen.paramRefresh];
      route = ContactDetailScreen(
        id: id,
        refresh: refresh,
      );
      break;
    case FullImageScreen.routeName:
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      String imageUrl = args[FullImageScreen.paramImageUrl];
      route = FullImageScreen(
        imageUrl: imageUrl,
      );
      break;
    default:
      throw Exception('Invalid route ${settings.name}');
  }

  return MaterialPageRoute(
    builder: (context) => route,
    settings: settings,
  );
}
