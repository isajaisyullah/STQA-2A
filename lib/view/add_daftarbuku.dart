import 'package:flutter/material.dart';
import 'package:pawn_book/controller/buku_controller.dart';
import 'package:pawn_book/model/buku_model.dart';
import 'package:pawn_book/view/daftarbuku.dart';

class AddBuku extends StatefulWidget {
  const AddBuku({super.key});

  @override
  State<AddBuku> createState() => _AddBukuState();
}

class _AddBukuState extends State<AddBuku> {
  final _formKey = GlobalKey<FormState>();

  var bukuController = BukuController();

  String? selectedValue;
  String? judulbuku;
  String? pengarangbuku;
  String? penerbitbuku;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 209, 131, 102),
        title: Text(
          'Daftar Buku',
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
                    onChanged: (value) {
                      judulbuku = value;
                    },
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
                    onChanged: (value) {
                      pengarangbuku = value;
                    },
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
                    onChanged: (value) {
                      penerbitbuku = value;
                    },
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
                      value: selectedValue,
                      items: generateItems(status),
                      onChanged: (item) {
                        setState(() {
                          selectedValue = item;
                        });
                      },
                    )),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BukuModel bm = BukuModel(
                          judulbuku: judulbuku!,
                          pengarangbuku: pengarangbuku!,
                          penerbitbuku: penerbitbuku!,
                          selectedValue: selectedValue!,
                        );

                        bukuController.addBuku(bm);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Buku Added')));

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
