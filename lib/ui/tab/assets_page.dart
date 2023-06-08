import 'package:flutter_rich_ex/util/export.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: MyText('资产'),
    );
  }
}
