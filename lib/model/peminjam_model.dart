// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PeminjamModel {
  String? pid;
  final String namapeminjam;
  final String selectedBuku;
  final String pengarang;
  final String tglpinjam;
  final String tglkembali;
  PeminjamModel({
    this.pid,
    required this.namapeminjam,
    required this.selectedBuku,
    required this.pengarang,
    required this.tglpinjam,
    required this.tglkembali,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'namapeminjam': namapeminjam,
      'selectedBuku': selectedBuku,
      'pengarang': pengarang,
      'tglpinjam': tglpinjam,
      'tglkembali': tglkembali,
    };
  }

  factory PeminjamModel.fromMap(Map<String, dynamic> map) {
    return PeminjamModel(
      pid: map['pid'] != null ? map['pid'] as String : null,
      namapeminjam: map['namapeminjam'] as String,
      selectedBuku: map['selectedBuku'] as String,
      pengarang: map['pengarang'] as String,
      tglpinjam: map['tglpinjam'] as String,
      tglkembali: map['tglkembali'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PeminjamModel.fromJson(String source) =>
      PeminjamModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
