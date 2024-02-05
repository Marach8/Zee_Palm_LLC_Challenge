import 'package:bloc/bloc.dart';
import 'package:task1_todo_list_app/bloc/app_backend.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';
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
        const InLandingPageViewAppState(
          isLoading: true,
          operation: initializing
        )
      );
      final username = await backend.getUsername('username');
      final userImageData = await backend.retrieveImageData();
      final retrievedTodos = await backend.getTodods();

      if(username != null || userImageData != null){
        emit(
          const InLandingPageViewAppState(isLoading: false)
        );
        emit(
          InTodoHomeViewAppState(
            isLoading: false, 
            retrievedTodos: retrievedTodos,
            username: username, 
            imageBytes: userImageData
          )
        );
        return;
      }
      
      emit(
        const InLandingPageViewAppState(isLoading: false)
      );
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

        emit(
          InTodoHomeViewAppState(
            isLoading: false, 
            retrievedTodos: retrievedTodos,
            username: username, 
            imageBytes: userImageData
          )
        );
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
          InGetUserDataViewAppState(
            isLoading: false,
            username: username,
            fileNameToDisplay: fileNameToDisplay, 
          )
        );
        
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
          isInUpdateMode: false
        )
      );
    });

    on<SaveOrUpdateTodoAppEvent>((event, emit) async{
      final currentState = state as InAddTodoViewAppState;
      final title = event.titleController.text.trim();
      final dueDateTime = event.dueDateTimeController.text.trim();
      final content = event.contentController.text.trim();
      final fieldsNotEmpty = [title, dueDateTime, content]
        .every((field) => field.isNotEmpty);

      if(fieldsNotEmpty){
        //We want to Update Existing Todo
        if(currentState.isInUpdateMode ?? false){
          final newTodo = [title, dueDateTime, content];
          final oldTodo = currentState.initialTodo!;
          final theyAreEqual = newTodo.listsAreEqual(oldTodo);
          if(theyAreEqual){
            count++;
            emit(
              InAddTodoViewAppState(
                isLoading: false,
                error: noChange,
                counter: count
              )
            );
            
          }
          return;
        }

        event.titleController.clear();
        event.dueDateTimeController.clear();
        event.contentController.clear();

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
        return;
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

    on<DeleteTodoAppEvent>((event, emit) async{
      final currentState = state as InTodoHomeViewAppState;
      final username = currentState.username;
      final imageBytes = currentState.imageBytes;
      final indexToDelete = event.indexToDelete;
      final todoToDelete = todo+indexToDelete;

      await backend.deleteTodo(todoToDelete);
      final retrievedTodos = await backend.getTodods();

      emit(
        InTodoHomeViewAppState(
          isLoading: false,
          retrievedTodos: retrievedTodos,
          username: username, 
          imageBytes: imageBytes
        )
      );
    });

    on<UpdateTodoIsCompletedState>((event, emit) async{
      final currentState = state as InTodoHomeViewAppState;
      final username = currentState.username;
      final imageBytes = currentState.imageBytes;
      final indexToUpdate = event.indexToUpdate;
      final newTodo = event.newTodo;

      await backend.updateTodo(newTodo, indexToUpdate);
      final retrievedTodos = await backend.getTodods();

      emit(
        InTodoHomeViewAppState(
          isLoading: false,
          retrievedTodos: retrievedTodos,
          username: username, 
          imageBytes: imageBytes
        )
      );
    });

    on<StartTodoUpdateAppEvent>((event, emit) async{
      final indexToDelete = event.indexToUpdate;
      final todoToUpdate = await backend.getTodo(indexToDelete);
      
      emit(
        InAddTodoViewAppState(
          isLoading: false,
          isInUpdateMode: true,
          initialTodo: todoToUpdate
        )
      );
      todoToUpdate!.first = event.titleController.text;
      todoToUpdate[1] = event.dueDateTimeController.text;
      todoToUpdate[2] = event.contentController.text;
    });
  }
}