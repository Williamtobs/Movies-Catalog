import 'package:flutter/material.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({Key? key}) : super(key: key);

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final List schedule = ['Morning', 'Afternoon', 'Night'];

  String? selectedText;

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
              child: Column(
                children: [
                  const SizedBox(height: 20),
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
                        color: const Color.fromRGBO(197,198,200, 1.0),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
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
                    child:  Text(
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
                        color: const Color.fromRGBO(197,198,200, 1.0),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLines: 5,
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
                                          color: const Color.fromRGBO(75, 78, 85, 1)),
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
                  )
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
                      /*Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const AdminDashboardView();
                          }));*/
                    },
                    child: const Text(
                      'Add Movie',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ))),
            const SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }
}
