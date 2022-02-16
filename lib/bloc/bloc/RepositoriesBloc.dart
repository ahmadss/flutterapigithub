import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:testgithub/bloc/state/RepositoriesState.dart';
import 'package:testgithub/bloc/event/RepositoriesEvent.dart';
import 'package:testgithub/model/RepositoriesModel.dart';
import 'package:testgithub/repository/RepositoriesRepository.dart';

class RepositoriesBloc extends Bloc<RepositoriesEvent, RepositoriesState>{
  RepositoriesRepository repositoriesRepository;
  List<RepositoriesModel> _data = [];
  int _currentLenght;
  bool _isLastPage;

  RepositoriesBloc(this.repositoriesRepository) : super(RepositoriesInitialState());


  @override
  RepositoriesState get initialState => RepositoriesInitialState();

  @override
  Stream<Transition<RepositoriesEvent, RepositoriesState>> transformEvents(
      Stream<RepositoriesEvent> events, transitionFn) {
    return super.transformEvents(
        events.debounceTime(Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<RepositoriesState> mapEventToState(RepositoriesEvent event) async*{
    if (event is FetchRepositoriesEvent) {
      _currentLenght = null;
      yield* _mapEventToStateInfiniteLoad(1,20, event.searchQuery);
    }else if (event is FetchRepositoriesLoadMoreEvent){
      _currentLenght = (state as RepositoriesLoadedState).count;
      yield* _mapEventToStateInfiniteLoad(event.start, event.limit, event.searchQuery);
    }
  }


  Stream<RepositoriesState> _mapEventToStateInfiniteLoad(int start, int limit, String searchQuery) async* {
    try {
      if (state is RepositoriesLoadedState) {
        _data = (state as RepositoriesLoadedState).repositoriesList;
        if (_data.length > 0){
          _currentLenght = (state as RepositoriesLoadedState).count;
        }else{
          _currentLenght = null;
        }

      }

      if (_currentLenght != null) {
        yield RepositoriesLoadingMoreState();
      } else {
        yield RepositoriesLoadingState();
      }

      if (_currentLenght == null || _isLastPage == null || !_isLastPage) {
          List<RepositoriesModel> repositoriesPartnerList = await repositoriesRepository.getRepositoriesList(searchQuery, start, limit);
          if (repositoriesPartnerList.isNotEmpty) {
            _data.addAll(repositoriesPartnerList);
            if (_currentLenght != null) {
              _currentLenght += repositoriesPartnerList.length;
            } else {
              _currentLenght = repositoriesPartnerList.length;
            }
            _isLastPage = false;
          } else {
            _isLastPage = true;
          }
      }
      yield RepositoriesLoadedState(repositoriesList: _data, count: _currentLenght);
    } catch (e) {
      yield RepositoriesErrorState(message: e.toString());
    }
  }


}