// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calibration_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalibrationData {

 int get progress; List<int> get ld780; List<int> get ld850; List<int> get pdStage1; List<int> get pdStage2;
/// Create a copy of CalibrationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalibrationDataCopyWith<CalibrationData> get copyWith => _$CalibrationDataCopyWithImpl<CalibrationData>(this as CalibrationData, _$identity);

  /// Serializes this CalibrationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalibrationData&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other.ld780, ld780)&&const DeepCollectionEquality().equals(other.ld850, ld850)&&const DeepCollectionEquality().equals(other.pdStage1, pdStage1)&&const DeepCollectionEquality().equals(other.pdStage2, pdStage2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,progress,const DeepCollectionEquality().hash(ld780),const DeepCollectionEquality().hash(ld850),const DeepCollectionEquality().hash(pdStage1),const DeepCollectionEquality().hash(pdStage2));

@override
String toString() {
  return 'CalibrationData(progress: $progress, ld780: $ld780, ld850: $ld850, pdStage1: $pdStage1, pdStage2: $pdStage2)';
}


}

/// @nodoc
abstract mixin class $CalibrationDataCopyWith<$Res>  {
  factory $CalibrationDataCopyWith(CalibrationData value, $Res Function(CalibrationData) _then) = _$CalibrationDataCopyWithImpl;
@useResult
$Res call({
 int progress, List<int> ld780, List<int> ld850, List<int> pdStage1, List<int> pdStage2
});




}
/// @nodoc
class _$CalibrationDataCopyWithImpl<$Res>
    implements $CalibrationDataCopyWith<$Res> {
  _$CalibrationDataCopyWithImpl(this._self, this._then);

  final CalibrationData _self;
  final $Res Function(CalibrationData) _then;

/// Create a copy of CalibrationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? progress = null,Object? ld780 = null,Object? ld850 = null,Object? pdStage1 = null,Object? pdStage2 = null,}) {
  return _then(_self.copyWith(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,ld780: null == ld780 ? _self.ld780 : ld780 // ignore: cast_nullable_to_non_nullable
as List<int>,ld850: null == ld850 ? _self.ld850 : ld850 // ignore: cast_nullable_to_non_nullable
as List<int>,pdStage1: null == pdStage1 ? _self.pdStage1 : pdStage1 // ignore: cast_nullable_to_non_nullable
as List<int>,pdStage2: null == pdStage2 ? _self.pdStage2 : pdStage2 // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [CalibrationData].
extension CalibrationDataPatterns on CalibrationData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalibrationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalibrationData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalibrationData value)  $default,){
final _that = this;
switch (_that) {
case _CalibrationData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalibrationData value)?  $default,){
final _that = this;
switch (_that) {
case _CalibrationData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int progress,  List<int> ld780,  List<int> ld850,  List<int> pdStage1,  List<int> pdStage2)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalibrationData() when $default != null:
return $default(_that.progress,_that.ld780,_that.ld850,_that.pdStage1,_that.pdStage2);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int progress,  List<int> ld780,  List<int> ld850,  List<int> pdStage1,  List<int> pdStage2)  $default,) {final _that = this;
switch (_that) {
case _CalibrationData():
return $default(_that.progress,_that.ld780,_that.ld850,_that.pdStage1,_that.pdStage2);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int progress,  List<int> ld780,  List<int> ld850,  List<int> pdStage1,  List<int> pdStage2)?  $default,) {final _that = this;
switch (_that) {
case _CalibrationData() when $default != null:
return $default(_that.progress,_that.ld780,_that.ld850,_that.pdStage1,_that.pdStage2);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalibrationData implements CalibrationData {
  const _CalibrationData({required this.progress, required final  List<int> ld780, required final  List<int> ld850, required final  List<int> pdStage1, required final  List<int> pdStage2}): _ld780 = ld780,_ld850 = ld850,_pdStage1 = pdStage1,_pdStage2 = pdStage2;
  factory _CalibrationData.fromJson(Map<String, dynamic> json) => _$CalibrationDataFromJson(json);

@override final  int progress;
 final  List<int> _ld780;
@override List<int> get ld780 {
  if (_ld780 is EqualUnmodifiableListView) return _ld780;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ld780);
}

 final  List<int> _ld850;
@override List<int> get ld850 {
  if (_ld850 is EqualUnmodifiableListView) return _ld850;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ld850);
}

 final  List<int> _pdStage1;
@override List<int> get pdStage1 {
  if (_pdStage1 is EqualUnmodifiableListView) return _pdStage1;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pdStage1);
}

 final  List<int> _pdStage2;
@override List<int> get pdStage2 {
  if (_pdStage2 is EqualUnmodifiableListView) return _pdStage2;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pdStage2);
}


/// Create a copy of CalibrationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalibrationDataCopyWith<_CalibrationData> get copyWith => __$CalibrationDataCopyWithImpl<_CalibrationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalibrationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalibrationData&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other._ld780, _ld780)&&const DeepCollectionEquality().equals(other._ld850, _ld850)&&const DeepCollectionEquality().equals(other._pdStage1, _pdStage1)&&const DeepCollectionEquality().equals(other._pdStage2, _pdStage2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,progress,const DeepCollectionEquality().hash(_ld780),const DeepCollectionEquality().hash(_ld850),const DeepCollectionEquality().hash(_pdStage1),const DeepCollectionEquality().hash(_pdStage2));

@override
String toString() {
  return 'CalibrationData(progress: $progress, ld780: $ld780, ld850: $ld850, pdStage1: $pdStage1, pdStage2: $pdStage2)';
}


}

/// @nodoc
abstract mixin class _$CalibrationDataCopyWith<$Res> implements $CalibrationDataCopyWith<$Res> {
  factory _$CalibrationDataCopyWith(_CalibrationData value, $Res Function(_CalibrationData) _then) = __$CalibrationDataCopyWithImpl;
@override @useResult
$Res call({
 int progress, List<int> ld780, List<int> ld850, List<int> pdStage1, List<int> pdStage2
});




}
/// @nodoc
class __$CalibrationDataCopyWithImpl<$Res>
    implements _$CalibrationDataCopyWith<$Res> {
  __$CalibrationDataCopyWithImpl(this._self, this._then);

  final _CalibrationData _self;
  final $Res Function(_CalibrationData) _then;

/// Create a copy of CalibrationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? progress = null,Object? ld780 = null,Object? ld850 = null,Object? pdStage1 = null,Object? pdStage2 = null,}) {
  return _then(_CalibrationData(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,ld780: null == ld780 ? _self._ld780 : ld780 // ignore: cast_nullable_to_non_nullable
as List<int>,ld850: null == ld850 ? _self._ld850 : ld850 // ignore: cast_nullable_to_non_nullable
as List<int>,pdStage1: null == pdStage1 ? _self._pdStage1 : pdStage1 // ignore: cast_nullable_to_non_nullable
as List<int>,pdStage2: null == pdStage2 ? _self._pdStage2 : pdStage2 // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
