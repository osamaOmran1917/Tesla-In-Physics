import 'package:flutter/material.dart';

DateTime dateOnly(DateTime inputDateTime) {
  return DateTime(inputDateTime.year, inputDateTime.month, inputDateTime.day);
}

String getFormattedTime({required BuildContext context, required String time}) {
  final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
  return TimeOfDay.fromDateTime(date).format(context);
}