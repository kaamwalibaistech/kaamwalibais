import '../models/whatweare_model.dart';

class ServiceItem {
  final String image;
  final String title;
  final String content;

  ServiceItem({
    required this.image,
    required this.title,
    required this.content,
  });
}

List<ServiceItem> getServiceList(WhatweareModel data) {
  return [
    ServiceItem(
      image: data.imageMaids ?? '',
      title: data.titleMaids ?? '',
      content: data.contentMaids ?? '',
    ),
    ServiceItem(
      image: data.imageBabysitter ?? '',
      title: data.titleBabysitter ?? '',
      content: data.contentBabysitter ?? '',
    ),
    ServiceItem(
      image: data.imageCook ?? '',
      title: data.titleCook ?? '',
      content: data.contentCook ?? '',
    ),
    ServiceItem(
      image: data.imageElder ?? '',
      title: data.titleElder ?? '',
      content: data.contentElder ?? '',
    ),
    ServiceItem(
      image: data.imagePatient ?? '',
      title: data.titlePatient ?? '',
      content: data.contentPatient ?? '',
    ),
    ServiceItem(
      image: data.imageJapa ?? '',
      title: data.titleJapa ?? '',
      content: data.contentJapa ?? '',
    ),
    ServiceItem(
      image: data.imagePetCare ?? '',
      title: data.titlePetCare ?? '',
      content: data.contentPetCare ?? '',
    ),
    ServiceItem(
      image: data.imageDriver ?? '',
      title: data.titleDriver ?? '',
      content: data.contentDriver ?? '',
    ),
  ];
}
