import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawn_book/model/peminjam_model.dart';

class PeminjamController {
  final pinjamcollection = FirebaseFirestore.instance.collection('peminjam');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addPeminjam(PeminjamModel pjmodel) async {
    final peminjam = pjmodel.toMap();

    final DocumentReference docRef = await pinjamcollection.add(peminjam);

    final String docId = docRef.id;

    final PeminjamModel peminjamModel = PeminjamModel(
      pid: docId,
      namapeminjam: pjmodel.namapeminjam,
      selectedBuku: pjmodel.selectedBuku,
      pengarang: pjmodel.pengarang,
      tglpinjam: pjmodel.tglpinjam,
      tglkembali: pjmodel.tglkembali,
    );

    await docRef.update(peminjamModel.toMap());
  }

  Future<void> updatePeminjam(PeminjamModel pjmodel) async {
    final PeminjamModel peminjamModel = PeminjamModel(
        pid: pjmodel.pid,
        namapeminjam: pjmodel.namapeminjam,
        selectedBuku: pjmodel.selectedBuku,
        pengarang: pjmodel.pengarang,
        tglpinjam: pjmodel.tglpinjam,
        tglkembali: pjmodel.tglkembali);

    await pinjamcollection.doc(pjmodel.pid).update(peminjamModel.toMap());
  }

  Future<void> removePeminjam(String pid) async {
    await pinjamcollection.doc(pid).delete();
  }

  Future getPinjam() async {
    final contact = await pinjamcollection.get();
    streamController.add(contact.docs);
    return contact.docs;
  }
}
