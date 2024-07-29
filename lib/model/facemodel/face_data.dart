import 'package:cloud_firestore/cloud_firestore.dart';

import 'face_features.dart';

class FaceData {
  String? id;
  String? name;
  String? image;
  FaceFeatures? faceFeatures;
  Timestamp? registeredOn;

  FaceData({
    this.id,
    this.name,
    this.image,
    this.faceFeatures,
    this.registeredOn,
  });

  factory FaceData.fromJson(Map<String, dynamic> json) {
    return FaceData(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      faceFeatures: FaceFeatures.fromJson(json["faceFeatures"]),
      registeredOn: json['registeredOn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'faceFeatures': faceFeatures?.toJson() ?? {},
      'registeredOn': registeredOn,
    };
  }
}
