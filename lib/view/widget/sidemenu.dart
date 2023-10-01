import 'package:flutter/material.dart';
import 'package:pawn_book/controller/auth_controller.dart';
import 'package:pawn_book/view/daftarbuku.dart';
import 'package:pawn_book/view/dailyreport.dart';
import 'package:pawn_book/view/homepage.dart';
import 'package:pawn_book/view/loginpage.dart';
import 'package:pawn_book/view/profile.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  var authctrl = AuthController();

  bool isLoggedOut = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 233, 171, 148),
        body: SafeArea(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: const Text(
                  "Admin",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                leading: const SizedBox(
                  height: 34,
                  width: 34,
                  child: Icon(Icons.list_alt_sharp),
                ),
                title: Text("Daftar Peminjam"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => DaftarBuku()));
                },
                leading: const SizedBox(
                  height: 34,
                  width: 34,
                  child: Icon(Icons.book),
                ),
                title: const Text("Daftar Buku"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DailyReportPage()));
                },
                leading: const SizedBox(
                  height: 34,
                  width: 34,
                  child: Icon(Icons.article_rounded),
                ),
                title: const Text("Daily Report"),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Konfirmasi Logout"),
                        content: const Text("Apakah Anda yakin ingin logout?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Tutup dialog
                            },
                            child: const Text("Batal"),
                          ),
                          TextButton(
                            onPressed: () {
                              authctrl.signOut();
                              setState(() {
                                isLoggedOut = true;
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: const Text("Logout"),
                          ),
                        ],
                      );
                    },
                  );
                },
                title: const Text(
                  "Logout",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
