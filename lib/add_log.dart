import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:astral/log_entry_expanded.dart';
import 'package:astral/log_entry_expanded_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'astral_state.dart';
import 'log_data.dart';
import 'package:uuid/uuid.dart';
import 'log_page.dart';
import 'package:image_picker/image_picker.dart';

const Color topBg = Color.fromRGBO(253, 245, 230, 1.0);

class AddLog extends StatefulWidget {
  const AddLog({super.key});
  
  @override
  State<AddLog> createState() => _AddLogState();
}

class _AddLogState extends State<AddLog> {

  File? _selectedImage;
  bool imageExists = false;
  var userTitle = '';
  var userLog = '';

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AstralState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var uuid = Uuid();
    DateTime date = DateTime.now();

    return Center(
      child: SizedBox(
        // height: height - 20,
        width: width - 20,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            child: Stack(
              children: [
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          // height: (1/6) * height,
                          width: 5 * width / 9,
                          child: TextField(
                            style: const TextStyle(fontSize: 22),
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Title',
                              hintStyle: TextStyle(color: Colors.black.withOpacity(0.75)),
                              border: const OutlineInputBorder(),
                              ),
                            onChanged: (value) {
                              // This function is called whenever the user types in the text field
                              userTitle = value;
                            },
                          )
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(appState.locationController.text,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary
                            ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(DateFormat("EEEE, d MMMM y").format(date),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary
                            ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: (imageExists) ? 
                          SizedBox(
                          // height: (1/6) * height,
                          width: (75/100) * width,
                          child: (kIsWeb) ? Image.network(_selectedImage!.path) : Image.file(_selectedImage!)
                        ) : MaterialButton(
                          color: const Color.fromRGBO(37, 40, 58, 1.0),
                          child: const Text(
                            "Add Image",
                            style: TextStyle(
                              color: topBg,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            _pickImageFromGallery();
                          },
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 16.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          // height: (1/3) * height,
                          width: (85/100) * width,
                          child: TextField(
                            maxLines: 9,
                            onChanged: (uInput) {
                                userLog = uInput;
                            },
                            decoration: InputDecoration(
                              hintText: 'Description',
                              hintStyle: TextStyle(color: Colors.black.withOpacity(0.75)),
                              border: const OutlineInputBorder(),
                            ),
                          )
                        )
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 7.0, top: 5.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                        iconSize: 35,
                        color: Colors.red,
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);},
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 7.0, top: 20.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          iconSize: 35,
                          color: Colors.green,
                          icon: const Icon(IconData(0xf636, fontFamily: 'MaterialIcons')),
                          onPressed: () {
                            LogData x = LogData(id: uuid.v4(), title: userTitle, date: date, log: userLog, image: _selectedImage);
                            appState.logs.insert(0, x);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => LogPage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                        )
                      ),
                    ),
                  ]
                )
              ],
            ),
          ),
        )
      ),
    );
  }
  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(returnedImage!.path);
    }); 
    if (_selectedImage != null) {
      imageExists = true;
    }
  } 
}