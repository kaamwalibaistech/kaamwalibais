class AboutUsModel {
  final String? quote;
  final String? pTag;
  final String? pTag1;
  final String? pTag2;
  final String? pTag3;
  final String? image1;
  final String? pTag4;
  final String? pTag5;
  final String? pTag6;
  final String? h3;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? image5;
  final String? h2;
  final String? pTag7;
  final String? pTag8;
  final String? pTag9;

  AboutUsModel({
    this.quote,
    this.pTag,
    this.pTag1,
    this.pTag2,
    this.pTag3,
    this.image1,
    this.pTag4,
    this.pTag5,
    this.pTag6,
    this.h3,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.h2,
    this.pTag7,
    this.pTag8,
    this.pTag9,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      quote: json['Quote'],
      pTag: json['p_tag'],
      pTag1: json['p_tag1'],
      pTag2: json['p_tag2'],
      pTag3: json['p_tag3'],
      image1: json['image1'],
      pTag4: json['p_tag4'],
      pTag5: json['p_tag5'],
      pTag6: json['p_tag6'],
      h3: json['h3'],
      image2: json['image2'],
      image3: json['image3'],
      image4: json['image4'],
      image5: json['image5'],
      h2: json['h2'],
      pTag7: json['p_tag7'],
      pTag8: json['p_tag8'],
      pTag9: json['p_tag9'],
    );
  }
}
