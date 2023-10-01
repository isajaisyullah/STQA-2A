import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pawn_book/controller/peminjam_controller.dart';
import 'package:pawn_book/view/add_daftarbuku.dart';
import 'package:pawn_book/view/add_daftarpeminjam.dart';
import 'package:pawn_book/view/edit_daftarpeminjam.dart';
import 'package:pawn_book/view/widget/header.dart';
import 'package:pawn_book/view/widget/sidemenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var peminjamcontroller = PeminjamController();

  @override
  void initState() {
    peminjamcontroller.getPinjam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      drawer: SideMenu(),
      appBar: header(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Daftar Peminjaman",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder<List<DocumentSnapshot>>(
                stream: peminjamcontroller.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final List<DocumentSnapshot> datapinjam = snapshot.data!;

                  return ListView.builder(
                    itemCount: datapinjam.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onLongPress: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => EditPeminjam(
                            //       pid: datapinjam[index]['pid'],
                            //       namapeminjam: datapinjam[index]
                            //           ['namapeminjam'],
                            //       selectedBuku: datapinjam[index]
                            //               ['selectedBuku']
                            //           .toString(),
                            //       pengarang: datapinjam[index]['pengarang'],
                            //       tglpinjam: datapinjam[index]['tglpinjam'],
                            //       tglkembali: datapinjam[index]['tglkembali'],
                            //     ),
                            //   ),
                            // );
                          },
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              title: Text(datapinjam[index]['namapeminjam']),
                              leading: const Icon(Icons.book),
                              subtitle: Text(
                                  datapinjam[index]['selectedBuku'].toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditPeminjam(
                                              pid: datapinjam[index]['pid'],
                                              namapeminjam: datapinjam[index]
                                                  ['namapeminjam'],
                                              selectedBuku: datapinjam[index]
                                                      ['selectedBuku']
                                                  .toString(),
                                              pengarang: datapinjam[index]
                                                  ['pengarang'],
                                              tglpinjam: datapinjam[index]
                                                  ['tglpinjam'],
                                              tglkembali: datapinjam[index]
                                                  ['tglkembali'],
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.mode_edit_outlined)),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Konfirmasi Hapus Data"),
                                            content: const Text(
                                                "Apakah Anda yakin ingin menghapus data ini?"),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context); // Close the dialog
                                                },
                                                child: const Text("Batal"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // Perform the delete operation here
                                                  peminjamcontroller
                                                      .removePeminjam(
                                                          datapinjam[index]
                                                                  ['pid']
                                                              .toString());
                                                  setState(() {
                                                    peminjamcontroller
                                                        .getPinjam();
                                                  });

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        'Data Peminjam Dihapus'),
                                                  ));

                                                  Navigator.pop(
                                                      context); // Close the dialog
                                                },
                                                child: const Text("Hapus"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPeminjam(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
