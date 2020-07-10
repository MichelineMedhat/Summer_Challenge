import 'package:admin/blocs/user_bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UsersPageState();
}

class _UsersPageState extends State<StatefulWidget> {
  final ScrollController scrollController = ScrollController();
  TextEditingController _filterTextEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(LoadUsers(""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.width > 576
                        ? MediaQuery.of(context).size.width / 96
                        : MediaQuery.of(context).size.width / 20),
                Text(
                  'Users',
                  style: TextStyle(fontSize: 50),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width > 576
                        ? MediaQuery.of(context).size.width / 96
                        : MediaQuery.of(context).size.width / 20),
                Container(
                  width: 600,
                  height: MediaQuery.of(context).size.height / 15,
                  child: TextField(
                    controller: _filterTextEditController,
                    onSubmitted: (keyword) => BlocProvider.of<UserBloc>(context)
                        .add(LoadUsers(keyword)),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 4),
                      hintText: 'Search Users',
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(30.0),
                        ),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width > 576
                        ? MediaQuery.of(context).size.width / 96
                        : MediaQuery.of(context).size.width / 20),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UsersLoadInProgress) {
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [CircularProgressIndicator()],
                        ),
                      );
                    } else if (state is UsersLoadSuccess) {
                      return Container(
                        width: MediaQuery.of(context).size.width > 576
                            ? MediaQuery.of(context).size.width / 3
                            : MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            padding: EdgeInsets.all(16),
                            scrollDirection: Axis.vertical,
                            itemCount: state.users.length,
                            controller: scrollController,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ListTile(
                                      mouseCursor: MouseCursor.uncontrolled,
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.white70,
                                        radius: 30,
                                        backgroundImage:
                                            state.users[index].profilePicture !=
                                                    null
                                                ? NetworkImage(
                                                    state.users[index]
                                                        .profilePicture,
                                                  )
                                                : AssetImage("assets/pp.png"),
                                      ),
                                      title: Text(
                                        state.users[index].username,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        "Number: ${state.users[index].phoneNumber}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      trailing: InkWell(
                                        child: Icon(Icons.delete),
                                        onTap: () {
                                          BlocProvider.of<UserBloc>(context)
                                              .add(DeleteUser(
                                                  user: state.users[index]));
                                        },
                                      ),
                                    ),
                                  ));
                            }),
                      );
                    } else {
                      return Text((state as UsersLoadFailure).message);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
