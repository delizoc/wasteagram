import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:wasteagram/screens/waste_detail_screen.dart';
import 'package:wasteagram/screens/new_waste_screen.dart';
import 'package:wasteagram/widgets/food_waste_form.dart';

class WasteList extends StatefulWidget {
  final String title;
  const WasteList({Key? key, required this.title}) : super(key: key);
  @override
  WasteListState createState() => WasteListState();
}

class WasteListState extends State<WasteList> {
  void selectImage() async {
    final XFile? chosenFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewWasteScreen(chosenFile: chosenFile)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference database =
        FirebaseFirestore.instance.collection('posts');
    return Scaffold(
      appBar: FoodWasteForm(title: widget.title),
      body: Center(
        child:StreamBuilder(
          stream: database.snapshots(),
          builder: 
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasData &&
                snapshot.data!.size>0) {
              final List<DatabaseContents> contents =
                  snapshot.data!.docs.map((model){
                return DatabaseContents(
                  date: model['date'].toDate(),
                  imageURL: model['imageURL'],
                  quantity: model['quantity'],
                  latitude: model['latitude'],
                  longitude: model['longitude']);
              }).toList();
              return ListView(
                children: contents.map((databaseData){
                  return Center(
                    child: Semantics(
                      readOnly: true,
                      label: 'Waste Details',
                      child: ListTile(
                        title: Text(databaseData.screenDate),
                        trailing: Text(databaseData.quantity.toString(), 
                            style: Theme.of(context).textTheme.headline4),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                  title: widget.title,
                                  postData: databaseData)),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              );  
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ]);
          }),
        ),
        floatingActionButton: Semantics(
          button: true,
          enabled: true,
          label: 'Create a new post',
          child: FloatingActionButton(
            onPressed: selectImage,
            tooltip: 'Add a New Post',
            child: const Icon(Icons.camera_alt),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
