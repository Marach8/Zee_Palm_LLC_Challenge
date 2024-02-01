import 'package:bloc/bloc.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';

class AppBloc extends Bloc<AppEvents, AppState>{
  AppBloc(): super(
    const InLandingPageViewAppState(
      isLoading: false,
      inStep1: true
    )
  ){
    on<GoToGetUserDataViewAppEvent>((event, emit){
      emit(
        const InGetUserDataViewAppState(isLoading: false)
      );
    });
  }
}