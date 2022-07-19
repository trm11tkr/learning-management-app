// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'material.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MaterialData _$MaterialDataFromJson(Map<String, dynamic> json) {
  return _MaterialData.fromJson(json);
}

/// @nodoc
mixin _$MaterialData {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @DateTimeTimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  StorageFile? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MaterialDataCopyWith<MaterialData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialDataCopyWith<$Res> {
  factory $MaterialDataCopyWith(
          MaterialData value, $Res Function(MaterialData) then) =
      _$MaterialDataCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String title,
      @DateTimeTimestampConverter() DateTime createdAt,
      StorageFile? image});

  $StorageFileCopyWith<$Res>? get image;
}

/// @nodoc
class _$MaterialDataCopyWithImpl<$Res> implements $MaterialDataCopyWith<$Res> {
  _$MaterialDataCopyWithImpl(this._value, this._then);

  final MaterialData _value;
  // ignore: unused_field
  final $Res Function(MaterialData) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? createdAt = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as StorageFile?,
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
abstract class _$$_MaterialDataCopyWith<$Res>
    implements $MaterialDataCopyWith<$Res> {
  factory _$$_MaterialDataCopyWith(
          _$_MaterialData value, $Res Function(_$_MaterialData) then) =
      __$$_MaterialDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      @DateTimeTimestampConverter() DateTime createdAt,
      StorageFile? image});

  @override
  $StorageFileCopyWith<$Res>? get image;
}

/// @nodoc
class __$$_MaterialDataCopyWithImpl<$Res>
    extends _$MaterialDataCopyWithImpl<$Res>
    implements _$$_MaterialDataCopyWith<$Res> {
  __$$_MaterialDataCopyWithImpl(
      _$_MaterialData _value, $Res Function(_$_MaterialData) _then)
      : super(_value, (v) => _then(v as _$_MaterialData));

  @override
  _$_MaterialData get _value => super._value as _$_MaterialData;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? createdAt = freezed,
    Object? image = freezed,
  }) {
    return _then(_$_MaterialData(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as StorageFile?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MaterialData extends _MaterialData with DiagnosticableTreeMixin {
  const _$_MaterialData(
      {required this.id,
      required this.title,
      @DateTimeTimestampConverter() required this.createdAt,
      this.image})
      : super._();

  factory _$_MaterialData.fromJson(Map<String, dynamic> json) =>
      _$$_MaterialDataFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @DateTimeTimestampConverter()
  final DateTime createdAt;
  @override
  final StorageFile? image;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MaterialData(id: $id, title: $title, createdAt: $createdAt, image: $image)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MaterialData'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('image', image));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MaterialData &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.image, image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(image));

  @JsonKey(ignore: true)
  @override
  _$$_MaterialDataCopyWith<_$_MaterialData> get copyWith =>
      __$$_MaterialDataCopyWithImpl<_$_MaterialData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MaterialDataToJson(
      this,
    );
  }
}

abstract class _MaterialData extends MaterialData {
  const factory _MaterialData(
      {required final String id,
      required final String title,
      @DateTimeTimestampConverter() required final DateTime createdAt,
      final StorageFile? image}) = _$_MaterialData;
  const _MaterialData._() : super._();

  factory _MaterialData.fromJson(Map<String, dynamic> json) =
      _$_MaterialData.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @DateTimeTimestampConverter()
  DateTime get createdAt;
  @override
  StorageFile? get image;
  @override
  @JsonKey(ignore: true)
  _$$_MaterialDataCopyWith<_$_MaterialData> get copyWith =>
      throw _privateConstructorUsedError;
}
