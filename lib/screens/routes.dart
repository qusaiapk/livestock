// 1.
import 'package:flutter/material.dart';

import 'package:livestock/screens/login.dart';
import 'package:livestock/screens/registration.dart';
import 'package:livestock/screens/tab_screen.dart';
import 'comment/View/CommentScreen.dart';
import 'comment/View/add_comment.dart';
import 'comment/View/all_askes.dart';
import 'groupChat/screens/chat_screen.dart';
import 'groupChat/screens/login_screen_chat.dart';
import 'groupChat/screens/registration_screen_chat.dart';
import 'milk_product.dart';
import 'home_screen.dart';
import 'animal_screen.dart';

class RouteGenerator {
// 2.
  static const String homeScreen = '/';
  static const String animalScreen = '/animalScreenRoute';
  static const String milkProduct = '/milkProductRoute';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String ask = '/ask';
  static const String chat = '/chat';
  static const String registrationScreenChat = '/registrationScreenChat';
  static const String loginScreenChat = '/loginScreenChat';
  static const String commentScreen = '/commentScreen';
  static const String all_askes = '/all_askes';
  static const String add_comment = '/add_comment';
  static const String your_asks = '/your_asks';
  static const String your_answers = '/your_answers';
  static const String tap_screen = '/tap_screen';

// 3.
  RouteGenerator._() {}
// 3.
  static Route<dynamic> generateRoute(RouteSettings settings) {
//4.
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomeScreen(),
        );
      case animalScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AnimalScreen(),
        );

      case milkProduct:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MilkProduct(),
        );
      case login:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginScreen(),
        );
      case registration:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RegistratonScreen(),
        );

      case chat:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ChatScreen(),
        );
      case registrationScreenChat:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RegistrarionScreenChat(),
        );
      case loginScreenChat:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginScreenChat(),
        );
      case commentScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CommentScreen(),
        );
      case all_askes:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AllAskes(),
        );
      case add_comment:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AddComment(),
        );
      case tap_screen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => TapScreen(),
        );

      default:
        throw FormatException("Route not found");
    }
  }
}

// 5.
class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
