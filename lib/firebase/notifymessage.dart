import 'package:flutter/material.dart';

@immutable
class NotifyMessage {
  final String title;
  final String body;

  const NotifyMessage({
    @required this.title,
    @required this.body,
  });
}
