import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../util/app_string.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({Key? key}) : super(key: key);

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final List schedule = ['Morning', 'Afternoon', 'Night'];
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController details = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;

  String? selectedText;
  String? selectedTime;

  // File? _image;
  //
  // final _picker = ImagePicker();
  //
  // pickImage() async {
  //   final XFile? pickedImage =
  //       await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     setState(() {
  //       _image = File(pickedImage.path);
  //     });
  //   }
  // }
  //
  // uploadImage() async {
  //   String fileName = (title.text.trim()).replaceAll(' ', '');
  //   print(fileName);
  //
  //   try {
  //     await storage
  //         .ref(fileName)
  //         .putFile(
  //             _image!,
  //             SettableMetadata(customMetadata: {
  //               'uploaded_by': 'Admin',
  //               'description': 'desc'
  //             }))
  //         .then((p0) => print('done'));
  //   } on FirebaseException catch (error) {
  //     if (kDebugMode) {
  //       print(error);
  //     }
  //   }
  // }

  addToCollection(String collection, String title, String desc, String time,
      String details) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection(collection);
    await reference.doc(title.replaceAll(' ', '')).set({
      'title': title,
      'desc': desc,
      'period': collection,
      'image_path': (title).replaceAll(' ', ''),
      'details': details,
      'time': time
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Movie added Successfully'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ));
    }).then((value) {
      //uploadImage();
    });
  }

  addToMovies(String collection, String title, String desc, String time,
      String details) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('movies');
    await reference.doc(title.replaceAll(' ', '')).set({
      'title': title,
      'desc': desc,
      'period': collection,
      'time': time,
      'details': details,
      'popular': false
    }).then((value) {
      addToCollection(collection, title, desc, time, details);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {},
          )));
    });
    //await
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Add Movie',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // InkWell(
                    //   onTap: () {
                    //     pickImage();
                    //   },
                    //   child: Container(
                    //     height: 100,
                    //     width: 100,
                    //     decoration: BoxDecoration(
                    //         color: const Color.fromRGBO(197, 198, 200, 1.0),
                    //         borderRadius: BorderRadius.circular(8)),
                    //     child: _image == null
                    //         ? const Center(
                    //             child: Icon(
                    //               Icons.add,
                    //               size: 48,
                    //             ),
                    //           )
                    //         : Image.file(_image!, fit: BoxFit.fill),
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Movie Title',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(197, 198, 200, 1.0),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        controller: title,
                        style: const TextStyle(
                            color: Color.fromRGBO(75, 78, 85, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        decoration: const InputDecoration(
                          isDense: true,
                          filled: true,
                          contentPadding: EdgeInsets.all(15),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Movie Details',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(197, 198, 200, 1.0),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: 4,
                        controller: details,
                        style: const TextStyle(
                            color: Color.fromRGBO(75, 78, 85, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        decoration: const InputDecoration(
                          isDense: true,
                          filled: true,
                          contentPadding: EdgeInsets.all(15),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(197, 198, 200, 1.0),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: 5,
                        controller: desc,
                        style: const TextStyle(
                            color: Color.fromRGBO(75, 78, 85, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        decoration: const InputDecoration(
                          isDense: true,
                          filled: true,
                          contentPadding: EdgeInsets.all(15),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Select Schedule',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                        child: ListView.builder(
                            itemCount: schedule.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedText = schedule[index];
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: selectedText == schedule[index]
                                        ? const Color.fromRGBO(75, 78, 85, 1)
                                        : Colors.white,
                                    border: selectedText == schedule[index]
                                        ? null
                                        : Border.all(
                                            color: const Color.fromRGBO(
                                                75, 78, 85, 1)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      schedule[index],
                                      style: TextStyle(
                                          color: selectedText == schedule[index]
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    selectedText != null
                        ? Column(
                            children: [
                              const Text(
                                'Select Time',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: Center(
                                  child: ListView.builder(
                                      itemCount: selectedText == 'Morning'
                                          ? morningTime.length
                                          : selectedText == 'Afternoon'
                                              ? afternoonTime.length
                                              : nightTime.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return selectedText == 'Morning'
                                            ? InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedTime =
                                                        morningTime[index];
                                                  });
                                                },
                                                child: TimeSelection(
                                                    time: morningTime,
                                                    timeSelected: selectedTime,
                                                    index: index),
                                              )
                                            : selectedText == 'Afternoon'
                                                ? InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedTime =
                                                            afternoonTime[
                                                                index];
                                                      });
                                                    },
                                                    child: TimeSelection(
                                                        time: afternoonTime,
                                                        timeSelected:
                                                            selectedTime,
                                                        index: index),
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedTime =
                                                            nightTime[index];
                                                      });
                                                    },
                                                    child: TimeSelection(
                                                        time: nightTime,
                                                        timeSelected:
                                                            selectedTime,
                                                        index: index),
                                                  );
                                      }),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            ),
            Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(75, 78, 85, 1),
                ),
                child: TextButton(
                    onPressed: () {
                      if (selectedText != null || title.text.isNotEmpty) {
                        //uploadImage();
                        addToMovies(selectedText!, title.text, desc.text,
                            selectedTime!, details.text.trim());
                        title.clear();
                        desc.clear();
                      }

                      /*Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const AdminDashboardView();
                          }));*/
                    },
                    child: const Text(
                      'Add Movie',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ))),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}

class TimeSelection extends StatelessWidget {
  final List time;
  final String? timeSelected;
  final int index;

  const TimeSelection(
      {Key? key,
      required this.time,
      required this.timeSelected,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 30,
      width: 80,
      decoration: BoxDecoration(
        color: timeSelected == time[index]
            ? const Color.fromRGBO(75, 78, 85, 1)
            : Colors.white,
        border: timeSelected == time[index]
            ? null
            : Border.all(color: const Color.fromRGBO(75, 78, 85, 1)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          time[index],
          style: TextStyle(
              color: timeSelected == time[index] ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
