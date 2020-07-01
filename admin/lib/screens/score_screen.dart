import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/post_bloc/bloc.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../models/user.dart';
import '../widgets/post_widget.dart';

class ScoreScreen extends StatefulWidget {
  final User user;

  const ScoreScreen({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: 16),
          Container(
            width: 600,
            height: MediaQuery.of(context).size.height / 15,
            child: TextField(
              controller: _filterTextEditController,
              onSubmitted: (_) => _onFilterSubmitted(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top:4),
                hintText: 'Search posts ex @micheline or #lol',
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(30.0),
                  ),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Container(
              width:400,
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
                          return PostWidget(post: state.posts[index],);
                        });
                  } else {
                    return Text('Please Check your internet Connection');
                  }
                },
              )),
        ]),
      ),
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
