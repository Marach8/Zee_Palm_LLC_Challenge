import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task1_todo_list_app/bloc/app_backend.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';
import 'package:task1_todo_list_app/constants/strings.dart';


class AppBloc extends Bloc<AppEvents, AppState>{
  AppBloc(): super(
    const InLandingPageViewAppState(isLoading: false)
  ){
    final backend = AppBackend();
    //This count variable functions to just effect a change of state.
    int count = 0;

    on<InitializationAppEvent>((_, emit) async{
      emit(
        const InLandingPageViewAppState(isLoading: false)
      );
      final username = await backend.getUsername('username');
      final userImageData = await backend.retrieveImageData();
      final retrievedTodos = await backend.getTodods();

      if(username != null && userImageData != null){
        emit(
          InTodoHomeViewAppState(
            isLoading: false, 
            retrievedTodos: retrievedTodos,
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

    on<GoToTodoHomeAppEvent>((event, emit) async{
      //A case whereby we are coming into the TodoHomeView from the AddTodoView
      if(state is InAddTodoViewAppState){
        final username = await backend.getUsername('username');
        final userImageData = await backend.retrieveImageData();
        final retrievedTodos = await backend.getTodods();

        if(username != null && userImageData != null){
          emit(
            InTodoHomeViewAppState(
              isLoading: false, 
              retrievedTodos: retrievedTodos,
              username: username, 
              imageBytes: userImageData
            )
          );
        }
      }

      //A case whereby we are comming into the TodoHomeView from the GetUserDataView
      else if(state is InGetUserDataViewAppState){
        final currentState = state as InGetUserDataViewAppState;
        final imageFile = currentState.imageFile;
        final fileNameToDisplay = currentState.fileNameToDisplay;
        final username = event.username;
        if(username != null && username.isEmpty){
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
        if(username != null){
          await backend.setUsername(username);
        }
        if(imageFile != null){
          await backend.saveImageFile(imageFile);
        }
        final imageBytes = await imageFile?.readAsBytes();
        final retrievedTodos = await backend.getTodods();
        emit(
          InTodoHomeViewAppState(
            isLoading: false,
            retrievedTodos: retrievedTodos,
            username: username, 
            imageBytes: imageBytes
          )
        );
      }
    });

    on<GoToAddTodoViewAppEvent>((_, emit){
      emit(
        const InAddTodoViewAppState(
          isLoading: false,
          isInEditMode: false
        )
      );
    });

    on<SaveTodoAppEvent>((event, emit) async{
      final title = event.title.trim();
      final dueDateTime = event.dueDateTime.trim();
      final content = event.content.trim();
      final fieldsNotEmpty = [title, dueDateTime, content]
        .every((field) => field.isNotEmpty);

      if(fieldsNotEmpty){
        emit(
          const InAddTodoViewAppState(
            isLoading: true,
            operation: saving
          )
        );
        final todoDetails = [title, dueDateTime, content];
        await backend.setTodo(todoDetails);
        
        emit(
          const InAddTodoViewAppState(
            isLoading: false,
            alert: todoSaved,
            alertContent: addAgain
          )
        );
      }

      count++;
      emit(
        InAddTodoViewAppState(
          isLoading: false,
          error: fieldsEmpty,
          counter: count
        )
      );
    });
  }
}