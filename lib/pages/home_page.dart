import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:parshing_response/pages/detail_page.dart';
import '../model/employees.dart';
import '../services/HTTP_Service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

  // void _apiPostDelete(Employee post){
  //   Network.DEL( Network.API_DELETE + post.id.toString(), Network.paramsEmpty()).then((response) => {
  //     //LogService.i(response.toString()),
  //     _apiPostList(),
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Network"),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return itemHomePost(items[index]);
            },
          ),
          isLoading ? Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget itemHomePost(Employee post){
    return TextButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(),));
      },
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context){
                //_apiPostDelete(post);
              },
              flex: 3,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: "Delete",
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: [
              Text(post.employeeName!.toUpperCase()),
              SizedBox(height: 5,),
              Text(post.employeeName!),
            ],
          ),
        ),
      ),
    );
  }
}
