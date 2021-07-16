import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqlhttp/Model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final url = Uri.parse('http://localhost:5000');
  //Service _service = Service();

  int counter = 5;
  List<Product> productResultList = [];

  final url2 = Uri.parse('http://127.0.0.1:5000/api/products/getallproducts');

  List<PieChartSectionData> mainData = [];
  Future<List<Product>> callProduct() async {
    try {
      //print('34 deyim');
      final response = await http.get(url2);
      //print('buraya giriyor mu');
      //print(response.body);
      if (response.statusCode == 200) {
        var result = productFromJson(response.body);
        //counter = result.length;
        for (int i = 0; i < result.length; i++) {
          if (result[i].id == 3) {
            print('id si 3 olan column : ${result[i]}');
          }
          print(result[i].name);
          print('*******************************');
        }
        if (mounted) {
          setState(() {
            counter = result.length;
            productResultList = result;
          });
        }
        return result;
      } else {
        print(response.statusCode);
        // Error Page Konulsa İyi Olur
        return Future.error('Server Error');
      }
    } catch (e) {
      print(e.toString());
      //print('cath deyim');
      return Future.error('Error Fetching Data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doldur();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("MSSQL & HTTP"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: productResultList.isNotEmpty
            ? PageView(
                children: [
                  PieChart(
                    PieChartData(
                      sections: mainData,
                    ),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () async {
          productResultList = await callProduct();
          doldur();
          setState(() {});
        },
      ),
    );
  }

  void doldur() {
    mainData = [];
    for (int i = 0; i < productResultList.length; i++) {
      mainData += [
        PieChartSectionData(
          value: productResultList[i].stock.toDouble(),
          title: "${productResultList[i].id}",
          color: rastgeleRenkDon(),
        ),
      ];
    }
  }

  Color rastgeleRenkDon() {
    Random rnd = Random();
    int sayi = rnd.nextInt(4);
    switch (sayi) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.indigo;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.pink;
      default:
        return Colors.brown;
    }
  }
}
