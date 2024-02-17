import 'package:bloc/bloc.dart';
import 'package:task1_todo_list_app/src/functions/app_backend.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_events.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_state.dart';
import 'package:task1_todo_list_app/src/constants/strings.dart';
import 'package:task1_todo_list_app/src/functions/date_and_time_picker.dart';

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
      
      final userDetails = await backend.getUserDetails();
      final userExists = userDetails?.userExists;

      if(userExists ?? false){
        emit(
          InLandingPageViewAppState()
        );

        emit(
          InTodoHomeViewAppState()
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
        final detailsOfUser = await backend.getUserDetails();
        final username = detailsOfUser?.username;
        final imageFileName = detailsOfUser?.imageFileName;
        
        emit(
          InGetUserDataViewAppState(
            username: username,
            fileNameToDisplay: imageFileName,
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
        return;
      }

      //We are sure about the contents of imageBytes and imageFileName.
      final imageBytes = imageData.elementAt(0);
      final imageFileName = imageData.elementAt(1);

      emit(
        InGetUserDataViewAppState(
          fileNameToDisplay: imageFileName, 
          imageBytes: imageBytes,
          initialFileNameToDisplay: initialFileNameToDisplay,
          inEditUserDetailsMode: inEditUserDetailsMode
        )
      );
    });

    on<SaveUserDataAppEvent>((event, emit) async{
      final currentState = state as InGetUserDataViewAppState;
      final stateUsername = currentState.username?.trim();
      final eventUsername = event.username.trim();
      final imageBytes = currentState.imageBytes;
      final inEditUserDetailsMode = currentState.inEditUserDetailsMode ?? false;
      final fileNameToDisplay = currentState.fileNameToDisplay?.trim();

      //We want to get the new filename if the user did not tap on AddPhoto.
      final detailsOfUser = await backend.getUserDetails();
      final fileNameToDisplayWithoutTap = detailsOfUser?.imageFileName;

      //This is the filename that is already in the current state.
      final initialFileNameToDisplay = currentState.initialFileNameToDisplay?.trim();
      
      //A case where the user did select picture before clicking on Update
      final photoNotChanged = fileNameToDisplay == initialFileNameToDisplay
      //A case where the user did not select a new picture before clicking on Update
        || fileNameToDisplay == fileNameToDisplayWithoutTap;

      final usernameNotChanged = eventUsername == stateUsername ;

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
            InTodoHomeViewAppState(error: noChange)
          );
        }

        else{
          if(!usernameNotChanged){
            await backend.updateUserDetails(
              update: event.username, 
              fieldToUpdate: usernameField
            );
          }

          if(!photoNotChanged){
            await backend.updateUserDetails(
              update: imageBytes, 
              fieldToUpdate: imageDataField
            );
            await backend.updateUserDetails(
              update: fileNameToDisplay, 
              fieldToUpdate: imageFileNameField
            );
          }

          emit(
            InTodoHomeViewAppState(error: detailsChanged)
          );
        }
      }

      
      //We are not updating user details. A new user is registering.
      else{
        if(eventUsername.isEmpty){
          emit(
            InGetUserDataViewAppState(
              username: eventUsername,
              fileNameToDisplay: fileNameToDisplay,
              error: usernameCannotBeEmptyWithSkip
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
          await backend.createUserDetails(
            userExists: true,
            imageData: imageBytes,
            username: eventUsername,
            imageFileName: fileNameToDisplay
          );
          
          emit(
            InTodoHomeViewAppState()
          );
        }
      }
    });


    on<SkipUserDataAppEvent> ((event, emit) async{
      final currentState = state as InGetUserDataViewAppState;
      final fileNameToDisplay = currentState.fileNameToDisplay?.trim();
      final imageBytes = currentState.imageBytes;
      final username = event.username;

      emit(
        InGetUserDataViewAppState(
          username: username,
          fileNameToDisplay: fileNameToDisplay,
          imageBytes: imageBytes,
          alert: noUsernameOrPicture,
          alertContent: shouldContinueWithoutUsernameOrPicture,
        )
      );
    });
    



    //Here I combine transitions into the Todo Home from both the Get userData View
    //and the Add Todo View and conditionally check venue of entrance before performing operations
    on<GoToTodoHomeAppEvent>((event, emit) async{
      //A case whereby user is coming into the TodoHomeView from the AddTodoView
      if(state is InAddTodoViewAppState){
        emit(
          InTodoHomeViewAppState()
        );
      }

      //A case whereby a user is coming into the TodoHomeView from the GetUserDataView
      else if(state is InGetUserDataViewAppState){
        final currentState = state as InGetUserDataViewAppState;
        final imageBytes = currentState.imageBytes;
        final fileNameToDisplay = currentState.fileNameToDisplay;
        final username = currentState.username;
        
        emit(
          InGetUserDataViewAppState(
            isLoading: true,
            username: username,
            fileNameToDisplay: fileNameToDisplay,
          )
        );
        
        await backend.createUserDetails(
          userExists: true,
          imageData: imageBytes,
          imageFileName: fileNameToDisplay,
          username: username
        );

        emit(
          InGetUserDataViewAppState(
            username: username,
            fileNameToDisplay: fileNameToDisplay, 
          )
        );

        emit(
          InTodoHomeViewAppState()
        );
      }

      //Any other views (that might be added in the future) leading to
      //Todo Home view can be added here with another else if condition.
    });



    
    //This part deals with functions in the Todo Home Screen and their implementation
    on<GoToAddTodoViewAppEvent>((_, emit){
      emit(
        InAddTodoViewAppState(isInUpdateMode: false)
      );
    });


    on<WantToGoToGetUserDataViewAppEvent>((_, emit){
      emit(
        InTodoHomeViewAppState(
          alert: updateDetails,
          alertContent: wantToUpdateDetails,
          wantsToUpdateUserDetails: true
        )
      );
    });


    on<DeleteTodoAppEvent>((event, emit) async{

      final keyToDelete = event.keyToDelete;
      await backend.deleteTodo(keyId: keyToDelete);
      
      emit(
        InTodoHomeViewAppState()
      );
    });


    on<ConfirmToUpdateTodoIsCompletedAppEvent>((event, emit){
      final currentState = state as InTodoHomeViewAppState;
      final showCompletedTodos = currentState.showCompletedTodos;
      final todoKeyToUpdate = event.todoKeyToUpdate;
      final isCompleted = event.isCompleted ?? false;

      emit(
        InTodoHomeViewAppState(
          todoKeyToUpdate: todoKeyToUpdate,
          alert: updateTodo,
          alertContent: isCompleted ? falseToTrue : trueToFalse,
          showCompletedTodos: showCompletedTodos
        )
      );
    });


    on<UpdateTodoIsCompletedStateAppEvent>((event, emit) async{
      final currentState = state as InTodoHomeViewAppState;
      final keyToUpdate = currentState.todoKeyToUpdate!;
      
      await backend.updateTodoIsCompletedState(keyId: keyToUpdate);
      
      emit(
        InTodoHomeViewAppState()
      );
    });


    on<StartTodoUpdateAppEvent>((event, emit) async{
      final todoToUpdate = event.todoToUpdate;

      emit(
        InAddTodoViewAppState(
          isInUpdateMode: true,
          initialTodo: todoToUpdate
        )
      );
    });


    on<ShowFullTodoDetailsAppEvent>((event, emit){
      final todoKeyToShow = event.todoKeyToShow;

      emit(
        InTodoHomeViewAppState(
          todoKeyToShow: todoKeyToShow
        )
      );
    });


    on<ResetTodoIndexToShowAppEvent>((_, emit){
      emit(
        InTodoHomeViewAppState()
      );
    });


    on<ZoomProfilePicAppEvent>((event, emit) async{
      final detailsOfUser = await backend.getUserDetails();
      final imageData = detailsOfUser?.imageData;

      if(imageData == null){
        emit(
          InTodoHomeViewAppState(
            error: noPictureToZoom
          )
        );
        return;
      }

      final isZoomed = event.isZoomed;
      emit(
        InTodoHomeViewAppState(isZoomed: isZoomed)
      );
    });


    on<ShowCompletedTodosAppEvent>((_, emit){
      emit(
        InTodoHomeViewAppState(showCompletedTodos: true)
      );
    });


    on<HideCompletedTodosAppEvent>((_, emit){
      emit(
        InTodoHomeViewAppState(showCompletedTodos: false)
      );
    });




    //This part deals with the functions in the AddTodo Screen and its implementattions
    on<SaveOrUpdateTodoAppEvent>((event, emit) async{
      final currentState = state as InAddTodoViewAppState;
      final title = event.titleController.text.trim();
      final dueDateTime = event.dueDateTimeController.text.trim();
      final content = event.contentController.text.trim();
      final isInUpdateMode = currentState.isInUpdateMode ?? false;
      
      final fieldsNotEmpty = [title, dueDateTime, content]
        .every((field) => field.isNotEmpty);

      if(fieldsNotEmpty){
        //I want to Update Existing Todo
        if(isInUpdateMode){          
          final oldTodo = currentState.initialTodo!;
          final keyId = oldTodo.todoKey;

          final updateIsSuccessfull = await backend.updateExistingTodo(
            titleToUpdate: title, 
            dueDateTimeToUpdate: dueDateTime, 
            contentToUpdate: content, 
            keyId: keyId
          );

          //A case where the user did not actually change any of the fields
          if(!updateIsSuccessfull){
            emit(
              InAddTodoViewAppState(error: noChange)
            );
          }

          //A case where the user actually changed any of the fields
          else{
            emit(
              InAddTodoViewAppState(error: todoUpdated)
            );
          }

          emit(
            InTodoHomeViewAppState()
          );
        }

        else{
          emit(
            InAddTodoViewAppState(
              isLoading: true,
              operation: saving
            )
          );

          await backend.addNewTodo(
            todoTitle: title, 
            todoDueDateTime: dueDateTime, 
            todoContent: content
          );
          
          event.titleController.clear();
          event.dueDateTimeController.clear();
          event.contentController.clear();
        
          emit(
            InAddTodoViewAppState(
              alert: todoSaved,
              alertContent: addAgain
            )
          );
        }        
      }

      else{
        emit(
          InAddTodoViewAppState(
            error: fieldsEmpty,
            dueDateTime: dueDateTime
          )
        );
      }
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