// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'measure_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeasureData {

 int get sequence; List<int> get rawData; List<double> get data780; List<double> get data850; int get batteryStatus; int get battery; int get accX; int get accY; int get accZ; int get gyroX; int get gyroY; int get gyroZ;
/// Create a copy of MeasureData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeasureDataCopyWith<MeasureData> get copyWith => _$MeasureDataCopyWithImpl<MeasureData>(this as MeasureData, _$identity);

  /// Serializes this MeasureData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeasureData&&(identical(other.sequence, sequence) || other.sequence == sequence)&&const DeepCollectionEquality().equals(other.rawData, rawData)&&const DeepCollectionEquality().equals(other.data780, data780)&&const DeepCollectionEquality().equals(other.data850, data850)&&(identical(other.batteryStatus, batteryStatus) || other.batteryStatus == batteryStatus)&&(identical(other.battery, battery) || other.battery == battery)&&(identical(other.accX, accX) || other.accX == accX)&&(identical(other.accY, accY) || other.accY == accY)&&(identical(other.accZ, accZ) || other.accZ == accZ)&&(identical(other.gyroX, gyroX) || other.gyroX == gyroX)&&(identical(other.gyroY, gyroY) || other.gyroY == gyroY)&&(identical(other.gyroZ, gyroZ) || other.gyroZ == gyroZ));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sequence,const DeepCollectionEquality().hash(rawData),const DeepCollectionEquality().hash(data780),const DeepCollectionEquality().hash(data850),batteryStatus,battery,accX,accY,accZ,gyroX,gyroY,gyroZ);

@override
String toString() {
  return 'MeasureData(sequence: $sequence, rawData: $rawData, data780: $data780, data850: $data850, batteryStatus: $batteryStatus, battery: $battery, accX: $accX, accY: $accY, accZ: $accZ, gyroX: $gyroX, gyroY: $gyroY, gyroZ: $gyroZ)';
}


}

/// @nodoc
abstract mixin class $MeasureDataCopyWith<$Res>  {
  factory $MeasureDataCopyWith(MeasureData value, $Res Function(MeasureData) _then) = _$MeasureDataCopyWithImpl;
@useResult
$Res call({
 int sequence, List<int> rawData, List<double> data780, List<double> data850, int batteryStatus, int battery, int accX, int accY, int accZ, int gyroX, int gyroY, int gyroZ
});




}
/// @nodoc
class _$MeasureDataCopyWithImpl<$Res>
    implements $MeasureDataCopyWith<$Res> {
  _$MeasureDataCopyWithImpl(this._self, this._then);

  final MeasureData _self;
  final $Res Function(MeasureData) _then;

/// Create a copy of MeasureData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sequence = null,Object? rawData = null,Object? data780 = null,Object? data850 = null,Object? batteryStatus = null,Object? battery = null,Object? accX = null,Object? accY = null,Object? accZ = null,Object? gyroX = null,Object? gyroY = null,Object? gyroZ = null,}) {
  return _then(_self.copyWith(
sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,rawData: null == rawData ? _self.rawData : rawData // ignore: cast_nullable_to_non_nullable
as List<int>,data780: null == data780 ? _self.data780 : data780 // ignore: cast_nullable_to_non_nullable
as List<double>,data850: null == data850 ? _self.data850 : data850 // ignore: cast_nullable_to_non_nullable
as List<double>,batteryStatus: null == batteryStatus ? _self.batteryStatus : batteryStatus // ignore: cast_nullable_to_non_nullable
as int,battery: null == battery ? _self.battery : battery // ignore: cast_nullable_to_non_nullable
as int,accX: null == accX ? _self.accX : accX // ignore: cast_nullable_to_non_nullable
as int,accY: null == accY ? _self.accY : accY // ignore: cast_nullable_to_non_nullable
as int,accZ: null == accZ ? _self.accZ : accZ // ignore: cast_nullable_to_non_nullable
as int,gyroX: null == gyroX ? _self.gyroX : gyroX // ignore: cast_nullable_to_non_nullable
as int,gyroY: null == gyroY ? _self.gyroY : gyroY // ignore: cast_nullable_to_non_nullable
as int,gyroZ: null == gyroZ ? _self.gyroZ : gyroZ // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MeasureData].
extension MeasureDataPatterns on MeasureData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeasureData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeasureData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeasureData value)  $default,){
final _that = this;
switch (_that) {
case _MeasureData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeasureData value)?  $default,){
final _that = this;
switch (_that) {
case _MeasureData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sequence,  List<int> rawData,  List<double> data780,  List<double> data850,  int batteryStatus,  int battery,  int accX,  int accY,  int accZ,  int gyroX,  int gyroY,  int gyroZ)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeasureData() when $default != null:
return $default(_that.sequence,_that.rawData,_that.data780,_that.data850,_that.batteryStatus,_that.battery,_that.accX,_that.accY,_that.accZ,_that.gyroX,_that.gyroY,_that.gyroZ);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sequence,  List<int> rawData,  List<double> data780,  List<double> data850,  int batteryStatus,  int battery,  int accX,  int accY,  int accZ,  int gyroX,  int gyroY,  int gyroZ)  $default,) {final _that = this;
switch (_that) {
case _MeasureData():
return $default(_that.sequence,_that.rawData,_that.data780,_that.data850,_that.batteryStatus,_that.battery,_that.accX,_that.accY,_that.accZ,_that.gyroX,_that.gyroY,_that.gyroZ);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sequence,  List<int> rawData,  List<double> data780,  List<double> data850,  int batteryStatus,  int battery,  int accX,  int accY,  int accZ,  int gyroX,  int gyroY,  int gyroZ)?  $default,) {final _that = this;
switch (_that) {
case _MeasureData() when $default != null:
return $default(_that.sequence,_that.rawData,_that.data780,_that.data850,_that.batteryStatus,_that.battery,_that.accX,_that.accY,_that.accZ,_that.gyroX,_that.gyroY,_that.gyroZ);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeasureData implements MeasureData {
  const _MeasureData({required this.sequence, required final  List<int> rawData, required final  List<double> data780, required final  List<double> data850, required this.batteryStatus, required this.battery, required this.accX, required this.accY, required this.accZ, required this.gyroX, required this.gyroY, required this.gyroZ}): _rawData = rawData,_data780 = data780,_data850 = data850;
  factory _MeasureData.fromJson(Map<String, dynamic> json) => _$MeasureDataFromJson(json);

@override final  int sequence;
 final  List<int> _rawData;
@override List<int> get rawData {
  if (_rawData is EqualUnmodifiableListView) return _rawData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rawData);
}

 final  List<double> _data780;
@override List<double> get data780 {
  if (_data780 is EqualUnmodifiableListView) return _data780;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data780);
}

 final  List<double> _data850;
@override List<double> get data850 {
  if (_data850 is EqualUnmodifiableListView) return _data850;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data850);
}

@override final  int batteryStatus;
@override final  int battery;
@override final  int accX;
@override final  int accY;
@override final  int accZ;
@override final  int gyroX;
@override final  int gyroY;
@override final  int gyroZ;

/// Create a copy of MeasureData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeasureDataCopyWith<_MeasureData> get copyWith => __$MeasureDataCopyWithImpl<_MeasureData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeasureDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeasureData&&(identical(other.sequence, sequence) || other.sequence == sequence)&&const DeepCollectionEquality().equals(other._rawData, _rawData)&&const DeepCollectionEquality().equals(other._data780, _data780)&&const DeepCollectionEquality().equals(other._data850, _data850)&&(identical(other.batteryStatus, batteryStatus) || other.batteryStatus == batteryStatus)&&(identical(other.battery, battery) || other.battery == battery)&&(identical(other.accX, accX) || other.accX == accX)&&(identical(other.accY, accY) || other.accY == accY)&&(identical(other.accZ, accZ) || other.accZ == accZ)&&(identical(other.gyroX, gyroX) || other.gyroX == gyroX)&&(identical(other.gyroY, gyroY) || other.gyroY == gyroY)&&(identical(other.gyroZ, gyroZ) || other.gyroZ == gyroZ));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sequence,const DeepCollectionEquality().hash(_rawData),const DeepCollectionEquality().hash(_data780),const DeepCollectionEquality().hash(_data850),batteryStatus,battery,accX,accY,accZ,gyroX,gyroY,gyroZ);

@override
String toString() {
  return 'MeasureData(sequence: $sequence, rawData: $rawData, data780: $data780, data850: $data850, batteryStatus: $batteryStatus, battery: $battery, accX: $accX, accY: $accY, accZ: $accZ, gyroX: $gyroX, gyroY: $gyroY, gyroZ: $gyroZ)';
}


}

/// @nodoc
abstract mixin class _$MeasureDataCopyWith<$Res> implements $MeasureDataCopyWith<$Res> {
  factory _$MeasureDataCopyWith(_MeasureData value, $Res Function(_MeasureData) _then) = __$MeasureDataCopyWithImpl;
@override @useResult
$Res call({
 int sequence, List<int> rawData, List<double> data780, List<double> data850, int batteryStatus, int battery, int accX, int accY, int accZ, int gyroX, int gyroY, int gyroZ
});




}
/// @nodoc
class __$MeasureDataCopyWithImpl<$Res>
    implements _$MeasureDataCopyWith<$Res> {
  __$MeasureDataCopyWithImpl(this._self, this._then);

  final _MeasureData _self;
  final $Res Function(_MeasureData) _then;

/// Create a copy of MeasureData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sequence = null,Object? rawData = null,Object? data780 = null,Object? data850 = null,Object? batteryStatus = null,Object? battery = null,Object? accX = null,Object? accY = null,Object? accZ = null,Object? gyroX = null,Object? gyroY = null,Object? gyroZ = null,}) {
  return _then(_MeasureData(
sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,rawData: null == rawData ? _self._rawData : rawData // ignore: cast_nullable_to_non_nullable
as List<int>,data780: null == data780 ? _self._data780 : data780 // ignore: cast_nullable_to_non_nullable
as List<double>,data850: null == data850 ? _self._data850 : data850 // ignore: cast_nullable_to_non_nullable
as List<double>,batteryStatus: null == batteryStatus ? _self.batteryStatus : batteryStatus // ignore: cast_nullable_to_non_nullable
as int,battery: null == battery ? _self.battery : battery // ignore: cast_nullable_to_non_nullable
as int,accX: null == accX ? _self.accX : accX // ignore: cast_nullable_to_non_nullable
as int,accY: null == accY ? _self.accY : accY // ignore: cast_nullable_to_non_nullable
as int,accZ: null == accZ ? _self.accZ : accZ // ignore: cast_nullable_to_non_nullable
as int,gyroX: null == gyroX ? _self.gyroX : gyroX // ignore: cast_nullable_to_non_nullable
as int,gyroY: null == gyroY ? _self.gyroY : gyroY // ignore: cast_nullable_to_non_nullable
as int,gyroZ: null == gyroZ ? _self.gyroZ : gyroZ // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
