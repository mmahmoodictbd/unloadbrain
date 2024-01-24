import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GridViewBuilder {
  GridView build() {
    return new GridView.count(
      primary: true,
      padding: const EdgeInsets.all(1.0),
      crossAxisCount: 2,
      childAspectRatio: 1,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        _buildGridCell(
            "Notifications",
            new IconButton(
                icon: new Icon(FontAwesomeIcons.bell),
                color: Colors.blueAccent,
                iconSize: 35,
                onPressed: () {
                  print("Pressed");
                })),
        _buildGridCell(
            "Heartbeat",
            new IconButton(
                icon: new Icon(FontAwesomeIcons.heartbeat),
                color: Colors.blueAccent,
                iconSize: 35,
                onPressed: () {
                  print("Pressed");
                })),
        _buildGridCell(
            "Manage Services",
            new IconButton(
                icon: new Icon(FontAwesomeIcons.servicestack),
                color: Colors.blueAccent,
                iconSize: 35,
                onPressed: () {
                  print("Pressed");
                })),
        _buildGridCell(
            "New Services",
            new IconButton(
                icon: new Icon(FontAwesomeIcons.plus),
                color: Colors.blueAccent,
                iconSize: 35,
                onPressed: () {
                  print("Pressed");
                })),
      ],
    );
  }

  Card _buildGridCell(name, iconButton) {
    return new Card(
        elevation: 1.5,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            iconButton,
            new Center(
              child: new Text(name),
            )
          ],
        ));
  }
}
