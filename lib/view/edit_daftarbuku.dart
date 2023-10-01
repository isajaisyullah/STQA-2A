// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pawn_book/controller/buku_controller.dart';
import 'package:pawn_book/model/buku_model.dart';
import 'package:pawn_book/view/daftarbuku.dart';

class EditBuku extends StatefulWidget {
  EditBuku({
    Key? key,
    this.bukuid,
    this.selectedValue,
    this.judulbuku,
    this.pengarangbuku,
    this.penerbitbuku,
  }) : super(key: key);

  final String? bukuid;
  final String? selectedValue;
  final String? judulbuku;
  final String? pengarangbuku;
  final String? penerbitbuku;

  @override
  State<EditBuku> createState() => _EditBukuState();
}

class _EditBukuState extends State<EditBuku> {
  final _formKey = GlobalKey<FormState>();

  var bukuController = BukuController();

  String? eselectedValue;
  String? ejudulbuku;
  String? epengarangbuku;
  String? epenerbitbuku;

  List<String> status = ['Dipinjam', 'Tidak dipinjam'];

  List<DropdownMenuItem> generateItems(List<String> status) {
    List<DropdownMenuItem> items = [];
    for (var item in status) {
      items.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    }
    return items;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eselectedValue = widget.selectedValue;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 209, 131, 102),
        title: Text(
          'Edit Daftar Buku',
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
                    "Judul Buku :",
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
                      hintText: 'Masukan Judul Buku',
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                    onSaved: (value) {
                      ejudulbuku = value;
                    },
                    initialValue: widget.judulbuku,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Nama Pengarang :",
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
                      hintText: 'Masukan Nama Pengarang',
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                    onSaved: (value) {
                      epengarangbuku = value;
                    },
                    initialValue: widget.pengarangbuku,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Penerbit :",
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
                      hintText: 'Masukan Nama Penerbit',
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                    onSaved: (value) {
                      epenerbitbuku = value;
                    },
                    initialValue: widget.penerbitbuku,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Status Buku :",
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
                  child: DropdownButton(
                    dropdownColor: Color.fromARGB(255, 209, 131, 102),
                    value: eselectedValue,
                    items: generateItems(status),
                    onChanged: (item) {
                      setState(() {
                        eselectedValue = item;
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        BukuModel bm = BukuModel(
                            bukuid: widget.bukuid,
                            judulbuku: ejudulbuku!.toString(),
                            pengarangbuku: epengarangbuku!.toString(),
                            penerbitbuku: epenerbitbuku!.toString(),
                            selectedValue: eselectedValue!.toString());
                        bukuController.updateBuku(bm);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Buku diedit')));

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DaftarBuku(),
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
                      "Edit",
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
