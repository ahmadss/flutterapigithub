import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:testgithub/bloc/bloc/RepositoriesBloc.dart';
import 'package:testgithub/bloc/state/RepositoriesState.dart';
import 'package:testgithub/bloc/event/RepositoriesEvent.dart';
import 'package:testgithub/model/RepositoriesModel.dart';
import 'package:testgithub/repository/RepositoriesRepository.dart';
import 'package:testgithub/utils/RepositoriesCard.dart';

class RepositoriesListPage extends StatefulWidget {
 

  RepositoriesListPage();

  @override
  _RepositoriesPageList createState() => _RepositoriesPageList();
}

class _RepositoriesPageList extends State<RepositoriesListPage> {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  RepositoriesBloc _repositoriesBloc;
  int _currentLenght;
  int start = 0;
  int hitung = 0;
  List<RepositoriesModel> _data = [];

  TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery = "Search Repository";
  bool isSelect = false;

  void _loadMoreData() {
    _repositoriesBloc.add(FetchRepositoriesLoadMoreEvent(
        searchQuery: _searchQuery.text,
        start: start,
        limit: 20));
  }

  @override
  void initState() {
    super.initState();
    // cekServer();

    _searchQuery = new TextEditingController();
    _repositoriesBloc =
        new RepositoriesBloc(RepositoriesRepositoryImpl());
    if(_searchQuery.text.length > 2) {
      _repositoriesBloc.add(FetchRepositoriesEvent(_searchQuery.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.grey[400],
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
      ),
      body: BlocBuilder<RepositoriesBloc, RepositoriesState>(
        cubit: _repositoriesBloc,
        builder: (context, state) {
          if (state is RepositoriesLoadedState ||
              state is RepositoriesLoadingMoreState) {
            if (state is RepositoriesLoadedState) {
              _data = state.repositoriesList;
              _currentLenght = state.count;
              if (_data.length == 0) {
                _currentLenght == null;
              }
              start += 1;

            }


            return _buildListRepositories(state);
          } else if (state is RepositoriesLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RepositoriesErrorState) {
            print("state error "+state.message.toString());
            return _buildListRepositories(state);
          } else {
            if(_searchQuery.text.length > 2) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(child: Align( alignment: Alignment.center, child:Text("masukan search minimal 3 karakter", style: TextStyle(color: Colors.black, fontSize: 16),),));
            }
          }
        },
      ),
    );
  }


  Widget _buildListRepositories(RepositoriesState state) {
    return LazyLoadScrollView(
      child: ListView(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: _data.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, i) {
                return InkWell(
                  onTap: () {
                    // navigateToHomePage(context, _data[i]);
                  },
                  child: RepositoriesCard(repositoriesModel: _data[i]),
                );

              }),
          // Loading indicator more load data
          (state is RepositoriesLoadingMoreState)
              ? Center(child: CircularProgressIndicator())
              : SizedBox(),
        ],
      ),
      onEndOfPage: _loadMoreData,
    );
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    if (!isSelect) {
      _clearSearchQuery();

      setState(() {
        _isSearching = false;
      });
    }
  }

  void _clearSearchQuery() {
    print("close search box");
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("Search query");
    });
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return new InkWell(
      onTap: () => scaffoldKey.currentState.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            const Text('Search Repository'),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search Repository...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),

    ];
  }

  main() async {
    // app.main();
  }

  void updateSearchQuery(String newQuery) {
    if (!isSelect) {
      setState(() {
        searchQuery = newQuery;
      });
      _data.clear();
      _currentLenght = 0;
      start = 0;

      if(_searchQuery.text.length > 2) {
        _repositoriesBloc.add(FetchRepositoriesEvent(
            _searchQuery.text));
      }
      print("search query " + newQuery);
    }
  }




  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
