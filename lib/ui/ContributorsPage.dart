import 'package:flutter/material.dart';
import 'package:testgithub/model/ContributorsModel.dart';

class ContributorsPage extends StatefulWidget {
  static var tag = "/Dashboard";

  List<ContributorsModel> list;


  ContributorsPage(this.list);


  @override
  ContributorsPageState createState() => ContributorsPageState(this.list);
}

class ContributorsPageState extends State<ContributorsPage> {
  List<ContributorsModel> _list;


  ContributorsPageState(this._list);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("exhibition id"+widget.userLogin.absent.exhibition.id.toString());

  }

  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        body: ListView.builder(
          itemCount: _list.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(2),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.white,
              margin: EdgeInsets.all(5),
              elevation: 2,
              child: ListTile(
                onTap: () {
                  // toasty(context, _list[index].login);
                },


                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        _list[index].avatar_url),
                    radius: 40),
                title: Text(
                  _list[index].login,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: 4),
                  child:
                      Column(children: [
                        Text(_list[index].url, style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.grey)),
                        Text(_list[index].type, style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.grey)),
                      ],)

                ),
                trailing: Container(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.chevron_right, color: Colors.grey),
                ),
              ),
            );
          },
        ),
    );
  }
}


