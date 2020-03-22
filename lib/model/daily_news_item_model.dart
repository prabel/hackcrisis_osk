import 'package:equatable/equatable.dart';

class DailyNewsItemModel extends Equatable {
  final String imageUrl;
  final String linkUrl;

  DailyNewsItemModel({this.imageUrl, this.linkUrl});

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': this.imageUrl,
      'linkUrl': this.linkUrl,
    };
  }

  factory DailyNewsItemModel.fromMap(Map<dynamic, dynamic> map) {
    return new DailyNewsItemModel(
      imageUrl: map['imageUrl'] as String,
      linkUrl: map['linkUrl'] as String,
    );
  }

  @override
  List<Object> get props => [imageUrl, linkUrl];
}
