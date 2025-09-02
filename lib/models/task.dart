import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String notes;
  final int priority;
  final Color color;
  final bool recurringWeekly;

  Task({
    required this.id,
    required this.title,
    required this.notes,
    required this.priority,
    required this.color,
    required this.recurringWeekly,
  });
}
