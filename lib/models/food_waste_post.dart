import 'package:intl/intl.dart';

class DatabaseContents {
  final DateTime date;
  final String imageURL;
  final int quantity;
  final num latitude;
  final num longitude;

  const DatabaseContents(
      {required this.date,
      required this.imageURL,
      required this.quantity,
      required this.latitude,
      required this.longitude});

  String get screenDate => DateFormat('EEEE, MMMM d, yyyy').format(date);
  String get formatDate => DateFormat('E, MMM d, yyyy').format(date);
  String get fixedLatitude => latitude.toStringAsFixed(6);
  String get fixedLongitude => longitude.toStringAsFixed(6);
}
