import 'package:bloc/bloc.dart';
import 'package:task1_todo_list_app/bloc/app_backend.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';

class AppBloc extends Bloc<AppEvents, AppState>{
  AppBloc(): super(
    const InLandingPageViewAppState(isLoading: false)
  ){
    final backend = AppBackend();
    
    on<GoToGetUserDataViewAppEvent>((event, emit){
      emit(
        const InGetUserDataViewAppState(
          isLoading: false,
          username: null,
          fileNameToDisplay: null,
          imageFile: null
        )
      );
    });

    on<GoToLandingPageAppEvent>((event, emit){
      emit(
        const InLandingPageViewAppState(isLoading: false)
      );
    });

    on<AddPhotoAppEvent>((event, emit) async{
      final imageData = await backend.pickImage();
      if(imageData == null){
        return;
      }
      final imageFile = imageData.elementAt(0);
      final fileNameToDisplay = imageData.elementAt(1);

      emit(
        InGetUserDataViewAppState(
          isLoading: false, 
          username: null, 
          fileNameToDisplay: fileNameToDisplay, 
          imageFile: imageFile
        )
      );
    });
  }
}