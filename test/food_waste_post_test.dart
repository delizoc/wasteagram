import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  test('Project test suit for model database', () {
    final date = DateTime.now();
    const url = '/downlaods/image';
    const quantity = 4;
    const latitude = 18.7;
    const longitude = -21.8;

    final post = DatabaseContents(
        date: date,
        imageURL: url,
        quantity: quantity,
        latitude: latitude,
        longitude: longitude);
    expect(post.date, date);
    expect(post.imageURL, url);
    expect(post.quantity, quantity);
    expect(post.latitude, latitude);
    expect(post.longitude, longitude);
  });

  test('Project test suit to test date format', () {
    final DateTime date = DateTime.parse('2022-03-02');

    final post = DatabaseContents(
        date: date,
        imageURL: '/downloads/image',
        quantity: 1,
        latitude: 0,
        longitude: 0);
    expect(post.formatDate, 'Wed, Mar 2, 2022');
  });
}
