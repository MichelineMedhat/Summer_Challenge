import 'package:admin/blocs/house_bloc/bloc.dart';
import 'package:admin/models/house.dart';
import 'package:admin/widgets/house_card.dart';
import 'package:admin/widgets/house_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HouseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HouseScreenState();
}

class _HouseScreenState extends State<HouseScreen> {
  HouseBloc houseBloc;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    houseBloc = BlocProvider.of<HouseBloc>(context)..add(LoadHouses());
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                'Houses',
                style: TextStyle(fontSize: 30),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width > 576
                        ? MediaQuery.of(context).size.width / 4
                        : MediaQuery.of(context).size.width / 8,
                    vertical: 16),
                child: BlocBuilder<HouseBloc, HouseState>(
                    builder: (context, state) {
                  if (state is AllHousesLoading) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      ),
                    );
                  }
                 else if (state is AllHousesLoaded) {
                    return GridView.count(
                      shrinkWrap: true,
                      childAspectRatio:
                          MediaQuery.of(context).size.width > 567 ? 0.77 : 0.66,
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 576 ? 2 : 1,
                      padding: const EdgeInsets.all(4.0),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      children: List<Widget>.generate(
                        state.houses.length,
                        (int index) => HouseCard(house:state. houses[index]),
                      ),
                    );
                  }else{
                    return Text("Error Loading Houses");
                  }
                }),
              ),
            ],
          ),
        ),
      ),
       floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 28,
        ),
        onPressed: _showMyDialog,
      ),
    );
  }

  Future<void> _showMyDialog() {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return HouseDialog(
            onPressed: () {
              House house = House(
                  playlistUri: HouseDialog.playlistUriEditingController.text,
                  houseName: HouseDialog.houseNameEditingController.text,
                  zoomLink: HouseDialog.zoomLinkEditingController.text,
                  zoomDate: HouseDialog.zoomDateEditingController.text,
                  releaseDate: HouseDialog.releaseDateEditingController.text,
                  roomId: HouseDialog.roomIdEditingController.text,
                  roomPassword: HouseDialog.roomPasswordEditingController.text);

              houseBloc.add((AddHouse(house: house, extenison: HouseDialog.extenstion, data: HouseDialog.data)));
              HouseDialog.data = null;
              Navigator.of(context).pop();
            },
          );
        });
  }
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
