class WhatweareModel {
  final String? imageMaids;
  final String? titleMaids;
  final String? contentMaids;

  final String? imageBabysitter;
  final String? titleBabysitter;
  final String? contentBabysitter;

  final String? imageCook;
  final String? titleCook;
  final String? contentCook;

  final String? imageElder;
  final String? titleElder;
  final String? contentElder;

  final String? imagePatient;
  final String? titlePatient;
  final String? contentPatient;

  final String? imageJapa;
  final String? titleJapa;
  final String? contentJapa;

  final String? imagePetCare;
  final String? titlePetCare;
  final String? contentPetCare;

  final String? imageDriver;
  final String? titleDriver;
  final String? contentDriver;

  WhatweareModel({
    this.imageMaids,
    this.titleMaids,
    this.contentMaids,
    this.imageBabysitter,
    this.titleBabysitter,
    this.contentBabysitter,
    this.contentCook,
    this.imageCook,
    this.titleCook,
    this.imageElder,
    this.titleElder,
    this.contentElder,
    this.imagePatient,
    this.titlePatient,
    this.contentPatient,
    this.contentDriver,
    this.contentJapa,
    this.contentPetCare,
    this.imageDriver,
    this.imageJapa,
    this.imagePetCare,
    this.titleDriver,
    this.titleJapa,
    this.titlePetCare,
  });

  factory WhatweareModel.fromJson(Map<String, dynamic> json) => WhatweareModel(
    imageMaids: json['imageMaids'],
    titleMaids: json['titleMaids'],
    contentMaids: json['contentMaids'],

    imageBabysitter: json['imageBabysitter'],
    titleBabysitter: json['titleBabysitter'],
    contentBabysitter: json['ContentBabysitter'],

    imageCook: json['imageCook'],
    titleCook: json['titleCook'],
    contentCook: json['ContentCook'],

    imageElder: json['imageElderlycare'],
    titleElder: json['titleElderlycare'],
    contentElder: json['ContentElderlycare'],

    imagePatient: json['imagePatientCare'],
    titlePatient: json['titlePatientCare'],
    contentPatient: json['ContentPatientCare'],

    imageJapa: json['imageJapaMaids'],
    titleJapa: json['titleJapaMaids'],
    contentJapa: json['ContentJapaMaids'],

    imagePetCare: json['imagePetCare'],
    titlePetCare: json['titlePetCare'],
    contentPetCare: json['ContentPetCare'],

    imageDriver: json['imageDriver'],
    titleDriver: json['titleDriver'],
    contentDriver: json['contentDriver'],
  );
}
