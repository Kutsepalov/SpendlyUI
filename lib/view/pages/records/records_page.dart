import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:spendly_ui/core/clients/record_client.dart';
import 'package:spendly_ui/core/clients/response.dart';
import 'package:spendly_ui/models/enums/record_type.dart';
import 'package:spendly_ui/models/record.dart';
import 'package:spendly_ui/view/pages/home/navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:spendly_ui/view/util/money_formater.dart';
import 'package:spendly_ui/view/widgets/tile.dart';

class RecordsPage extends StatefulWidget
    implements NavigationBarItemProvidable {
  const RecordsPage({super.key});

  @override
  State<StatefulWidget> createState() => _RecordsPageState();

  @override
  BottomNavigationBarItem getNavigationBarItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'Records',
      backgroundColor: Colors.orange,
    );
  }
}

class _RecordsPageState extends State<RecordsPage> {
  final RecordClient _recordClient = RecordClient();
  List<Record> records = [];

  @override
  void initState() {
    super.initState();
    uploadData();
  }

  void uploadData() async {
    SpendlyResponse response = await _recordClient.getRecords();
    setState(() {
      records = (response.data as List<Record>).reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      floatingActionButton: FloatingActionButton(
        heroTag: "f",
        child: const Icon(Icons.refresh, color: Colors.white),
        onPressed: () {
          uploadData();
        },
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Tile(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade200,
              ),
              itemBuilder: _itemBuilder,
              itemCount: records.length,
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index == records.length) {
      return const CupertinoActivityIndicator();
    }
    Record record = records[index];
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: record.category.color,
        child: Icon(Icons.heart_broken, color: lighten(record.category.color)),
      ),
      title: Text(record.category.name),
      subtitle: _subtitle(record.account.name, null),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
              format(
                  record.currency,
                  RecordType.expense == record.type
                      ? -1 * record.amount
                      : record.amount),
              style: TextStyle(
                  color: (RecordType.expense == record.type
                      ? Colors.red
                      : Colors.green),
                  fontWeight: FontWeight.bold)),
          Text(DateFormat(DateFormat.ABBR_MONTH_DAY)
              .format(record.creationDatetime)),
        ],
      ),
    );
  }

  Widget _subtitle(String accountName, String? note) {
    List<Text> texts = [Text(accountName)];
    if (note != null) {
      texts.add(Text(
        '"$note"',
        style: const TextStyle(fontStyle: FontStyle.italic),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: texts,
    );
  }

  Color lighten(Color color) {
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + 0.45).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
