import 'package:bloc/bloc.dart';
import 'package:task1_todo_list_app/bloc/app_backend.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';
import 'package:task1_todo_list_app/constants/strings.dart';

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
          fileNameToDisplay: fileNameToDisplay, 
          imageFile: imageFile
        )
      );
    });

    on<SaveUserDetailsAndGoToTodoHomeAppEvent>((event, emit) async{
      final currentState = state as InGetUserDataViewAppState;
      final imageFile = currentState.imageFile;
      final username = event.username;
      if(username.isEmpty){
        emit(
          const InGetUserDataViewAppState(
            isLoading: false,
            error: usernameCannotBeEmpty
          )
        );
        return;
      }
      
      emit(
        const InGetUserDataViewAppState(
          isLoading: true,  
          // fileNameToDisplay: fileNameToDisplay, 
          // imageFile: imageFile
        )
      );
      await backend.saveUsername(username);
      if(imageFile != null){
        await backend.saveToLocalDirectory(imageFile);
      }

      emit(
        InTodoHomeViewAppState(
          isLoading: false, 
          username: username, 
          imageFile: imageFile
        )
      );
    });
  }
}