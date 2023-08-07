part of 'page_status_bloc.dart';

class PageStatusState extends Equatable {
  const PageStatusState(this.currentPage);

  final PageStatus currentPage;

  PageStatusState copyWith(PageStatus status) {
    return PageStatusState(status);
  }

  @override
  List<Object> get props => [currentPage];
}
