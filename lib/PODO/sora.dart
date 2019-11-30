class Sora {
  int id;
  String nameAr;
  int ayatCount;
  int pageNum;
  int type;
  String typeTextAr;
  String nameEn;
  String nameFr;
  String typeTextEn;
  String typeTextFr;
  String searchText;

  Sora(
      {this.id,
      this.nameAr,
      this.ayatCount,
      this.pageNum,
      this.type,
      this.typeTextAr,
      this.nameEn,
      this.nameFr,
      this.typeTextEn,
      this.typeTextFr,
      this.searchText});

  factory Sora.fromJson(Map<String, dynamic> data) => Sora(
        id: data["Id"],
        nameAr: data["Name_ar"],
        ayatCount: data["AyatCount"],
        pageNum: data["PageNum"],
        type: data["Type"],
        typeTextAr: data["TypeText_ar"],
        nameEn: data["Name_en"],
        nameFr: data["Name_fr"],
        typeTextEn: data["TypeText_en"],
        typeTextFr: data["TypeText_fr"],
        searchText: data["SearchText"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name_ar": nameAr,
        "AyatCount": ayatCount,
        "PageNum": pageNum,
        "Type": type,
        "TypeText_ar": typeTextAr,
        "Name_en": nameEn,
        "Name_fr": nameFr,
        "TypeText_en": typeTextEn,
        "TypeText_fr": searchText,
        "TypeText_fr": searchText,
      };
}
