import 'package:flutter/material.dart';
import 'package:beautyshare_a/User.dart';
class UserProvider extends InheritedWidget {
  final User bloc;
  final Widget child;

  UserProvider({this.bloc, this.child}) : super(child: child);

  static UserProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(UserProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
