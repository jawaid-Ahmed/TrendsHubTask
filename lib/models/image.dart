// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ImageModel {
  final String fileName;
  final String userId;
  final String fileUrl;
  final String createdDate;

  ImageModel({
    required this.fileName,
    required this.userId,
    required this.fileUrl,
    required this.createdDate,
  });

  ImageModel copyWith({
    String? fileName,
    String? userId,
    String? fileUrl,
    String? createdDate,
  }) {
    return ImageModel(
      fileName: fileName ?? this.fileName,
      userId: userId ?? this.userId,
      fileUrl: fileUrl ?? this.fileUrl,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fileName': fileName,
      'userId': userId,
      'fileUrl': fileUrl,
      'createdDate': createdDate,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      fileName: map['fileName'] as String,
      userId: map['userId'] as String,
      fileUrl: map['fileUrl'] as String,
      createdDate: map['createdDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ImageModel(fileName: $fileName, userId: $userId, fileUrl: $fileUrl, createdDate: $createdDate)';
  }

  @override
  bool operator ==(covariant ImageModel other) {
    if (identical(this, other)) return true;

    return other.fileName == fileName &&
        other.userId == userId &&
        other.fileUrl == fileUrl &&
        other.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return fileName.hashCode ^
        userId.hashCode ^
        fileUrl.hashCode ^
        createdDate.hashCode;
  }
}
