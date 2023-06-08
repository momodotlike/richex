import 'package:flutter_rich_ex/util/export.dart';

class AiRulePage extends StatelessWidget {

  AiRulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.white,
      appBar: MyAppBar('理财规则'),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: MyInsets(horizontal: 15.w,top: 20.h),
      children: [
        MyText("""产品类型:
-定期理财产品，即购买后将锁仓至投资期限结束;
-活期理财产品，投资后可随时申赎。

支付方式:
钱包余额扣款

限额:
-不同的理财产品有不同的投资限额;
-个人购买额度需限于理财产品的最小投资额度和最大投资额度;
-当该理财产品实际购买额度达到总额度后，该理财产品将暂停购买。

赎回方式:
-定期理财期内不可赎回，到期后自动转入活期理财钱包余额中。
-活期理财可随时赎回，但实际收益将根据实际生息天数来计算。如持仓时间不满一个生息日将无法获得任何收益。

起息日期:
购买日的次日作为起息日，从起息日开始进入生息计算。
到期日期:
理财产品购买的期限+起息日，到期后自动转入活期理财钱包余额中。


        """,lineHeight: 1.7,maxLines: 100,),
      ],
    );
  }
}
