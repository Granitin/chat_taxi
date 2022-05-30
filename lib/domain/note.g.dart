// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      uidPassanger: json['uidPassanger'] as String,
      uidNote: json['uidNote'] as String,
      uidDriverToChat: json['uidDriverToChat'] as String,
      adressFrom: json['adressFrom'] as String,
      adressToGo: json['adressToGo'] as String,
      isChildren: json['isChildren'] as bool,
      childrenCount: json['childrenCount'] as String,
      isAnimals: json['isAnimals'] as bool,
      whatAnimal: json['whatAnimal'] as String,
      remark: json['remark'] as String,
      passangerPrice: json['passangerPrice'] as String,
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'uidPassanger': instance.uidPassanger,
      'uidNote': instance.uidNote,
      'uidDriverToChat': instance.uidDriverToChat,
      'adressFrom': instance.adressFrom,
      'adressToGo': instance.adressToGo,
      'isChildren': instance.isChildren,
      'childrenCount': instance.childrenCount,
      'isAnimals': instance.isAnimals,
      'whatAnimal': instance.whatAnimal,
      'remark': instance.remark,
      'passangerPrice': instance.passangerPrice,
    };
