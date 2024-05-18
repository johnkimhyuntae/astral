import 'dart:io';

class LogData {
  final String id;
  final String title;
  final DateTime date;
  final String log;
  final File? image;
  const LogData({required this.id, required this.title, required this.date, required this.log, required this.image});
}