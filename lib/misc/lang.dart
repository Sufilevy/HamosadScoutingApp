import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

final langEntries = {};

var table = [
  0x20AC, //EURO SIGN
  0xFFED, //UNDEFINED
  0x201A, //SINGLE LOW-9 QUOTATION MARK
  0x0192, //LATIN SMALL LETTER F WITH HOOK
  0x201E, //DOUBLE LOW-9 QUOTATION MARK
  0x2026, //HORIZONTAL ELLIPSIS
  0x2020, //DAGGER
  0x2021, //DOUBLE DAGGER
  0x02C6, //MODIFIER LETTER CIRCUMFLEX ACCENT
  0x2030, //PER MILLE SIGN
  0xFFED, //UNDEFINED
  0x2039, //SINGLE LEFT-POINTING ANGLE QUOTATION MARK
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0x2018, //LEFT SINGLE QUOTATION MARK
  0x2019, //RIGHT SINGLE QUOTATION MARK
  0x201C, //LEFT DOUBLE QUOTATION MARK
  0x201D, //RIGHT DOUBLE QUOTATION MARK
  0x2022, //BULLET
  0x2013, //EN DASH
  0x2014, //EM DASH
  0x02DC, //SMALL TILDE
  0x2122, //TRADE MARK SIGN
  0xFFED, //UNDEFINED
  0x203A, //SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0x00A0, //NO-BREAK SPACE
  0x00A1, //INVERTED EXCLAMATION MARK
  0x00A2, //CENT SIGN
  0x00A3, //POUND SIGN
  0x20AA, //NEW SHEQEL SIGN
  0x00A5, //YEN SIGN
  0x00A6, //BROKEN BAR
  0x00A7, //SECTION SIGN
  0x00A8, //DIAERESIS
  0x00A9, //COPYRIGHT SIGN
  0x00D7, //MULTIPLICATION SIGN
  0x00AB, //LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
  0x00AC, //NOT SIGN
  0x00AD, //SOFT HYPHEN
  0x00AE, //REGISTERED SIGN
  0x00AF, //MACRON
  0x00B0, //DEGREE SIGN
  0x00B1, //PLUS-MINUS SIGN
  0x00B2, //SUPERSCRIPT TWO
  0x00B3, //SUPERSCRIPT THREE
  0x00B4, //ACUTE ACCENT
  0x00B5, //MICRO SIGN
  0x00B6, //PILCROW SIGN
  0x00B7, //MIDDLE DOT
  0x00B8, //CEDILLA
  0x00B9, //SUPERSCRIPT ONE
  0x00F7, //DIVISION SIGN
  0x00BB, //RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
  0x00BC, //VULGAR FRACTION ONE QUARTER
  0x00BD, //VULGAR FRACTION ONE HALF
  0x00BE, //VULGAR FRACTION THREE QUARTERS
  0x00BF, //INVERTED QUESTION MARK
  0x05B0, //HEBREW POINT SHEVA
  0x05B1, //HEBREW POINT HATAF SEGOL
  0x05B2, //HEBREW POINT HATAF PATAH
  0x05B3, //HEBREW POINT HATAF QAMATS
  0x05B4, //HEBREW POINT HIRIQ
  0x05B5, //HEBREW POINT TSERE
  0x05B6, //HEBREW POINT SEGOL
  0x05B7, //HEBREW POINT PATAH
  0x05B8, //HEBREW POINT QAMATS
  0x05B9, //HEBREW POINT HOLAM
  0xFFED, //UNDEFINED
  0x05BB, //HEBREW POINT QUBUTS
  0x05BC, //HEBREW POINT DAGESH OR MAPIQ
  0x05BD, //HEBREW POINT METEG
  0x05BE, //HEBREW PUNCTUATION MAQAF
  0x05BF, //HEBREW POINT RAFE
  0x05C0, //HEBREW PUNCTUATION PASEQ
  0x05C1, //HEBREW POINT SHIN DOT
  0x05C2, //HEBREW POINT SIN DOT
  0x05C3, //HEBREW PUNCTUATION SOF PASUQ
  0x05F0, //HEBREW LIGATURE YIDDISH DOUBLE VAV
  0x05F1, //HEBREW LIGATURE YIDDISH VAV YOD
  0x05F2, //HEBREW LIGATURE YIDDISH DOUBLE YOD
  0x05F3, //HEBREW PUNCTUATION GERESH
  0x05F4, //HEBREW PUNCTUATION GERSHAYIM
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0x05D0, //HEBREW LETTER ALEF
  0x05D1, //HEBREW LETTER BET
  0x05D2, //HEBREW LETTER GIMEL
  0x05D3, //HEBREW LETTER DALET
  0x05D4, //HEBREW LETTER HE
  0x05D5, //HEBREW LETTER VAV
  0x05D6, //HEBREW LETTER ZAYIN
  0x05D7, //HEBREW LETTER HET
  0x05D8, //HEBREW LETTER TET
  0x05D9, //HEBREW LETTER YOD
  0x05DA, //HEBREW LETTER FINAL KAF
  0x05DB, //HEBREW LETTER KAF
  0x05DC, //HEBREW LETTER LAMED
  0x05DD, //HEBREW LETTER FINAL MEM
  0x05DE, //HEBREW LETTER MEM
  0x05DF, //HEBREW LETTER FINAL NUN
  0x05E0, //HEBREW LETTER NUN
  0x05E1, //HEBREW LETTER SAMEKH
  0x05E2, //HEBREW LETTER AYIN
  0x05E3, //HEBREW LETTER FINAL PE
  0x05E4, //HEBREW LETTER PE
  0x05E5, //HEBREW LETTER FINAL TSADI
  0x05E6, //HEBREW LETTER TSADI
  0x05E7, //HEBREW LETTER QOF
  0x05E8, //HEBREW LETTER RESH
  0x05E9, //HEBREW LETTER SHIN
  0x05EA, //HEBREW LETTER TAV
  0xFFED, //UNDEFINED
  0xFFED, //UNDEFINED
  0x200E, //LEFT-TO-RIGHT MARK
  0x200F, //RIGHT-TO-LEFT MARK
  0xFFED, //UNDEFINED
];

class Lang {
  static const en = {
    "i": 0,
    "d": TextDirection.ltr,
  };

  static const he = {
    "i": 1,
    "d": TextDirection.ltr,
  };
}

var currentLang = Lang.he;

Future<ByteData> getLangEntriesFile() async {
  return await rootBundle.load('assets/lang/lang_entries.csv');
}

Future<void> getLangEntries() async {
  final file = (await getLangEntriesFile()).buffer.asUint8List();

  var length = file.length;
  final List<int> codes = List<int>.filled(length, 0);
  for (var i = 0; i < length; i++) {
    var byte = file[i];
    codes[i] = byte < 0x80 ? byte : table[byte - 0x80];
  }
  final fields =
      const CsvToListConverter().convert(String.fromCharCodes(codes));

  langEntries.addEntries(
      {for (var element in fields) element[0]: element.sublist(1)}.entries);

  return;
}
