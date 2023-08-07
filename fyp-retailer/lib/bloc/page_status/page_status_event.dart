part of 'page_status_bloc.dart';

class PageStatusEvent extends Equatable {
  const PageStatusEvent(this.page);
  final PageStatus page;
  @override
  List<Object> get props => [page];
}
