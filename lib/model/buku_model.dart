// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BukuModel {
  String? bukuid;
  final String judulbuku;
  final String pengarangbuku;
  final String penerbitbuku;
  final String selectedValue;
  BukuModel({
    this.bukuid,
    required this.judulbuku,
    required this.pengarangbuku,
    required this.penerbitbuku,
    required this.selectedValue,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bukuid': bukuid,
      'judulbuku': judulbuku,
      'pengarangbuku': pengarangbuku,
      'penerbitbuku': penerbitbuku,
      'selectedValue': selectedValue,
    };
  }

  factory BukuModel.fromMap(Map<String, dynamic> map) {
    return BukuModel(
      bukuid: map['bukuid'] != null ? map['bukuid'] as String : null,
      judulbuku: map['judulbuku'] as String,
      pengarangbuku: map['pengarangbuku'] as String,
      penerbitbuku: map['penerbitbuku'] as String,
      selectedValue: map['selectedValue'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BukuModel.fromJson(String source) => BukuModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
