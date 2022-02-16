

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testgithub/bloc/event/ContributorsEvent.dart';
import 'package:testgithub/bloc/state/ContributorsState.dart';
import 'package:testgithub/model/ContributorsModel.dart';
import 'package:testgithub/repository/ContributorRepository.dart';
import 'package:rxdart/rxdart.dart';

class ContributorsBloc extends Bloc<ContributorsEvent, ContributorsState>{
  ContributorRepository contributorRepository;
  List<ContributorsModel> _data = [];

  ContributorsBloc({
    @required this.contributorRepository,
    }) : super(null);

  @override
  ContributorsState get initialState => ContributorsListInitialState();

  @override
  Stream<Transition<ContributorsEvent, ContributorsState>> transformEvents(
      Stream<ContributorsEvent> contributors, transitionFn) {
    return super.transformEvents(
        contributors.debounceTime(Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<ContributorsState> mapEventToState(ContributorsEvent contributorsEvent) async*{
    if (contributorsEvent is FetchContributorsEvent) {
      yield* _mapOrderSalesToStateInfiniteLoad();
    } else {
      yield ContributorsListErrorState(message: "error get data");
    }
  }

  int _currentLenght;

  Stream<ContributorsState> _mapOrderSalesToStateInfiniteLoad() async* {
    try {
      if (state is ContributorsListLoadedState) {
        _data = (state as ContributorsListLoadedState).list;
        if (_data.length > 0) {
          _currentLenght = (state as ContributorsListLoadedState).count;
        } else {
          _currentLenght = 0;
        }
      }

      if (_currentLenght != null) {
        yield ContributorsListLoadingMoreState();
      } else {
        yield ContributorsListLoadingState();
      }

      if (_currentLenght == null) {
        List<ContributorsModel> list = await contributorRepository
            .getContributorsList();
        if (list.isNotEmpty) {
          _data.addAll(list);
          if (_currentLenght != null) {
            _currentLenght += list.length;
          } else {
            _currentLenght = list.length;
          }
          ;
        } else {}
      }
      yield ContributorsListLoadedState(count: _currentLenght,
          list: _data);
    } catch (e) {
      yield ContributorsListErrorState(message: e.toString());
    }
  }


}