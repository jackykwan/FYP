import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../helper/screen_mapper.dart';

part 'page_status_event.dart';
part 'page_status_state.dart';

class PageStatusBloc extends Bloc<PageStatusEvent, PageStatusState> {
  PageStatusBloc()
      : super(const PageStatusState(
          PageStatus.loginScreen,
        )) {
    on<PageStatusEvent>(_pageChangeEvent);
  }

  _pageChangeEvent(PageStatusEvent event, Emitter<PageStatusState> emit) async {
    emit(state.copyWith(event.page));
  }
}
