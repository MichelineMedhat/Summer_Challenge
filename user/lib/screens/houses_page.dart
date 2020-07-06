import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/house_bloc/bloc.dart';
import '../widgets/house_card.dart';

class HousesPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => _HousesPageState();

}
class _HousesPageState extends State<HousesPage> {

  @override
  void initState() {
    BlocProvider.of<HouseBloc>(context).add(LoadHouses());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width > 576
                ? MediaQuery.of(context).size.width / 4
                : MediaQuery.of(context).size.width / 8,
            vertical: 16),
        child: BlocBuilder<HouseBloc, HouseState>(builder: (context, state) {
          if (state is AllHousesLoading) {
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              ),
            );
          } else if (state is AllHousesLoaded) {
            return GridView.count(
              shrinkWrap: true,
              childAspectRatio:
                  MediaQuery.of(context).size.width > 567 ? 0.9 : 0.8,
              crossAxisCount: MediaQuery.of(context).size.width > 576 ? 2 : 1,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: List<Widget>.generate(
                state.houses.length,
                (int index) => HouseCard(house: state.houses[index]),
              ),
            );
          } else {
            return Text("Error Loading Houses");
          }
        }),
      ),
    );
  }
}
