import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/house.dart';



abstract class HouseState extends Equatable{
  const HouseState();

  @override
  List<Object> get props => [];
}


class AllHousesLoading extends HouseState {
  @override
  String toString() => 'AllHousesLoading';
}

class AllHousesLoaded extends HouseState {
  final List<House> houses;

  const AllHousesLoaded({@required this.houses});

  @override
  List<Object> get props => [houses];

  @override
  String toString() => 'AllHousesLoaded { Houses: $houses }';
}

class HouseAddSuccess extends HouseState {
  @override
  String toString() => 'HouseAddSuccess';
}

class HouseAddFailure extends HouseState {
  @override
  String toString() => 'HouseAddFailure';
}

class HouseDeleteSuccess extends HouseState {
  @override
  String toString() => 'HouseDeleteSuccess';
}

class HouseDeleteFailure extends HouseState {
  @override
  String toString() => 'HouseDeleteFailure';
}

class HouseUpdateSuccess extends HouseState {
  @override
  String toString() => 'HouseDeleteSuccess';
}

class HouseUpdateFailure extends HouseState {
  @override
  String toString() => 'HouseDeleteFailure';
}