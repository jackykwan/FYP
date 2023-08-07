import 'package:client_fyp/bloc/api/api_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late final ApiBloc apiBloc;

void setBloc(BuildContext context) {
  apiBloc = BlocProvider.of<ApiBloc>(context);
}
