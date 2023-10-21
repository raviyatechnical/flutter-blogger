import 'package:blogger/blogger.dart';
import 'package:flutter/material.dart';

class ShowComments {
  displayshowModalBottomSheet(
      BuildContext context, List<PostComments> comments) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return comments.length == 0
              ? const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text('No Comments'),
                )
              : Container(
                  height: 500,
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          title: Text(comments[index].content!),
                          subtitle: Text(comments[index].author!.displayName!),
                          leading: ClipRect(
                            child:
                                Image.network(comments[index].author!.image!),
                          ),
                        );
                      }),
                );
        });
  }
}
