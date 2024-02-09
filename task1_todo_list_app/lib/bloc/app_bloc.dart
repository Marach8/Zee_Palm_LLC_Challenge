import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:task1_todo_list_app/bloc/app_backend.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widgets/other_widgets/date_and_time_picker.dart';
import 'dart:developer' as marach show log;


class AppBloc extends Bloc<AppEvents, AppState>{
  AppBloc(): super(
    InLandingPageViewAppState()
  ){
    final backend = AppBackend();

    //App Initialization
    on<InitializationAppEvent>((_, emit) async{
      emit(
        InLandingPageViewAppState(
          isLoading: true,
          operation: initializing
        )
      );
      final username = await backend.getUsername(usernameString);
      final userImageData = await backend.retrieveImageData();
      final retrievedTodos = await backend.getTodods();

      if(username != null || userImageData != null){
        emit(
          InLandingPageViewAppState()
        );

        emit(
          InTodoHomeViewAppState(retrievedTodos: retrievedTodos)
        );
        return;
      }
      
      emit(
        InLandingPageViewAppState()
      );
    });
    
    //Landing page events and corresponding funtionalities
    on<GoToGetUserDataViewAppEvent>((_, emit){
      emit(
        InGetUserDataViewAppState()
      );
    });


    on<GetUserPermissionAppEvent>((_, emit){
      emit(
        InLandingPageViewAppState(
          alert: permission,
          alertContent: grantPermission
        )
      );
    });


    on<ShowAppPermissionReasonEvent>((_, emit){
      emit(
        InLandingPageViewAppState(
          error: fullPermissionReason
        )
      );
    });


    on<GoToLandingPageAppEvent>((_, emit){
      emit(
        InLandingPageViewAppState()
      );
    });


    //Get user data view events and corresponding funtionalities
    on<AddPhotoAppEvent>((_, emit) async{
      final imageData = await backend.pickImage();
      if(imageData == null){
        return;
      }
      final imageFile = imageData.elementAt(0);
      final fileNameToDisplay = imageData.elementAt(1);

      emit(
        InGetUserDataViewAppState(
          fileNameToDisplay: fileNameToDisplay, 
          imageFile: imageFile
        )
      );
    });

    on<SaveUserDataAppEvent>((event, emit){
      final currentState = state as InGetUserDataViewAppState;
      // final username = currentState.username;
      final username = event.username;
      final inSaveOperation = event.inSaveOperation ?? false;
      final fileNameToDisplay = currentState.fileNameToDisplay;
      final usernameIsEmpty = username.isEmpty;
      final noPicture = fileNameToDisplay == null;

      if(inSaveOperation){
        if(usernameIsEmpty){
          emit(
            InGetUserDataViewAppState(
              error: usernameCannotBeEmpty,
              fileNameToDisplay: fileNameToDisplay
            )
          );
          return;
        }
      
        if(noPicture){
          emit(
            InGetUserDataViewAppState(
              alert: noDisplayPicture,
              alertContent: shouldContinueWithoutPicture,
              username: username,
              fileNameToDisplay: fileNameToDisplay
            )
          );
        }
      }

      else{
        if(usernameIsEmpty || noPicture){
          emit(
            InGetUserDataViewAppState(
              alert: noUsernameOrPicture,
              alertContent: shouldContinueWithoutUsernameOrPicture,

            )
          );
        }
      }
    });


    // on<SkipUserDataAppEvent>((event, emit){
    //   final currentState = state as InGetUserDataViewAppState;
    //   // final username = currentState.username;
    //   final username = event.username;
    //   final fileNameToDisplay = currentState.fileNameToDisplay;
    // });

    
    //Here I combine transitions into the Todo Home from both the Get userData View
    //and the Add Todo View and conditionally check venue of entrance.
    on<GoToTodoHomeAppEvent>((event, emit) async{
      //A case whereby user is coming into the TodoHomeView from the AddTodoView
      if(state is InAddTodoViewAppState){
        final retrievedTodos = await backend.getTodods();

        emit(
          InTodoHomeViewAppState(retrievedTodos: retrievedTodos)
        );
      }

      //A case whereby a user is coming into the TodoHomeView from the GetUserDataView
      else if(state is InGetUserDataViewAppState){
        final currentState = state as InGetUserDataViewAppState;
        final imageFile = currentState.imageFile;
        final fileNameToDisplay = currentState.fileNameToDisplay;
        final username = event.username;
        
        emit(
          InGetUserDataViewAppState(
            isLoading: true,
            username: username,
            fileNameToDisplay: fileNameToDisplay,
          )
        );
        
        if(username != null && username.isNotEmpty){
          await backend.setUsername(username);
        }
        if(imageFile != null){
          await backend.saveImageFile(imageFile);
        }
        final retrievedTodos = await backend.getTodods();

        emit(
          InGetUserDataViewAppState(
            username: username,
            fileNameToDisplay: fileNameToDisplay, 
          )
        );
        
        emit(
          InTodoHomeViewAppState(retrievedTodos: retrievedTodos)
        );
      }

      //Any other views (that might be added in the future) leading to
      //Todo Home view can be added here with another else if condition.
    });


    on<GoToAddTodoViewAppEvent>((_, emit){
      emit(
        InAddTodoViewAppState(isInUpdateMode: false)
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
        //I want to Update Existing Todo
        if(currentState.isInUpdateMode ?? false){
          final oldTodo = currentState.initialTodo!;
          final newTodo = [...oldTodo];
          newTodo.replaceRange(0, 3, [title, dueDateTime, content]);
          
          final theyAreEqual = const DeepCollectionEquality()
            .equals(newTodo, oldTodo);

          //A case where the user did not actually change any of the fields
          if(theyAreEqual){
            emit(
              InAddTodoViewAppState(error: noChange)
            );
          }
          //A case where the user actually changed any of the fields
          else{
            emit(
              InAddTodoViewAppState(
                isLoading: true,
                operation: updating,
              )
            );

            final index = oldTodo.last;
            await backend.updateTodo(newTodo, index);

            emit(
              InAddTodoViewAppState(error: todoUpdated)
            );
          }

          final retrievedTodos = await backend.getTodods();
          emit(
            InTodoHomeViewAppState(retrievedTodos: retrievedTodos)
          );
          return;
        }


        emit(
          InAddTodoViewAppState(
            isLoading: true,
            operation: saving
          )
        );
        final todoDetails = [title, dueDateTime, content];
        await backend.setTodo(todoDetails);
        
        event.titleController.clear();
        event.dueDateTimeController.clear();
        event.contentController.clear();
        
        emit(
          InAddTodoViewAppState(
            alert: todoSaved,
            alertContent: addAgain
          )
        );
        return;
      }

      
      emit(
        InAddTodoViewAppState(
          error: fieldsEmpty,
          dueDateTime: dueDateTime
        )
      );
    });


    on<DeleteTodoAppEvent>((event, emit) async{
      final indexToDelete = event.indexToDelete;
      final todoToDelete = todoString+indexToDelete;

      final retrievedTodos = await backend.deleteTodo(todoToDelete)
      .then((_) async{
        return await backend.getTodods();
      });  

      emit(
        InTodoHomeViewAppState(retrievedTodos: retrievedTodos)
      );
    });


    on<UpdateTodoIsCompletedStateAppEvent>((event, emit) async{
      final indexToUpdate = event.indexToUpdate;
      final newTodo = event.newTodo;

      await backend.updateTodo(newTodo, indexToUpdate);
      final retrievedTodos = await backend.getTodods();

      emit(
        InTodoHomeViewAppState(retrievedTodos: retrievedTodos)
      );
    });


    on<StartTodoUpdateAppEvent>((event, emit) async{
      final indexToUpdate = event.indexToUpdate;
      final todoToUpdate = await backend.getTodo(indexToUpdate);
      
      emit(
        InAddTodoViewAppState(
          isInUpdateMode: true,
          initialTodo: todoToUpdate
        )
      );
    });


    on<ShowFullTodoDetailsAppEvent>((event, emit){
      final currentState = state as InTodoHomeViewAppState;
      final retrievedTodos = currentState.retrievedTodos;
      final indexToShow = event.indexToShow;

      emit(
        InTodoHomeViewAppState(
          retrievedTodos: retrievedTodos,
          indexToShow: indexToShow
        )
      );
    });


    on<ResetIndexToShowAppEvent>((_, emit){
      final currentState = state as InTodoHomeViewAppState;
      final retrievedTodos = currentState.retrievedTodos;
      
      emit(
        InTodoHomeViewAppState(retrievedTodos: retrievedTodos)
      );
    });


    on<GetDateAndTimeAppEvent>((event, emit) async{
      final currentState = state as InAddTodoViewAppState;
      final initialMode = currentState.isInUpdateMode;
      final initialTodo = currentState.initialTodo;
      final context = event.context;
      final dueDateTime = await selectedDueDateTime(context);

      emit(
        InAddTodoViewAppState(
          dueDateTime: dueDateTime,
          isInUpdateMode: initialMode,
          initialTodo: initialTodo
        )
      );
    });


    on<ZoomProfilePicAppEvent>((event, emit){
      final currentState = state as InTodoHomeViewAppState;
      final retrievedTodos = currentState.retrievedTodos;
      final isZoomed = event.isZoomed;

      emit(
        InTodoHomeViewAppState(
          retrievedTodos: retrievedTodos,
          isZoomed: isZoomed
        )
      );
    });
  }
}