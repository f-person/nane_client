import 'package:flutter/material.dart';

Future<T?> navigateTo<T>(
  BuildContext context,
  Widget screen, {
  bool fullscreenDialog = false,
}) =>
    Navigator.of(context).push<T?>(
      MaterialPageRoute(
        builder: (_) => screen,
        fullscreenDialog: fullscreenDialog,
      ),
    );

Future<T?> deleteAllScreensAndNavigateTo<T>(
  BuildContext context,
  Widget screen, {
  bool fullscreenDialog = false,
}) =>
    Navigator.of(context).pushAndRemoveUntil<T?>(
      MaterialPageRoute(
        builder: (_) => screen,
        fullscreenDialog: fullscreenDialog,
      ),
      (_) => false,
    );
