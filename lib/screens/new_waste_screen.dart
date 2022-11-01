import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:wasteagram/widgets/food_waste_form.dart';

class NewWasteScreen extends StatefulWidget {
  final XFile? chosenFile;
  const NewWasteScreen({Key? key, required this.chosenFile}) : super(key: key);
  @override
  NewWasteScreenState createState() => NewWasteScreenState();
}

class NewWasteScreenState extends State<NewWasteScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static const String title = 'New Post';
  late LocationData geoLocation;
  String? imageURL;
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    getImage();
    retrieveLocation();
  }

  @override
  Widget build(BuildContext context) {
    if (imageURL == null) {
      return Scaffold(
          appBar: FoodWasteForm(title: title, backArrow: true),
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [CircularProgressIndicator()])));
    } else {
      return Scaffold(
        appBar: FoodWasteForm(title: title, backArrow: true),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              imageSelected(),
              const Spacer(),
              leftoverAmount(),
              const Spacer(flex: 4),
              uploadButton(),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
      );
    }
  }

  Widget imageSelected() {
    return Semantics(
      image: true,
      label: 'Chosen image of food waste',
      child: Container(
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageURL!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget leftoverAmount() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40.0,
      height: 100.0,
      child: Semantics(
        textField: true,
        focusable: true,
        label: 'Number of Wasted items',
        child: TextFormField(
          decoration: const InputDecoration(
              labelText: 'Enter number of leftover items'),
          keyboardType: TextInputType.number,
          autofocus: true,
          style: const TextStyle(fontSize: 34),
          textAlign: TextAlign.center,
          onSaved: (value) {
            if (value != null) {
              quantity = int.parse(value);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the number of leftover items';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget uploadButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      child: Semantics(
        button: true,
        enabled: true,
        label: 'Upload post',
        child: ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              FirebaseFirestore.instance.collection('posts').add({
                'date': DateTime.now(),
                'imageURL': imageURL,
                'quantity': quantity,
                'latitude': geoLocation.latitude,
                'longitude': geoLocation.longitude
              });
              Navigator.of(context).pop();
            }
          },
          child: const Icon(Icons.cloud_upload, size: 50.0),
        ),
      ),
    );
  }

  void getImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(widget.chosenFile!.path));
    imageURL = await (await uploadTask).ref.getDownloadURL();
    setState(() {});
  }

  void retrieveLocation() async {
    Location locationService = Location();
    geoLocation = await locationService.getLocation();
    setState(() {});
  }
}
