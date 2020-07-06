import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/house.dart';

abstract class HouseEvent extends Equatable {
  const HouseEvent();
  @override
  List<Object> get props => [];
}

class LoadHouses extends HouseEvent {
  @override
  String toString() {
    return 'LoadPosts';
  }
}

class UpdateHouses extends HouseEvent {
  final List<House> houses;

  const UpdateHouses({@required this.houses});

  @override
  List<Object> get props => [houses];

  @override
  String toString() => 'UpdateHouses { houses: $houses }';
}

class AddHouse extends HouseEvent {
  final House house;
  final Uint8List data;
  final String extenison;

  const AddHouse({@required this.house, @required this.data, @required this.extenison});

  @override
  List<Object> get props => [house];

  @override
  String toString() => 'AddHouse { house: $house }';
}

class UpdateHouse extends HouseEvent {
  final House house;

  const UpdateHouse({@required this.house});

  @override
  List<Object> get props => [house];

  @override
  String toString() => 'UpdateHouse { house: $house }';
}

class DeleteHouse extends HouseEvent {
  final House house;

  const DeleteHouse({@required this.house});

  @override
  List<Object> get props => [house];

  @override
  String toString() => 'DeleteHouse { house: $house }';
}
