part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeBlocEvent {}

class HomeInitialEvent extends HomeBlocEvent{}

class SearchTextBarClickedEvent extends HomeBlocEvent{}

class FliterButtonClickedEvent extends HomeBlocEvent{}

class ListItemClickedEvent extends HomeBlocEvent{}
