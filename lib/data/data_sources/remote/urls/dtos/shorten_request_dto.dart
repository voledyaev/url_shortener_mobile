import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shorten_request_dto.g.dart';

@immutable
@JsonSerializable()
class ShortenRequestDto {
  const ShortenRequestDto({
    required this.url,
    required this.ttl,
  });

  factory ShortenRequestDto.fromJson(Map<String, dynamic> json) => _$ShortenRequestDtoFromJson(json);

  final Uri url;
  final int? ttl;

  Map<String, dynamic> toJson() => _$ShortenRequestDtoToJson(this);
}
