import 'package:equatable/equatable.dart';

class AssistanceExtraInformationModel extends Equatable {
  final String description;
  final String url;

  AssistanceExtraInformationModel({this.description, this.url});

  factory AssistanceExtraInformationModel.fromMap(Map<dynamic, dynamic> map) {
    return new AssistanceExtraInformationModel(
      description: map['description'] as String,
      url: map['url'] as String,
    );
  }

  @override
  List<Object> get props => [description, url];
}
