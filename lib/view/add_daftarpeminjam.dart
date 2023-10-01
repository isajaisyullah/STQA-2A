import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawn_book/controller/peminjam_controller.dart';
import 'package:pawn_book/model/peminjam_model.dart';
import 'package:pawn_book/view/homepage.dart';

class AddPeminjam extends StatefulWidget {
  const AddPeminjam({Key? key}) : super(key: key);

  @override
  State<AddPeminjam> createState() => _AddPeminjamState();
}

class _AddPeminjamState extends State<AddPeminjam> {
  final _formKey = GlobalKey<FormState>();

  String? namapeminjam;
  String? pengarang;
  String? tglpinjam;
  String? tglkembali;

  String? selectedBuku;

  Map<String, dynamic> pengarangBuku = {};

  var peminjamcontroller = PeminjamController();

  final TextEditingController datememinjam = TextEditingController();
  final TextEditingController datepengembalian = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 209, 131, 102),
        title: Text(
          'Tambah Data Daftar Peminjam',
          style: TextStyle(fontFamily: "ShortBaby"),
        ),
      ),
      backgroundColor: Colors.brown[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Nama Peminjam :",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(right: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Masukan Nama Peminjam',
                        hintStyle: TextStyle(fontSize: 20),
                      ),
                      onChanged: (value) {
                        namapeminjam = value;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Judul Buku :",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(right: 20),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('buku')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          List<DropdownMenuItem> judulbuku = [];
                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data!.docs[i];
                            Map<String, dynamic> data =
                                snap.data() as Map<String, dynamic>;
                            String? judul = data['judulbuku'] as String?;
                            judulbuku.add(
                              DropdownMenuItem(
                                child: Text(judul!),
                                value: judul,
                              ),
                            );
                            pengarangBuku[judul] = data['pengarangbuku'];
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              DropdownButton(
                                items: judulbuku,
                                onChanged: (value) {
                                  setState(() {
                                    selectedBuku = value;
                                    pengarang = pengarangBuku[value];
                                  });

                                  print(pengarang = pengarangBuku[value]);
                                },
                                value: selectedBuku,
                              ),
                              const Text(
                                "Pengarang :",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(
                                pengarang ?? '', // Tambahkan widget Text ini
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(top: 20),
                  //   padding: const EdgeInsets.only(left: 20),
                  //   alignment: Alignment.centerLeft,
                  //   child: const Text(
                  //     "Pengarang :",
                  //     textAlign: TextAlign.left,
                  //     style: TextStyle(
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 15),
                  //   ),
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.only(left: 10),
                  //   margin: const EdgeInsets.only(right: 20),
                  //   child: TextFormField(
                  //     decoration: const InputDecoration(
                  //       border: UnderlineInputBorder(),
                  //       hintText: 'Masukan Nama Pengarang',
                  //       hintStyle: TextStyle(fontSize: 20),
                  //     ),
                  //     onChanged: (value) {
                  //       pengarang = value;
                  //     },
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Tanggal Meminjam :",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(right: 20),
                    child: TextFormField(
                      controller: datememinjam,
                      decoration: const InputDecoration(
                          hintText: "Pilih Tanggal Meminjam",
                          prefixIcon: Icon(Icons.date_range_outlined),
                          border: UnderlineInputBorder()),
                      readOnly: true,
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (picked != null) {
                          tglpinjam = DateFormat('dd-MM-yyyy').format(picked);

                          setState(() {
                            datememinjam.text = tglpinjam.toString();
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Tanggal Pengembalian :",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(right: 20),
                    child: TextFormField(
                      controller: datepengembalian,
                      decoration: const InputDecoration(
                          hintText: "Pilih Tanggal Pemngembalian",
                          prefixIcon: Icon(Icons.date_range_outlined),
                          border: UnderlineInputBorder()),
                      readOnly: true,
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (picked != null) {
                          tglkembali = DateFormat('dd-MM-yyyy').format(picked);

                          setState(() {
                            datepengembalian.text = tglkembali.toString();
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          PeminjamModel pjm = PeminjamModel(
                            namapeminjam: namapeminjam!,
                            selectedBuku: selectedBuku!,
                            pengarang: pengarang!,
                            tglpinjam: datememinjam.text,
                            tglkembali: datepengembalian.text,
                          );

                          peminjamcontroller.addPeminjam(pjm);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Data Peminjam Ditambahkan')));

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                          ),
                          minimumSize: const Size(350, 60)),
                      child: const Text(
                        "Simpan",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
