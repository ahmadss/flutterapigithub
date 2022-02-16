import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testgithub/bloc/bloc/bottom_navigation_bloc.dart';
import 'package:testgithub/bloc/event/bottom_navigation_event.dart';
import 'package:testgithub/bloc/state/bottom_navigation_state.dart';
import 'package:testgithub/model/ContributorsModel.dart';
import 'package:testgithub/ui/ContributorsPage.dart';
import 'package:testgithub/ui/RepositoriesListPage.dart';

class HomePage extends StatefulWidget{

  String action;
  List<ContributorsModel> _contributor;

//  UserToken userTokenObj;
  HomePage(this._contributor, this.action);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BottomNavigationBloc _navigationBloc;
  String _title = "Contributors";

  @override
  void initState() {
    super.initState();
    // _startUpdateService();

    _navigationBloc = new BottomNavigationBloc(
        contributorsModel: widget._contributor,
    );
    if (widget.action == "Start"){
      _navigationBloc.add(AppStarted());
    }


  }



  @override
  Widget build(BuildContext context) {
//    final BottomNavigationBloc bottomNavigationBloc = BlocProvider.of<BottomNavigationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),

      ),
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        cubit: _navigationBloc,
        builder: (BuildContext context, BottomNavigationState state) {
          if (state is PageLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ContributorsPageLoaded) {
            return ContributorsPage(state.list);
          }
          if (state is RepositoriesPageLoaded) {
            return RepositoriesListPage();
          }

          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
          cubit: _navigationBloc,
          builder: (BuildContext context, BottomNavigationState state) {
            return BottomNavigationBar(
              currentIndex: _navigationBloc.currentIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: const <BottomNavigationBarItem>[

                BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Colors.grey),
                  activeIcon: Icon(Icons.person, color: Colors.blue),
                  title: Text('Contributors'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.insert_drive_file, color: Colors.grey),
                  activeIcon: Icon(Icons.insert_drive_file, color: Colors.blue),
                  title: Text('Repositories'),
                ),

              ],
                type: BottomNavigationBarType.fixed,
            onTap: onTabTapped,
            );
          }
      ),
    );

  }




  void onTabTapped(int index) {
    setState(() {
      _navigationBloc.currentIndex = index;
      switch(index) {
        case 0: { _title = 'Contributor'; }
        break;
        case 1: { _title = 'Repositories'; }
        break;
      }
    });
    _navigationBloc.add(PageTapped(index: index));
  }


}