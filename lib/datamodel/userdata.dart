import 'package:flutter/material.dart';

class Userdata {
  Userdata(
      {
      // required this.email,
      // required this.data,
      // required this.cutoff,
      required this.name,
      required this.phone,
      required this.appno,
      required this.Groupcode,
      required this.Nativity,
      required this.adharno,
      required this.coff,
      required this.comunity,
      required this.exser,
      required this.pchalage,
      required this.rank,
      required this.s1,
      required this.s2,
      required this.s3,
      required this.sport,
      required this.studgovt,
      required this.s12regno,
      required this.s12rollno,
      required this.img});
  // late final String email;
  // late final String data;
  // late final int cutoff;
  late final String name;
  late final String phone;
  late final int appno;
  late final int Groupcode;
  late final String Nativity;
  late final int adharno;
  late final double coff;
  late final String comunity;
  late final bool exser;
  late final bool pchalage;
  late final int rank;
  late final int s1;
  late final int s2;
  late final int s3;
  late final bool sport;
  late final bool studgovt;
  late final int s12regno;
  late final int s12rollno;
  late final String img;

  Userdata.fromJson(Map<String, dynamic> json) {
    // email = json['email'];
    // data = json['data'];
    // cutoff = json['cutoff'];
    name = json['name'];
    phone = json['phone'];
    appno = json['appno'];
    Groupcode = json['Groupcode'];
    Nativity = json['Nativity'];
    adharno = json['adharno'];
    coff = json['coff'];
    comunity = json['comunity'];
    exser = json['exser'];
    pchalage = json['pchalage'];
    rank = json['rank'];
    s1 = json['s1'];
    s2 = json['s2'];
    s3 = json['s3'];
    sport = json['sport'];
    studgovt = json['studgovt'];
    s12regno = json['s12regno'];
    s12rollno = json['s12rollno'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['email'] = email;
    // _data['data'] = data;
    // _data['cutoff'] = cutoff;
    _data['name'] = name;
    _data['phone'] = phone;
    _data['appno'] = appno;
    _data['Groupcode'] = Groupcode;
    _data['Nativity'] = Nativity;
    _data['adharno'] = adharno;
    _data['coff'] = coff;
    _data['comunity'] = comunity;
    _data['exser'] = exser;
    _data['pchalage'] = pchalage;
    _data['rank'] = rank;
    _data['s1'] = s1;
    _data['s2'] = s2;
    _data['s3'] = s3;
    _data['sport'] = sport;
    _data['studgovt'] = studgovt;
    _data['s12regno'] = s12regno;
    _data['s12rollno'] = s12rollno;
    _data['img'] = img;
    return _data;
  }
}
