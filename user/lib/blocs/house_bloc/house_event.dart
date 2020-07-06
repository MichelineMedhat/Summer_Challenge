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
