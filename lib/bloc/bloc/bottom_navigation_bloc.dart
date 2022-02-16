import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:testgithub/model/ContributorsModel.dart';

import '../event/bottom_navigation_event.dart';
import '../state/bottom_navigation_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {

  List<ContributorsModel> contributorsModel;
  int currentIndex = 0;
  String action;


  BottomNavigationBloc({this.contributorsModel
  }) : super(null);

  @override
  BottomNavigationState get initialState => PageLoading();


  @override
  Stream<BottomNavigationState> mapEventToState(BottomNavigationEvent event) async* {
    if (event is AppStarted) {
      this.add(PageTapped(index: this.currentIndex));
    }

    if (event is AppContributors){
      this.add(PageTapped(index: 0));
    }
    if (event is AppRepositories){
      this.add(PageTapped(index: 1));
    }
    if (event is PageTapped) {
      this.currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: this.currentIndex);
      yield PageLoading();

      if (this.currentIndex == 1) {
        String data = await _getContributorsPageData();
        yield RepositoriesPageLoaded(data);

      }
      if (this.currentIndex == 0) {
        String data = await _getRepositoriesPageData();
        yield ContributorsPageLoaded(contributorsModel);
      }
    }
  }

  Future<String> _getRepositoriesPageData() async {
    String data = "Repositories";
    return data;
  }

  Future<String> _getContributorsPageData() async {
    String data = "Contributors";
    return data;
  }

}