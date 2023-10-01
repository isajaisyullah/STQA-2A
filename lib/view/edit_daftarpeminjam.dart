// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawn_book/controller/peminjam_controller.dart';
import 'package:pawn_book/model/peminjam_model.dart';
import 'package:pawn_book/view/Homepage.dart';

class EditPeminjam extends StatefulWidget {
  const EditPeminjam({
    Key? key,
    this.pid,
    this.namapeminjam,
    this.selectedBuku,
    this.pengarang,
    this.tglpinjam,
    this.tglkembali,
  }) : super(key: key);

  final String? pid;
  final String? namapeminjam;
  final String? selectedBuku;
  final String? pengarang;
  final String? tglpinjam;
  final String? tglkembali;

  @override
  State<EditPeminjam> createState() => _EditPeminjamState();
}

class _EditPeminjamState extends State<EditPeminjam> {
  String? enamapeminjam;
  String? eselectedBuku;
  String? epengarang;
  String? etglpinjam;
  String? etglkembali;

  Map<String, dynamic> pengarangBuku = {};

  var peminjamcontroller = PeminjamController();

  final TextEditingController newdatememinjam = TextEditingController();
  final TextEditingController newdatepengembalian = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    eselectedBuku = widget.selectedBuku;
    epengarang = widget.pengarang;
    newdatememinjam.text = widget.tglpinjam ?? '';
    newdatepengembalian.text = widget.tglkembali ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 209, 131, 102),
        title: Text(
          'Edit Data Daftar Peminjam',
          style: TextStyle(fontFamily: "ShortBaby"),
        ),
      ),
      backgroundColor: Colors.brown[100],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(children: [
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
                    onSaved: (value) {
                      enamapeminjam = value;
                    },
                    initialValue: widget.namapeminjam,
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
                            //Icon(Icons.arrow_drop_down),
                            DropdownButton(
                              items: judulbuku,
                              onChanged: (value) {
                                setState(() {
                                  eselectedBuku = value;
                                  epengarang = pengarangBuku[value];
                                });
                              },
                              value: eselectedBuku,
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
                              epengarang ?? '', // Tambahkan widget Text ini
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
                //     onSaved: (value) {
                //       epengarang = value;
                //     },
                //     initialValue: widget.pengarang,
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
                    controller: newdatememinjam,
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
                        etglpinjam = DateFormat('dd-MM-yyyy').format(picked);

                        setState(() {
                          newdatememinjam.text = etglpinjam.toString();
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
                    controller: newdatepengembalian,
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
                        etglkembali = DateFormat('dd-MM-yyyy').format(picked);

                        setState(() {
                          newdatepengembalian.text = etglkembali.toString();
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
                        _formKey.currentState!.save();
                        PeminjamModel pjm = PeminjamModel(
                          pid: widget.pid,
                          namapeminjam: enamapeminjam!,
                          selectedBuku: eselectedBuku!,
                          pengarang: epengarang!,
                          tglpinjam: newdatememinjam.text,
                          tglkembali: newdatepengembalian.text,
                        );

                        peminjamcontroller.updatePeminjam(pjm);
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      )),
    );
  }
}
