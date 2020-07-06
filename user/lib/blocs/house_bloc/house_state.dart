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
