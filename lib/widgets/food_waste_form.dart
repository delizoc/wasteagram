import 'package:flutter/material.dart';

class FoodWasteForm extends StatelessWidget with PreferredSizeWidget {
  final bool backArrow;
  final String title;
  @override
  final Size preferredSize;
  FoodWasteForm({Key? key, required this.title, this.backArrow = false})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget? mainWidget;
    if (backArrow) {
      mainWidget = Semantics(
        button: true,
        enabled: true,
        label: 'Back to Waste List Screen',
        child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      );
    }
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: mainWidget,
    );
  }
}
