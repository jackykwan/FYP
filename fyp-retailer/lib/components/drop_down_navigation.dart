import 'package:client_fyp/bloc/page_status/page_status_bloc.dart';
import 'package:client_fyp/helper/responsive_sizer/responsive_sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helper/screen_mapper.dart';

class DropdownNavigation extends StatefulWidget {
  const DropdownNavigation({super.key});

  @override
  State<DropdownNavigation> createState() => _DropdownNavigationState();
}

class _DropdownNavigationState extends State<DropdownNavigation> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<PageNavigator>(
        buttonSplashColor: Colors.transparent,
        buttonHighlightColor: Colors.transparent,
        customButton: Container(
          alignment: Alignment.centerLeft,
          width: 50.responsiveW,
          height: 50.responsiveH,
          child: Icon(
            Icons.list_outlined,
            size: 50.responsiveW,
          ),
        ),
        dropdownWidth: 150.responsiveW,
        underline: const SizedBox(),
        // Array list of items
        items: PageNavigator.values
            .where((element) => element.name != "unknown")
            .map((PageNavigator item) {
          return DropdownMenuItem(
            value: item,
            child: Text(dropdownStringConvertor[item]!),
          );
        }).toList(),

        onChanged: (PageNavigator? newValue) {
          BlocProvider.of<PageStatusBloc>(context).add(
            PageStatusEvent(
              dropdownConvertor[newValue]!,
            ),
          );
        },
      ),
    );
  }
}
