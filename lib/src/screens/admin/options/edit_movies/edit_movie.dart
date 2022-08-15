import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../util/app_string.dart';
import '../add_movie.dart';

class EditMovie extends StatefulWidget {
  final String title, desc, selectedText, details, time;

  const EditMovie(
      {Key? key,
      required this.title,
      required this.desc,
      required this.details,
      required this.time,
      required this.selectedText})
      : super(key: key);

  @override
  State<EditMovie> createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  final List schedule = ['Morning', 'Afternoon', 'Night'];

  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController details = TextEditingController();
  String? selectedText;
  String? selectedTime;

  @override
  initState() {
    title = TextEditingController(text: widget.title);
    desc = TextEditingController(text: widget.desc);
    details = TextEditingController(text: widget.details);
    selectedText = widget.selectedText;
    selectedTime = widget.time;
    super.initState();
  }

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

  editMovie(String collection, String title, String desc, String time,
      String details) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('movies');
    await reference.doc(title.replaceAll(' ', '')).set({
      'title': title,
      'desc': desc,
      'period': collection,
      'time': time,
      'details': details
    }).then((value) {
      print('value');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Movie Edited'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {},
          )));
    });
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
          'Edit Movie',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          children: [
            Expanded(
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
                                                          afternoonTime[index];
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
                        editMovie(selectedText!, title.text, desc.text,
                            selectedTime!, details.text);
                        //title.clear();
                        //desc.clear();
                      }
                    },
                    child: const Text(
                      'Edit Movie',
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
