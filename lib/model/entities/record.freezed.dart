// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Record _$RecordFromJson(Map<String, dynamic> json) {
  return _Record.fromJson(json);
}

/// @nodoc
mixin _$Record {
  MaterialData get material => throw _privateConstructorUsedError;
  String get learningTime => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordCopyWith<Record> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordCopyWith<$Res> {
  factory $RecordCopyWith(Record value, $Res Function(Record) then) =
      _$RecordCopyWithImpl<$Res>;
  $Res call(
      {MaterialData material,
      String learningTime,
      String description,
      DateTime createdAt});

  $MaterialDataCopyWith<$Res> get material;
}

/// @nodoc
class _$RecordCopyWithImpl<$Res> implements $RecordCopyWith<$Res> {
  _$RecordCopyWithImpl(this._value, this._then);

  final Record _value;
  // ignore: unused_field
  final $Res Function(Record) _then;

  @override
  $Res call({
    Object? material = freezed,
    Object? learningTime = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      material: material == freezed
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as MaterialData,
      learningTime: learningTime == freezed
          ? _value.learningTime
          : learningTime // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  @override
  $MaterialDataCopyWith<$Res> get material {
    return $MaterialDataCopyWith<$Res>(_value.material, (value) {
      return _then(_value.copyWith(material: value));
    });
  }
}

/// @nodoc
abstract class _$$_RecordCopyWith<$Res> implements $RecordCopyWith<$Res> {
  factory _$$_RecordCopyWith(_$_Record value, $Res Function(_$_Record) then) =
      __$$_RecordCopyWithImpl<$Res>;
  @override
  $Res call(
      {MaterialData material,
      String learningTime,
      String description,
      DateTime createdAt});

  @override
  $MaterialDataCopyWith<$Res> get material;
}

/// @nodoc
class __$$_RecordCopyWithImpl<$Res> extends _$RecordCopyWithImpl<$Res>
    implements _$$_RecordCopyWith<$Res> {
  __$$_RecordCopyWithImpl(_$_Record _value, $Res Function(_$_Record) _then)
      : super(_value, (v) => _then(v as _$_Record));

  @override
  _$_Record get _value => super._value as _$_Record;

  @override
  $Res call({
    Object? material = freezed,
    Object? learningTime = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_Record(
      material: material == freezed
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as MaterialData,
      learningTime: learningTime == freezed
          ? _value.learningTime
          : learningTime // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Record with DiagnosticableTreeMixin implements _Record {
  const _$_Record(
      {required this.material,
      required this.learningTime,
      required this.description,
      required this.createdAt});

  factory _$_Record.fromJson(Map<String, dynamic> json) =>
      _$$_RecordFromJson(json);

  @override
  final MaterialData material;
  @override
  final String learningTime;
  @override
  final String description;
  @override
  final DateTime createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Record(material: $material, learningTime: $learningTime, description: $description, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Record'))
      ..add(DiagnosticsProperty('material', material))
      ..add(DiagnosticsProperty('learningTime', learningTime))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Record &&
            const DeepCollectionEquality().equals(other.material, material) &&
            const DeepCollectionEquality()
                .equals(other.learningTime, learningTime) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(material),
      const DeepCollectionEquality().hash(learningTime),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_RecordCopyWith<_$_Record> get copyWith =>
      __$$_RecordCopyWithImpl<_$_Record>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecordToJson(this);
  }
}

abstract class _Record implements Record {
  const factory _Record(
      {required final MaterialData material,
      required final String learningTime,
      required final String description,
      required final DateTime createdAt}) = _$_Record;

  factory _Record.fromJson(Map<String, dynamic> json) = _$_Record.fromJson;

  @override
  MaterialData get material;
  @override
  String get learningTime;
  @override
  String get description;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_RecordCopyWith<_$_Record> get copyWith =>
      throw _privateConstructorUsedError;
}
