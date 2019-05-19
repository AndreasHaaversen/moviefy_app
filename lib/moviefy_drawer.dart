import 'package:flutter/material.dart';

import 'movie_search.dart';
import 'movie_list.dart';

class MoviefyDrawer extends Drawer {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Main menu'),
          ),
          ListTile(
            title: Text('Top Rated'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return MovieList();
                  }
                )
              );
            },
          ),
          ListTile(
            title: Text('Search'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Search();
                  }
                )
              );
            },
          ),
          ListTile(
            title: Text('Favorites'),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
