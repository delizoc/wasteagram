import 'package:flutter/material.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:wasteagram/widgets/food_waste_form.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final DatabaseContents postData;
  const DetailScreen({Key? key, required this.postData, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodWasteForm(title: title, backArrow: true),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
        child: Center(
          child: Column(
            children: [
              postDate(context),
              const Spacer(),
              foodImage(context),
              const Spacer(),
              wasteAmount(context),
              const Spacer(),
              postGeolocation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget postDate(BuildContext context) {
    return Semantics(
      readOnly: true,
      label: 'Date of Post',
      child: Text(postData.formatDate,
          style: Theme.of(context).textTheme.headline4),
    );
  }

  Widget foodImage(BuildContext context) {
    return Semantics(
      child: Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(postData.imageURL),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget wasteAmount(BuildContext context) {
    return Semantics(
      readOnly: true,
      label: 'Amount of leftover items',
      child: Text(
          '${postData.quantity.toString()} ${postData.quantity == 1 ? "item" : "items"}',
          style: Theme.of(context).textTheme.headline4),
    );
  }

  Widget postGeolocation() {
    return Semantics(
      readOnly: true,
      label: 'Geolocation of Post',
      child: Text(
          'Location: (${postData.fixedLatitude}, ${postData.fixedLongitude})'),
    );
  }
}
