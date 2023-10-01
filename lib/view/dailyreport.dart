import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pawn_book/view/widget/header.dart';
import 'package:pawn_book/view/widget/sidemenu.dart';

class DailyReportPage extends StatefulWidget {
  const DailyReportPage({Key? key}) : super(key: key);

  @override
  _DailyReportPageState createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {
  DateTime selectedDate = DateTime.now();
  DateTime filterDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        filterDate = picked;
      });
    }
  }

  void filterByDate(DateTime date) {
    setState(() {
      filterDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        // appBar: header(context),
        drawer: SideMenu(),
        appBar: AppBar(
          title: const Text(
            "PawnBook",
            style: TextStyle(fontSize: 20, fontFamily: "ShortBaby"),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(children: [
            const Text(
              "Daily Report",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('peminjam')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final peminjamanList = snapshot.data!.docs.where((doc) {
                    DateTime tanggalPeminjaman =
                        DateFormat('dd-MM-yyyy').parse(doc['tglpinjam']);
                    return DateFormat('yyyy-MM-dd').format(tanggalPeminjaman) ==
                        DateFormat('yyyy-MM-dd').format(filterDate);
                  }).toList();
                  return ListView.builder(
                    itemCount: peminjamanList.length,
                    itemBuilder: (context, index) {
                      final peminjaman = peminjamanList[index];
                      final tanggalPeminjaman = peminjaman['tglpinjam'];
                      final namaPeminjam = peminjaman['namapeminjam'];
                      final judulBuku = peminjaman['selectedBuku'];
                      return ListTile(
                        title: Text('Peminjam: $namaPeminjam'),
                        subtitle: Text('Buku: $judulBuku'),
                        trailing: Text('Tanggal: $tanggalPeminjaman'),
                      );
                    },
                  );
                },
              ),
            )
          ]),
        ));
  }
}
