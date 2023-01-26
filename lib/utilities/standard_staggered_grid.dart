import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StandardStaggeredGrid extends StatefulWidget {
  StandardStaggeredGrid({@required this.itemCount, @required this.itemBuilder});
  final int itemCount;
  final Function itemBuilder;
  _StandardStaggeredGridState createState() => _StandardStaggeredGridState();
}

class _StandardStaggeredGridState extends State<StandardStaggeredGrid> {


  @override
  Widget build(BuildContext context) {

    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: widget.itemCount,
      itemBuilder: widget.itemBuilder,
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}
