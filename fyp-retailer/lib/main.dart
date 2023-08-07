import 'package:client_fyp/helper/responsive_sizer/responsive_sizer.dart';
import 'package:client_fyp/helper/screen_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/api/api_bloc.dart';
import 'bloc/api/api_state.dart';
import 'bloc/page_status/page_status_bloc.dart';
import 'bloc/user_preference/user_preference_bloc.dart';
import 'components/screen_wrapper.dart';
import 'repositories/api/api_repository.dart';
import 'repositories/user_preference/user_preference_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Retailer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => ApiRepositoryImpl(),
          ),
          RepositoryProvider(
            create: (context) => UserPreferenceRepositoryImpl(),
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => UserPreferenceBloc(
                userPreferenceRepository:
                    RepositoryProvider.of<UserPreferenceRepositoryImpl>(
                  context,
                ),
              ),
            ),
            BlocProvider(
              create: (context) => PageStatusBloc(),
            ),
            BlocProvider(
              create: (context) => ApiBloc(
                userPreferenceRepository:
                    RepositoryProvider.of<UserPreferenceRepositoryImpl>(
                  context,
                ),
                apiRepository: RepositoryProvider.of<ApiRepositoryImpl>(
                  context,
                ),
              ),
            )
          ],
          child: Responsive(
            builder: (context) {
              return const Scaffold(
                resizeToAvoidBottomInset: false,
                body: SafeArea(
                  child: HomePage(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFirstLogin = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiBloc, ApiState>(
      listener: (context, apiState) {
        BlocProvider.of<PageStatusBloc>(context).add(
          const PageStatusEvent(PageStatus.inventoryScreen),
        );
        setState(() {
          isFirstLogin = false;
        });
      },
      listenWhen: (previous, current) =>
          previous.login.isLoading &&
          !current.login.isLoading &&
          isFirstLogin &&
          current.login.error == null,
      builder: (context, apiState) {
        return BlocConsumer<PageStatusBloc, PageStatusState>(
          listener: (context, pageState) {},
          builder: (context, pageState) {
            if (apiState.isLoggedIn) {
              return ScreenWrapper(
                name: dropdownStringConvertor[
                        pageStatusToDropdown(pageState.currentPage)] ??
                    "",
                child: screenMapper[pageState.currentPage]!,
              );
            } else {
              return screenMapper[pageState.currentPage]!;
            }
          },
        );
      },
    );
  }
}
