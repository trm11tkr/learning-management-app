// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'developer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Developer _$DeveloperFromJson(Map<String, dynamic> json) {
  return _Developer.fromJson(json);
}

/// @nodoc
mixin _$Developer {
  String get developerId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get targetTime => throw _privateConstructorUsedError;
  StorageFile? get image => throw _privateConstructorUsedError;
  int? get numOfMaterials => throw _privateConstructorUsedError;
  @DateTimeTimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @DateTimeTimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeveloperCopyWith<Developer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeveloperCopyWith<$Res> {
  factory $DeveloperCopyWith(Developer value, $Res Function(Developer) then) =
      _$DeveloperCopyWithImpl<$Res>;
  $Res call(
      {String developerId,
      String? name,
      int? targetTime,
      StorageFile? image,
      int? numOfMaterials,
      @DateTimeTimestampConverter() DateTime? createdAt,
      @DateTimeTimestampConverter() DateTime? updatedAt});

  $StorageFileCopyWith<$Res>? get image;
}

/// @nodoc
class _$DeveloperCopyWithImpl<$Res> implements $DeveloperCopyWith<$Res> {
  _$DeveloperCopyWithImpl(this._value, this._then);

  final Developer _value;
  // ignore: unused_field
  final $Res Function(Developer) _then;

  @override
  $Res call({
    Object? developerId = freezed,
    Object? name = freezed,
    Object? targetTime = freezed,
    Object? image = freezed,
    Object? numOfMaterials = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      developerId: developerId == freezed
          ? _value.developerId
          : developerId // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      targetTime: targetTime == freezed
          ? _value.targetTime
          : targetTime // ignore: cast_nullable_to_non_nullable
              as int?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as StorageFile?,
      numOfMaterials: numOfMaterials == freezed
          ? _value.numOfMaterials
          : numOfMaterials // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  @override
  $StorageFileCopyWith<$Res>? get image {
    if (_value.image == null) {
      return null;
    }

    return $StorageFileCopyWith<$Res>(_value.image!, (value) {
      return _then(_value.copyWith(image: value));
    });
  }
}

/// @nodoc
abstract class _$$_DeveloperCopyWith<$Res> implements $DeveloperCopyWith<$Res> {
  factory _$$_DeveloperCopyWith(
          _$_Developer value, $Res Function(_$_Developer) then) =
      __$$_DeveloperCopyWithImpl<$Res>;
  @override
  $Res call(
      {String developerId,
      String? name,
      int? targetTime,
      StorageFile? image,
      int? numOfMaterials,
      @DateTimeTimestampConverter() DateTime? createdAt,
      @DateTimeTimestampConverter() DateTime? updatedAt});

  @override
  $StorageFileCopyWith<$Res>? get image;
}

/// @nodoc
class __$$_DeveloperCopyWithImpl<$Res> extends _$DeveloperCopyWithImpl<$Res>
    implements _$$_DeveloperCopyWith<$Res> {
  __$$_DeveloperCopyWithImpl(
      _$_Developer _value, $Res Function(_$_Developer) _then)
      : super(_value, (v) => _then(v as _$_Developer));

  @override
  _$_Developer get _value => super._value as _$_Developer;

  @override
  $Res call({
    Object? developerId = freezed,
    Object? name = freezed,
    Object? targetTime = freezed,
    Object? image = freezed,
    Object? numOfMaterials = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_Developer(
      developerId: developerId == freezed
          ? _value.developerId
          : developerId // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      targetTime: targetTime == freezed
          ? _value.targetTime
          : targetTime // ignore: cast_nullable_to_non_nullable
              as int?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as StorageFile?,
      numOfMaterials: numOfMaterials == freezed
          ? _value.numOfMaterials
          : numOfMaterials // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Developer extends _Developer with DiagnosticableTreeMixin {
  const _$_Developer(
      {required this.developerId,
      this.name,
      this.targetTime = 60,
      this.image,
      this.numOfMaterials = 0,
      @DateTimeTimestampConverter() this.createdAt,
      @DateTimeTimestampConverter() this.updatedAt})
      : super._();

  factory _$_Developer.fromJson(Map<String, dynamic> json) =>
      _$$_DeveloperFromJson(json);

  @override
  final String developerId;
  @override
  final String? name;
  @override
  @JsonKey()
  final int? targetTime;
  @override
  final StorageFile? image;
  @override
  @JsonKey()
  final int? numOfMaterials;
  @override
  @DateTimeTimestampConverter()
  final DateTime? createdAt;
  @override
  @DateTimeTimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Developer(developerId: $developerId, name: $name, targetTime: $targetTime, image: $image, numOfMaterials: $numOfMaterials, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Developer'))
      ..add(DiagnosticsProperty('developerId', developerId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('targetTime', targetTime))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('numOfMaterials', numOfMaterials))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Developer &&
            const DeepCollectionEquality()
                .equals(other.developerId, developerId) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.targetTime, targetTime) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality()
                .equals(other.numOfMaterials, numOfMaterials) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(developerId),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(targetTime),
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(numOfMaterials),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_DeveloperCopyWith<_$_Developer> get copyWith =>
      __$$_DeveloperCopyWithImpl<_$_Developer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeveloperToJson(
      this,
    );
  }
}

abstract class _Developer extends Developer {
  const factory _Developer(
      {required final String developerId,
      final String? name,
      final int? targetTime,
      final StorageFile? image,
      final int? numOfMaterials,
      @DateTimeTimestampConverter() final DateTime? createdAt,
      @DateTimeTimestampConverter() final DateTime? updatedAt}) = _$_Developer;
  const _Developer._() : super._();

  factory _Developer.fromJson(Map<String, dynamic> json) =
      _$_Developer.fromJson;

  @override
  String get developerId;
  @override
  String? get name;
  @override
  int? get targetTime;
  @override
  StorageFile? get image;
  @override
  int? get numOfMaterials;
  @override
  @DateTimeTimestampConverter()
  DateTime? get createdAt;
  @override
  @DateTimeTimestampConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_DeveloperCopyWith<_$_Developer> get copyWith =>
      throw _privateConstructorUsedError;
}
