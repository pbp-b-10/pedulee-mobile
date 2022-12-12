import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:pedulee/widgets/drawer.dart';
import 'package:pedulee/widgets/appbar.dart';
import 'package:pedulee/apps/blood/models/blood_models.dart';
import 'fetch_blood.dart';

class HistoryBloodPage extends StatefulWidget{
  const HistoryBloodPage({super.key});

  @override
  State<HistoryBloodPage> createState() => _HistoryBloodPageState();
}
class _HistoryBloodPageState extends State<HistoryBloodPage>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(),
        drawer: drawerBuild(context),
        body: Stack(alignment: Alignment.center, children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/bg.jpg',
              fit: BoxFit.fill,
            ),
          ),
          FutureBuilder(
              future: fetchBlood(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return Column(
                      children: const [
                        Text(
                          "No clothes exist",
                          style:
                          TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: ListTile(
                                leading: const Icon(Linecons.t_shirt),
                                title: Text(
                                  "${snapshot.data![index].fields.clothModel}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "${snapshot.data![index].fields.material}, ${snapshot.data![index].fields.type}",
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                trailing: Text(
                                  snapshot.data![index].fields.date.toString().substring(0, 10),
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }
              })
        ]));
  }
}