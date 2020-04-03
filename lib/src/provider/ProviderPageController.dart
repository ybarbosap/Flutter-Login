import 'package:flutter/material.dart';

class ProviderPageController extends InheritedWidget {
  final PageController controller;

  const ProviderPageController({this.controller, Widget child})
      : assert(controller != null),
        super(child: child);

  static ProviderPageController of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderPageController>();
  }

  void toPage({int page}) {
    controller.animateToPage(page,
        duration: Duration(milliseconds: 200), curve: Curves.easeInExpo);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget != this;
  }
}
