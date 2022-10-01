import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  String uidPassanger;
  String uidNote;
  String uidDriverToChat;
  String adressFrom;
  String adressToGo;
  bool isChildren;
  String childrenCount;
  bool isAnimals;
  String whatAnimal;
  String remark;
  String passangerPrice;

  Note({
    required this.uidPassanger,
    required this.uidNote,
    required this.uidDriverToChat,
    required this.adressFrom,
    required this.adressToGo,
    required this.isChildren,
    required this.childrenCount,
    required this.isAnimals,
    required this.whatAnimal,
    required this.remark,
    required this.passangerPrice,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
