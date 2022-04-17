import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panda/controller/order_controller.dart';
import 'package:panda/controller/user_controller.dart';
import 'package:panda/model/order.dart';
import 'package:panda/model/user.dart';
import 'package:panda/view/temp_page.dart';

class MyPage extends GetView<UserController> {
  OrderController o = Get.put(OrderController());
  UserController u = Get.find();

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Obx(
              () => Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          GestureDetector(
                            onTap: () => Get.to(() => TempPage()),
                            child: Container(
                              height: Get.height / 10,
                              child: Image.asset("assets/logo.png"),
                            ),
                          ),
                          SizedBox(height: 50),
                          Text("주문내역"),
                          SizedBox(height: 50),
                          Text("입금계좌: 신한은행 123-456-7890"),
                          SizedBox(height: 50),
                          DataTable(columns: getColumns(), rows: getRows()),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        onLoading: Center(
            child: Container(
                height: 50, width: 50, child: CircularProgressIndicator())));
  }

  List<DataColumn> getColumns() {
    List<String> masterColumns = [
      "번호",
      "이름",
      "상품명",
      "가격",
      "입금금액",
      "주소",
      "입금자명",
      "상태",
      "주문날짜"
    ];
    List<String> customerColumns = [
      "번호",
      "상품명",
      "가격",
      "입금금액",
      "주소",
      "입금자명",
      "상태",
      "주문날짜"
    ];
    List<String> nowColumns =
        u.principal.value.uid == "chRfCQk6Z0S857O88T2A6aAKOVg2"
            ? masterColumns
            : customerColumns;
    List<DataColumn> columns = [];
    for (var i = 0; i < nowColumns.length; i++) {
      columns.add(DataColumn(label: Text(nowColumns[i])));
    }
    print(columns.length);
    return columns;
  }

  List<DataRow> getRows() {
    List<Order> orders = o.orders;
    List<DataRow> rows = [];
    List<TextEditingController> list = [];
    for (var i = 0; i < orders.length; i++) {
      list.add(TextEditingController(text: orders[i].state));
    }
    for (var i = 0; i < orders.length; i++) {
      if (u.principal.value.uid == "chRfCQk6Z0S857O88T2A6aAKOVg2") {
        List<DataCell> cells = [];
        cells.add(DataCell(Text("$i")));
        cells.add(DataCell(Text(orders[i].user!.username!)));
        cells.add(DataCell(Text(orders[i].product!.name!)));
        cells.add(DataCell(Text(
            NumberFormat("###,###,### 원").format(orders[i].product!.price!))));
        cells.add(DataCell(
            Text(NumberFormat("###,###,### 원").format(orders[i].payPrice))));
        cells.add(DataCell(Text(orders[i].address!)));
        cells.add(DataCell(Text(orders[i].payName!)));
        cells.add(DataCell(Row(
          children: [
            Text(orders[i].state!),
            Container(
                width: 60,
                child: TextFormField(
                  controller: list[i],
                )),
            list[i].text == "배달완료"
                ? Container()
                : Container(
                    width: 30,
                    child: TextButton(
                        child: Text("v"),
                        onPressed: () async {
                          if (list[i].text.trim() == "배달완료") {
                            User user =
                                await u.findByIdForPoint(orders[i].user!.uid!);
                            await u.buyComplete(
                                orders[i].user!.uid!,
                                user.totalMoney! + orders[i].payPrice!,
                                user.point! +
                                    (orders[i].product!.price! * 0.05).ceil());
                          }
                          await o.updateState(orders[i].id!, list[i].text);
                        }),
                  )
          ],
        )));
        cells.add(DataCell(Text(orders[i].created!.toString())));
        rows.add(DataRow(cells: cells));
      } else {
        List<DataCell> cells = [];
        cells.add(DataCell(Text("$i")));
        cells.add(DataCell(Text(orders[i].product!.name!)));
        cells.add(DataCell(Text(
            NumberFormat("###,###,### 원").format(orders[i].product!.price!))));
        cells.add(DataCell(
            Text(NumberFormat("###,###,### 원").format(orders[i].payPrice))));
        cells.add(DataCell(Text(orders[i].address!)));
        cells.add(DataCell(Text(orders[i].payName!)));
        cells.add(DataCell(Text(orders[i].state!)));
        cells.add(DataCell(Text(orders[i].created!.toString())));
        rows.add(DataRow(cells: cells));
      }
    }
    return rows;
  }
}
