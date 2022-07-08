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

Material _$MaterialFromJson(Map<String, dynamic> json) {
  return _Material.fromJson(json);
}

/// @nodoc
mixin _$Material {
  String get title => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MaterialCopyWith<Material> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialCopyWith<$Res> {
  factory $MaterialCopyWith(Material value, $Res Function(Material) then) =
      _$MaterialCopyWithImpl<$Res>;
  $Res call(
      {String title, DateTime createdAt, Category? category, String? imageUrl});
}

/// @nodoc
class _$MaterialCopyWithImpl<$Res> implements $MaterialCopyWith<$Res> {
  _$MaterialCopyWithImpl(this._value, this._then);

  final Material _value;
  // ignore: unused_field
  final $Res Function(Material) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? createdAt = freezed,
    Object? category = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_MaterialCopyWith<$Res> implements $MaterialCopyWith<$Res> {
  factory _$$_MaterialCopyWith(
          _$_Material value, $Res Function(_$_Material) then) =
      __$$_MaterialCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title, DateTime createdAt, Category? category, String? imageUrl});
}

/// @nodoc
class __$$_MaterialCopyWithImpl<$Res> extends _$MaterialCopyWithImpl<$Res>
    implements _$$_MaterialCopyWith<$Res> {
  __$$_MaterialCopyWithImpl(
      _$_Material _value, $Res Function(_$_Material) _then)
      : super(_value, (v) => _then(v as _$_Material));

  @override
  _$_Material get _value => super._value as _$_Material;

  @override
  $Res call({
    Object? title = freezed,
    Object? createdAt = freezed,
    Object? category = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$_Material(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Material with DiagnosticableTreeMixin implements _Material {
  const _$_Material(
      {required this.title,
      required this.createdAt,
      this.category,
      this.imageUrl});

  factory _$_Material.fromJson(Map<String, dynamic> json) =>
      _$$_MaterialFromJson(json);

  @override
  final String title;
  @override
  final DateTime createdAt;
  @override
  final Category? category;
  @override
  final String? imageUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Material(title: $title, createdAt: $createdAt, category: $category, imageUrl: $imageUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Material'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('imageUrl', imageUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Material &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(imageUrl));

  @JsonKey(ignore: true)
  @override
  _$$_MaterialCopyWith<_$_Material> get copyWith =>
      __$$_MaterialCopyWithImpl<_$_Material>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MaterialToJson(this);
  }
}

abstract class _Material implements Material {
  const factory _Material(
      {required final String title,
      required final DateTime createdAt,
      final Category? category,
      final String? imageUrl}) = _$_Material;

  factory _Material.fromJson(Map<String, dynamic> json) = _$_Material.fromJson;

  @override
  String get title;
  @override
  DateTime get createdAt;
  @override
  Category? get category;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_MaterialCopyWith<_$_Material> get copyWith =>
      throw _privateConstructorUsedError;
}
