import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/house_repository.dart';
import '../../blocs/house_bloc/bloc.dart';

class HouseBloc extends Bloc<HouseEvent, HouseState> {
  StreamSubscription _houseSubscription;

  @override
  HouseState get initialState => AllHousesLoading();

  @override
  Stream<HouseState> mapEventToState(HouseEvent event) async* {
    if (event is LoadHouses) {
      yield* _mapLoadHousesEventToState();
    }
    else if (event is UpdateHouses){
      yield AllHousesLoaded(houses: event.houses);
    }
  }

  Stream<HouseState> _mapLoadHousesEventToState() async* {
    _houseSubscription?.cancel();
    _houseSubscription = HouseRepository.getAllHouses()
        .listen((houses) => add(UpdateHouses(houses: houses)));
  }
}
