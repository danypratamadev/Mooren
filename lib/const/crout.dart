import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class MainRoute {
  
  static Route sharedAxisRoute({
      Widget destination, 
      SharedAxisTransitionType type, 
      int milliseconds,
    }) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: milliseconds),
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: type,
          fillColor: Theme.of(context).backgroundColor,
        );
      },
    );
  }

}