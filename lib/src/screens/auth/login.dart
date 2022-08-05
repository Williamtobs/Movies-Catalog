import 'package:flutter/material.dart';

import '../admin/dashboard/dashboard_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 25, 32, 1),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Admin Panel',
              style: TextStyle(
                  color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            const Text(
              'Login to access the Admin Panel',
              style: TextStyle(
                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(37, 42, 52, 1),
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  isDense: true,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Email Address',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(75, 78, 85, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(37, 42, 52, 1),
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                obscureText: true,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  isDense: true,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(75, 78, 85, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(85, 104, 254, 1),
                ),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const AdminDashboardView();
                          }));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ))),
          ],
        ),
      ),
    );
  }
}
