import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/employees.dart';
import '../services/HTTP_Service.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);
  static const String id = "detail_page";


  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var isLoading = false;
  List<Employee> items = [];
  late EmpResponse res;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }


  void _apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if(response != null){
      setState(() {
        isLoading = false;
        res = Network.parsePostList(response);
        items = res.data!;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Tiger Nixon (61)"),
            SizedBox(height: 5,),
            Text("320800\$"),
          ],
        ),
      ),
    );
  }

}
