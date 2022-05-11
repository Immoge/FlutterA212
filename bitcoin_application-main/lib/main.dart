import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BitCoin Crypto Currency',
      home: Scaffold(
        appBar: AppBar(
          title: Text('BitCoin Crypto Currency'),
          backgroundColor: Colors.yellowAccent,
        ),
        body: const SingleChildScrollView(),
      ),
    );
  }
}

class MyBitCoinPage extends StatefulWidget {
  const MyBitCoinPage({Key? key}) : super(key: key);

  @override
  State<MyBitCoinPage> createState() => _MyBitCoinPageState();
}

class _MyBitCoinPageState extends State<MyBitCoinPage> {
  String selectName = "btc";
  Currency curCurrency = Currency("Not Available", 0.0, "Not Available");

  var cName, value, type;
  List<String> nameList = [
    "btc",
    "eth",
    "ltc",
    "bch",
    "bnb",
    "eos",
    "xrp",
    "xlm",
    "link",
    "dot",
    "yfi",
    "usd",
    "aed",
    "ars",
    "aud",
    "bdt",
    "bhd",
    "bmd",
    "brl",
    "cad",
    "chf",
    "clp",
    "cny",
    "czk",
    "dkk",
    "eur",
    "gbp",
    "hkd",
    "huf",
    "idr",
    "ils",
    "inr",
    "jpy",
    "krw",
    "kwd",
    "lkr",
    "mmk",
    "mxn",
    "myr",
    "ngn",
    "nok",
    "nzd",
    "php",
    "pkr",
    "pln",
    "rub",
    "sar",
    "sek",
    "sgd",
    "thb",
    "try",
    "twd",
    "uah",
    "vef",
    "vnd",
    "zar",
    "xdr",
    "xag",
    "xau",
    "bits",
    "sats"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          children: [
            const Text(
              "Please Select:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DropdownButton(
              itemHeight: 60,
              value: selectName,
              onChanged: (newValue) {
                setState(() {
                  selectName = newValue.toString();
                });
              },
              items: nameList.map((selectName) {
                return DropdownMenuItem(
                  child: Text(
                    selectName,
                  ),
                  value: selectName,
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: _loadCurrency,
                child: const Text("CONVERT"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.yellowAccent,
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ],
        )));
  }

  Future<void> _loadCurrency() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();

    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      cName = parsedData['rates'][selectName]['name'];
      value = parsedData['rates'][selectName]['value'];
      type = parsedData['rates'][selectName]['type'];
      curCurrency = Currency(cName, value, type);
    }
    progressDialog.dismiss();
  }
}

class Currency {
  var cName = "not available", value = 0.0, type = "not available";
  Currency(this.cName, this.value, this.type);
}

class CurrencyGrid extends StatefulWidget {
  final Currency curCurrency;
  const CurrencyGrid({Key? key, required this.curCurrency}) : super(key: key);
  @override
  State<CurrencyGrid> createState() => _CurrencyGridState();
}

class _CurrencyGridState extends State<CurrencyGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Currency Name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Icon(
                Icons.fact_check_rounded,
                size: 64,
              ),
              Text(widget.curCurrency.cName,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
            ],
          ),
          color: Colors.yellowAccent,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Value",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Icon(
                Icons.attach_money,
                size: 64,
              ),
              Text(widget.curCurrency.value.toString(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          color: Colors.yellowAccent,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Type",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Icon(
                Icons.loop_outlined,
                size: 64,
              ),
              Text(widget.curCurrency.type,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          color: Colors.yellowAccent,
        ),
      ],
    );
  }
}
