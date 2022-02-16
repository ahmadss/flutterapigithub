import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testgithub/bloc/bloc/ContributorsBloc.dart';
import 'package:testgithub/bloc/event/ContributorsEvent.dart';
import 'package:testgithub/bloc/state/ContributorsState.dart';
import 'package:testgithub/repository/ContributorRepository.dart';
import 'package:testgithub/ui/HomePage.dart';
import 'package:testgithub/ui/SplashScreenPage.dart';
import 'package:testgithub/utils/AuthenticationService.dart';

void main() {
  runApp(RepositoryProvider<AuthenticationService>(

    create: (context) {
      return FakeAuthenticationService();
    },
    // Injects the Authentication BLoC
    child: BlocProvider<ContributorsBloc>(
      create: (context) {
        return ContributorsBloc(contributorRepository: new ContributorRepositoryImpl())
          ..add(FetchContributorsEvent());
      },
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  // SQLiteDb sqLiteDb = new SQLiteDb();



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Github',
      theme: new ThemeData(
        primaryColor: Colors.blue[600],
        accentColor: Colors.blue[400],
      ),
      home: BlocBuilder<ContributorsBloc, ContributorsState>(
        builder: (context, state) {
          if (state is ContributorsListLoadedState) {
            return HomePage(state.list, "Start");
          }  else {
            return SplashScreenPage();
          }
        },
      ),
    );
  }


}


