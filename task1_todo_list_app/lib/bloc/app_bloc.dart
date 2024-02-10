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

    //App Initialization and Landing page Screen
    on<InitializationAppEvent>((_, emit) async{
      emit(
        InLandingPageViewAppState(
          isLoading: true,
          operation: initializing
        )
      );
      final username = await backend.getUsername();
      final userImageData = await backend.retrieveImageData();
      final retrievedTodos = await backend.getTodods();

      if(username != null || userImageData != null){
        emit(
          InLandingPageViewAppState()
        );

        emit(
          InTodoHomeViewAppState(retrievedTodos: retrievedTodos)
        );
      }

      else{ 
        emit(
          InLandingPageViewAppState()
        );
      }
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




    //This part deals with entering into the getUserData Screen
    on<GoToGetUserDataViewAppEvent>((_, emit) async{
      final inHomeState = state is InTodoHomeViewAppState;
      final inLandingPageState = state is InLandingPageViewAppState;
      
      if(inHomeState){
        final username = await backend.getUsername();
        final fileNameToDisplay = await backend.getfileNameToDisplay();
        
        emit(
          InGetUserDataViewAppState(
            username: username,
            fileNameToDisplay: fileNameToDisplay,
            inEditUserDetailsMode: true
          )
        );
      }

      else if(inLandingPageState){
        emit(
          InGetUserDataViewAppState()
        );
      }

      //More else if(s) can be added in the future if more screens 
      //(that leads to this place) are added.
    });




    //This part deals with the getuserdata view functionalities.
    on<GoToLandingPageAppEvent>((_, emit){
      emit(
        InLandingPageViewAppState()
      );
    });


    on<AddPhotoAppEvent>((_, emit) async{
      final currentState = state as InGetUserDataViewAppState;
      final initialFileNameToDisplay = currentState.fileNameToDisplay;
      final inEditUserDetailsMode = currentState.inEditUserDetailsMode;
      
      final imageData = await backend.pickImage();
      if(imageData == null){
        marach.log('imageData is null after picking image');
        return;
      }
      final imageFile = imageData.elementAt(0);
      final fileNameToDisplay = imageData.elementAt(1);

      emit(
        InGetUserDataViewAppState(
          fileNameToDisplay: fileNameToDisplay, 
          imageFile: imageFile,
          initialFileNameToDisplay: initialFileNameToDisplay,
          inEditUserDetailsMode: inEditUserDetailsMode
        )
      );
    });

    on<SaveUserDataAppEvent>((event, emit) async{
      final currentState = state as InGetUserDataViewAppState;
      final stateUsername = currentState.username?.trim();
      final eventUsername = event.username.trim();
      final imageFile = currentState.imageFile;
      final inEditUserDetailsMode = currentState.inEditUserDetailsMode ?? false;
      final fileNameToDisplay = currentState.fileNameToDisplay?.trim();
      //We want to get the new filename if the user did not tap on AddPhoto.
      final fileNameToDisplayWithoutTap = await backend.getfileNameToDisplay();

      final initialFileNameToDisplay = currentState.initialFileNameToDisplay?.trim();
      
      //A case where the user did select a new picture before clicking on Update
      final photoNotChanged = fileNameToDisplay == initialFileNameToDisplay
      //A case where the user did not select a new picture before clicking on Update
        || fileNameToDisplay == fileNameToDisplayWithoutTap;

      final usernameNotChanged = eventUsername == stateUsername ;
      final retrievedTodos = await backend.getTodods();

      if(inEditUserDetailsMode){

        if(eventUsername.isEmpty){
          emit(
            InGetUserDataViewAppState(
              error: usernameCannotBeEmpty,
              inEditUserDetailsMode: inEditUserDetailsMode
            )
          );
          return;
        }

        if(photoNotChanged && usernameNotChanged){
          emit(
            InTodoHomeViewAppState(
              retrievedTodos: retrievedTodos,
              error: noChange
            )
          );
        }

        else{
          if(!usernameNotChanged){
            await backend.setUsername(eventUsername);
          }

          if(!photoNotChanged){
            await backend.saveImageFile(imageFile!);
            await backend.setfileNameToDisplay(fileNameToDisplay!);
          }
          emit(
            InTodoHomeViewAppState(
              retrievedTodos: retrievedTodos,
              error: detailsChanged
            )
          );
        }
      }

      
      //We are not in edit or update mode
      else{
        if(eventUsername.isEmpty){
          emit(
            InGetUserDataViewAppState(
              username: eventUsername,
              fileNameToDisplay: fileNameToDisplay,
              error: usernameCannotBeEmpty
            )
          );
        }

        else if(eventUsername.isNotEmpty && fileNameToDisplay == null){
          emit(
            InGetUserDataViewAppState(
              username: eventUsername,
              fileNameToDisplay: fileNameToDisplay,
              alert: noDisplayPicture,
              alertContent: shouldContinueWithoutPicture
            )
          );
        }

        else{
          await backend.setUsername(eventUsername);
          await backend.saveImageFile(imageFile!);
          await backend.setfileNameToDisplay(fileNameToDisplay!);

          emit(
            InTodoHomeViewAppState(
              retrievedTodos: retrievedTodos,
            )
          );
        }
      }
    });


    on<SkipUserDataAppEvent> ((event, emit) async{
      final currentState = state as InGetUserDataViewAppState;
      final fileNameToDisplay = currentState.fileNameToDisplay?.trim();
      final imageFile = currentState.imageFile;
      final username = event.username;

      if(username.isEmpty || fileNameToDisplay == null){
        if(username.isNotEmpty){
          await backend.setUsername(username);
        }

        if(imageFile != null){
          await backend.saveImageFile(imageFile);
          await backend.setfileNameToDisplay(fileNameToDisplay!);
        }

        emit(
          InGetUserDataViewAppState(
            username: username,
            fileNameToDisplay: fileNameToDisplay,
            alert: noUsernameOrPicture,
            alertContent: shouldContinueWithoutUsernameOrPicture,
          )
        );
      }
    });
    



    //Here I combine transitions into the Todo Home from both the Get userData View
    //and the Add Todo View and conditionally check venue of entrance before performing operations
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
        final username = currentState.username;
        
        emit(
          InGetUserDataViewAppState(
            username: username,
            fileNameToDisplay: fileNameToDisplay,
          )
        );
        
        if(username != null && username.isNotEmpty){
          await backend.setUsername(username);
        }

        if(imageFile != null){
          await backend.saveImageFile(imageFile);
          await backend.setfileNameToDisplay(fileNameToDisplay!);
        }

        final retrievedTodos = await backend.getTodods();

        emit(
          InGetUserDataViewAppState(
            username: username,
            fileNameToDisplay: fileNameToDisplay, 
          )
        );

        emit(
          InTodoHomeViewAppState(
            retrievedTodos: retrievedTodos
          )
        );
      }

      //Any other views (that might be added in the future) leading to
      //Todo Home view can be added here with another else if condition.
    });



    
    //This part deals with functions on the Todo Home Screen and their implementation
    on<GoToAddTodoViewAppEvent>((_, emit){
      emit(
        InAddTodoViewAppState(isInUpdateMode: false)
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




    //This part deals with the functions in the AddTodo Screen and its implementattions
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
  }
}