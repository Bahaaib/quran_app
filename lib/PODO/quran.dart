class Quran {
  int id;
  int soraNum;
  int ayaNum;
  int pageNum;
  String soraNameAr;
  String ayaBody;
  int partNum;
  String ayaUserNote;
  String soraNameEn;
  String searchText;

  Quran({this.id, this.soraNum, this.ayaNum, this.pageNum, this.soraNameAr,
      this.ayaBody, this.partNum, this.ayaUserNote, this.soraNameEn,
      this.searchText});




  factory Quran.fromJson(Map<String, dynamic> data) =>  Quran(
    id: data["id"],
    soraNum: data["SoraNum"],
    ayaNum: data["AyaNum"],
    pageNum: data["PageNum"],
    soraNameAr: data["SoraName_ar"],
    ayaBody: data["AyaDiac"],
    partNum: data["PartNum"],
    ayaUserNote: data["AyaUserNote"],
    soraNameEn: data["SoraName_En"],
    searchText: data["SearchText"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "SoraNum": soraNum,
    "AyaNum": ayaNum,
    "PageNum": pageNum,
    "SoraName_ar": soraNameAr,
    "AyaDiac": ayaBody,
    "PartNum": partNum,
    "AyaUserNote": ayaUserNote,
    "SoraName_En": soraNameEn,
    "SearchText": searchText,
  };
}