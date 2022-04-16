import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panda/controller/order_controller.dart';
import 'package:panda/controller/user_controller.dart';
import 'package:panda/model/order.dart';
import 'package:panda/view/temp_page.dart';

class MyPage extends StatelessWidget {
  OrderController o = Get.put(OrderController());
  UserController u = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
          child: Column(
              children: [
                GestureDetector(onTap:()=> Get.to(()=>TempPage()),
                  child: Container(height: Get.height/10,
                    child: Image.asset("assets/logo.png"),
                  ),
                ),
                DataTable(columns: getColumns(), rows: getRows()),
              ]),
      ),
    ),
        ));
  }

  List<DataColumn> getColumns() {
    List<String> masterColumns = ["번호", "이름", "상품명", "가격", "주소", "입금자명", "상태"];
    List<String> customerColumns = ["번호", "상품명", "가격", "주소", "입금자명", "상태"];
    List<String> nowColumns =
    u.principal.value.uid  == "chRfCQk6Z0S857O88T2A6aAKOVg2"
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
    for (var i = 0; i < orders.length; i++) {
      if (u.principal.value.uid  == "chRfCQk6Z0S857O88T2A6aAKOVg2") {
        List<DataCell> cells = [];
        cells.add(DataCell(Text("$i")));
        cells.add(DataCell(Text(orders[i].user!.username!)));
        cells.add(DataCell(Text(orders[i].product!.name!)));
        cells.add(DataCell(Text(orders[i].product!.price!)));
        cells.add(DataCell(Text(orders[i].address!)));
        cells.add(DataCell(Text(orders[i].payName!)));
        cells.add(DataCell(Text(orders[i].state!)));
        rows.add(DataRow(cells: cells));
      } else {
        List<DataCell> cells = [];
        cells.add(DataCell(Text("$i")));
        cells.add(DataCell(Text(orders[i].product!.name!)));
        cells.add(DataCell(Text(orders[i].product!.price!)));
        cells.add(DataCell(Text(orders[i].address!)));
        cells.add(DataCell(Text(orders[i].payName!)));
        cells.add(DataCell(Text(orders[i].state!)));
        rows.add(DataRow(cells: cells));
      }
    }
    return rows;
  }
}
