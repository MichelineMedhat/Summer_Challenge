import 'package:flutter/material.dart';

import '../models/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(1.2, 2.4),
            color: Colors.black12,
            blurRadius: .64,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: post.uri != null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Image.network(
                      post.uri,
                      fit: BoxFit.contain,
                      cacheWidth: 512,
                    ),
                  )
                : Container(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 32,
          ),
          Text(
            post.status,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 64),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 32,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width / 12),
                      child: Image.network(post.userProfilePicture),
                    ),
                  ) ??
                  Container(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@${post.username}',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 72),
                  ),
                  post.hashtag.isNotEmpty
                      ? Container(
                          width: MediaQuery.of(context).size.width / 8,
                          child: Text(
                            '#${post.hashtag}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 72,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
