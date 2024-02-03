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

    on<InitializationAppEvent>((_, emit) async{
      emit(
        const InLandingPageViewAppState(isLoading: false)
      );
      final username = await backend.getUsername('username');
      final userImageData = await backend.retrieveFromLocalDirectory();

      if(username != null && userImageData != null){
        emit(
          InTodoHomeViewAppState(
            isLoading: false, 
            username: username, 
            imageBytes: userImageData
          )
        );
      }
    });
    
    on<GoToGetUserDataViewAppEvent>((_, emit){
      emit(
        const InGetUserDataViewAppState(
          isLoading: false,
        )
      );
    });

    on<GoToLandingPageAppEvent>((_, emit){
      emit(
        const InLandingPageViewAppState(isLoading: false)
      );
    });

    on<AddPhotoAppEvent>((_, emit) async{
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
      final fileNameToDisplay = currentState.fileNameToDisplay;
      final username = event.username;
      //This count variable functions to just effect a change of state.
      int count = 0;
      if(username.isEmpty){
        count ++;
        emit(
          InGetUserDataViewAppState(
            isLoading: false,
            error: usernameCannotBeEmpty,
            fileNameToDisplay: fileNameToDisplay,
            counter: count
          )
        );
        return;
      }
      
      emit(
        InGetUserDataViewAppState(
          isLoading: true,
          operation: saving,
          username: username,
          fileNameToDisplay: fileNameToDisplay, 
        )
      );
      await backend.setUsername(username);
      if(imageFile != null){
        await backend.saveToLocalDirectory(imageFile);
      }
      final imageBytes = await imageFile!.readAsBytes();
      emit(
        InTodoHomeViewAppState(
          isLoading: false, 
          username: username, 
          imageBytes: imageBytes
        )
      );
    });

    on<SkipUserDetailsAndGoToTodoHomeAppEvent>((_, emit){
      emit(
        const InTodoHomeViewAppState(isLoading: false,)
      );
    });
  }
}