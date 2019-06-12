import 'package:flutter/cupertino.dart';

class ProductListTab extends StatefulWidget {
  @override
  _ProductListTabState createState() {
    return _ProductListTabState();
  }
}

class _ProductListTabState extends State<ProductListTab> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: const <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Product List'),
        ),
      ],
    );
  }
}
