import 'package:flutter/material.dart';
import 'package:testgithub/model/RepositoriesModel.dart';

class RepositoriesCard extends StatelessWidget{
  final RepositoriesModel repositoriesModel;
  RepositoriesCard({this.repositoriesModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(repositoriesModel.name, style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Column(children: [
              SizedBox(height: 5,),
              Align( alignment: Alignment.topLeft, child :Text(repositoriesModel.url, style: TextStyle(color: Colors.black),)),
              SizedBox(height: 5,),
              Align( alignment: Alignment.topLeft, child :Text(repositoriesModel.owner.login, style: TextStyle(color: Colors.black),))
            ],),
          )
        ],
      ),
    );
  }

}