import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/post_bloc/bloc.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../models/user.dart';
import '../widgets/post_widget.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  TextEditingController _filterTextEditController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  PostBloc postBloc;

  @override
  void initState() {
    super.initState();
    _filterTextEditController.addListener(_onFilerChanged);
    postBloc = BlocProvider.of<PostBloc>(context)..add(LoadPosts());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: MediaQuery.of(context).size.width / 1.9,
          height: MediaQuery.of(context).size.height / 18,
          child: TextField(
            controller: _filterTextEditController,
            onSubmitted: (_) => _onFilterSubmitted(),
            decoration: InputDecoration(
              hintText: 'Search posts',
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
          height: MediaQuery.of(context).size.height / 16,
        ),
        Container(
            width: MediaQuery.of(context).size.width > 576
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width,
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is AllPostsLoading ||
                    state is PostUploading ||
                    state is PostUploaded) {
                  return Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      ),
                    ),
                  );
                } else if (state is AllPostsLoaded) {
                  return ListView.builder(
                      itemCount: state.posts.length,
                      scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return PostWidget(post: state.posts[index]);
                      });
                } else {
                  return Text('Please Check your internet Connection');
                }
              },
            )),
      ]),
    );
  }

  void _onFilterSubmitted() {
    postBloc.add(FilterChanged(filter: _filterTextEditController.text));
  }

  void _onFilerChanged() {
    if (_filterTextEditController.text == '') {
      BlocProvider.of<PostBloc>(context).add(LoadPosts());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _filterTextEditController.dispose();
    super.dispose();
  }
}
