import 'package:json_annotation/json_annotation.dart';

part 'driver_info.g.dart';

@JsonSerializable()
class Driver {
  String uidDriver;
  String phoneNumberDriver;
  String whatCarDriver;
  String colorCarDriver;
  String numberCarDriver;

  Driver({
    required this.uidDriver,
    required this.phoneNumberDriver,
    required this.whatCarDriver,
    required this.colorCarDriver,
    required this.numberCarDriver,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
  Map<String, dynamic> toJson() => _$DriverToJson(this);
}
