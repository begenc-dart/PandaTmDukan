// To parse this JSON data, do
//
//     final languageModel = languageModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LanguageModel languageModelFromJson(String str) => LanguageModel.fromJson(json.decode(str));

String languageModelToJson(LanguageModel data) => json.encode(data.toJson());

class LanguageModel {
  LanguageModel({
    required this.dukan,
    required this.kat,
    required this.sargyt,
    required this.profile,
    required this.mydukan,
    required this.all,
    required this.garas,
    required this.kabulEt,
    required this.kabulEtm,
    required this.uytget,
    required this.dil,
    required this.security,
    required this.bizB,
    required this.use,
    required this.contact,
    required this.nameD,
    required this.adress,
    required this.nomer,
    required this.gosmacaTel,
    required this.dowam,
    required this.suratuyt,
    required this.ady,
    required this.haty,
    required this.send,
    required this.addTow,
    required this.harytady,
    required this.baha,
    required this.harytCode,
    required this.aksiya,
    required this.arzanladys,
    required this.subKat,
    required this.gysgaMaglumatTm,
    required this.gysgaMaglumatRu,
    required this.gornus,
    required this.gornusGos,
    required this.suratgosmak,
    required this.detalSuratgos,
    required this.stokda,
    required this.yes,
    required this.no,
    required this.olceg,
    required this.olcegGos,
    required this.gornusAdyTm,
    required this.gornusAdyRu,
    required this.search,
  });

  String dukan;
  String kat;
  String sargyt;
  String profile;
  String mydukan;
  String all;
  String garas;
  String kabulEt;
  String kabulEtm;
  String uytget;
  String dil;
  String bizB;
  String security;
  String use;
  String contact;
  String nameD;
  String adress;
  String nomer;
  String gosmacaTel;
  String dowam;
  String suratuyt;
  String ady;
  String haty;
  String send;
  String addTow;
  String harytady;
  String baha;
  String harytCode;
  String aksiya;
  String arzanladys;
  String subKat;
  String gysgaMaglumatTm;
  String gysgaMaglumatRu;
  String gornus;
  String gornusGos;
  String suratgosmak;
  String detalSuratgos;
  String stokda;
  String yes;
  String no;
  String olceg;
  String olcegGos;
  String gornusAdyTm;
  String gornusAdyRu;
  String search;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    dukan: json["dukan"],
    kat: json["kat"],
    sargyt: json["sargyt"],
    profile: json["profile"],
    mydukan: json["mydukan"],
    all: json["all"],
    garas: json["garas"],
    kabulEt: json["kabulEt"],
    kabulEtm: json["kabulEtm"],
    uytget: json["uytget"],
    dil: json["dil"],
    security: json["security"],
    bizB: json["bizB"],
    use: json["use"],
    contact: json["contact"],
    nameD: json["nameD"],
    adress: json["adress"],
    nomer: json["nomer"],
    gosmacaTel: json["gosmacaTel"],
    dowam: json["dowam"],
    suratuyt: json["suratuyt"],
    ady: json["ady"],
    haty: json["haty"],
    send: json["send"],
    addTow: json["addTow"],
    harytady: json["harytady"],
    baha: json["baha"],
    harytCode: json["harytCode"],
    aksiya: json["aksiya"],
    arzanladys: json["arzanladys"],
    subKat: json["subKat"],
    gysgaMaglumatTm: json["gysgaMaglumatTm"],
    gysgaMaglumatRu: json["gysgaMaglumatRu"],
    gornus: json["gornus"],
    gornusGos: json["gornusGos"],
    suratgosmak: json["suratgosmak"],
    detalSuratgos: json["detalSuratgos"],
    stokda: json["stokda"],
    yes: json["yes"],
    no: json["no"],
    olceg: json["olceg"],
    olcegGos: json["olcegGos"],
    gornusAdyTm: json["gornusAdyTm"],
    gornusAdyRu: json["gornusAdyRu"],
    search: json["search"],
  );

  Map<String, dynamic> toJson() => {
    "dukan": dukan,
    "kat": kat,
    "sargyt": sargyt,
    "profile": profile,
    "mydukan": mydukan,
    "all": all,
    "garas": garas,
    "kabulEt": kabulEt,
    "kabulEtm": kabulEtm,
    "uytget": uytget,
    "dil": dil,
    "security": security,
    "bizB": bizB,
    "use": use,
    "contact": contact,
    "nameD": nameD,
    "adress": adress,
    "nomer": nomer,
    "gosmacaTel": gosmacaTel,
    "dowam": dowam,
    "suratuyt": suratuyt,
    "ady": ady,
    "haty": haty,
    "send": send,
    "addTow": addTow,
    "harytady": harytady,
    "baha": baha,
    "harytCode": harytCode,
    "aksiya": aksiya,
    "arzanladys": arzanladys,
    "subKat": subKat,
    "gysgaMaglumatTm": gysgaMaglumatTm,
    "gysgaMaglumatRu": gysgaMaglumatRu,
    "gornus": gornus,
    "gornusGos": gornusGos,
    "suratgosmak": suratgosmak,
    "detalSuratgos": detalSuratgos,
    "stokda": stokda,
    "yes": yes,
    "no": no,
    "olceg": olceg,
    "olcegGos": olcegGos,
    "gornusAdyTm": gornusAdyTm,
    "gornusAdyRu": gornusAdyRu,
    "search": search,
  };
}
