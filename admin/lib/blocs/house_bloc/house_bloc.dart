import 'dart:async';

import 'package:admin/models/house.dart';
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
    } else if (event is UpdateHouses) {
      yield AllHousesLoaded(houses: event.houses);
    } else if (event is AddHouse) {
      yield* _mapAddHouseEventToState(event.house);
    } else if (event is DeleteHouse) {
      yield* _mapDeleteEventToState(event.housename);
    } else if (event is UpdateHouse) {
      yield* _mapUpdateEventToState(event.house);
    }
  }

  Stream<HouseState> _mapLoadHousesEventToState() async* {
    _houseSubscription?.cancel();
    _houseSubscription = HouseRepository.getAllHouses()
        .listen((houses) => add(UpdateHouses(houses: houses)));
  }

  Stream<HouseState> _mapAddHouseEventToState(House house) async* {
    try {
      await HouseRepository.addHouse(house);
      add(LoadHouses());
    } catch (err) {
      yield HouseAddFailure();
      print('error adding house');
    }
  }

  Stream<HouseState> _mapDeleteEventToState(String housename) async* {
    try {
      await HouseRepository.deleteHouse(housename);
      add(LoadHouses());
    } catch (err) {
      yield HouseDeleteFailure();
      print('error deleting house');
    }
  }

 Stream<HouseState> _mapUpdateEventToState(House house) async*{
    try {
      await HouseRepository.updateHouse(house);
      add(LoadHouses());
    } catch (err) {
      yield HouseUpdateFailure();
      print('error updating house');
    }
 }
}
