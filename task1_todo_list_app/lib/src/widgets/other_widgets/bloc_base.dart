import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1_todo_list_app/src/functions/app_backend.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_events.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_state.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/constants/maps.dart';
import 'package:task1_todo_list_app/src/constants/strings.dart';
import 'package:task1_todo_list_app/src/dialogs/material_banner_alert.dart';
import 'package:task1_todo_list_app/src/dialogs/generic_dialog.dart';
import 'package:task1_todo_list_app/src/dialogs/loading_screen/loading_screen.dart';
import 'package:task1_todo_list_app/src/dialogs/show_todo_details.dart';
import 'package:task1_todo_list_app/src/views/add_todo_view.dart';
import 'package:task1_todo_list_app/src/views/get_user_data_view.dart';
import 'package:task1_todo_list_app/src/views/landing_page_view.dart';
import 'package:task1_todo_list_app/src/views/todo_home_view.dart';


class BlocConsumerBase extends StatelessWidget {
  const BlocConsumerBase({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context1, appState) async{
        final backend = AppBackend();

        //For Loading indicator
        final loadingScreen = LoadingScreen();
        final operation = appState.operation;
        if((appState.isLoading ?? false) && operation != null){
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => loadingScreen.showOverlay(
              context1, operation
            )
          );
        }

        else{
          loadingScreen.hideOverlay();
        }
        

        //For MaterialBanner notification
        final error = appState.error;
        if(error != null){
          await showNotification(
            context1, 
            error, 
            Icons.warning_rounded, 
            purpleColor
          );
        }


        //For AlertDialog pop-up
        final title = appState.alert;
        final content = appState.alertContent;
        if(title != null && content != null){

          final inLandingPageState = appState is InLandingPageViewAppState;
          final inGetUserDataState = appState is InGetUserDataViewAppState;
          final inAddTodoState = appState is InAddTodoViewAppState;
          final inHomeState = appState is InTodoHomeViewAppState;

          final homeAppState = inHomeState ? appState : null;
          final wantsToUpdateUserDetails = homeAppState?.wantsToUpdateUserDetails ?? false;
          final toUpdateUserDetails = inHomeState && wantsToUpdateUserDetails;
          final toUpdateTodoIsCompleted = inHomeState && (homeAppState?.todoIndexToUpdate != null);

          //I had to use Future.delayed here because I was avoiding using 
          //BuildContexts across async Gaps.
          await Future.delayed(
            const Duration(seconds: 0)).then((_) async{
              await showGenericDialog<bool>(
                context: context1, 
                title: title, 
                content: content,
                options: inLandingPageState ? getPermissonMap :
                  inGetUserDataState || inAddTodoState || 
                  toUpdateUserDetails || toUpdateTodoIsCompleted
                  ? questionMap : deleteTodoMap
              ).then((result) async{
                final yes = result == true;
                final notNull = result != null;

                if(inLandingPageState){
                  yes ? context1.read<AppBloc>().add(
                      const GoToGetUserDataViewAppEvent()
                    )
                  : !yes && notNull ? context1.read<AppBloc>().add(
                      const ShowAppPermissionReasonEvent()
                    )
                  : {};
                }

                else if(inGetUserDataState){
                  yes ? context1.read<AppBloc>().add(
                    const GoToTodoHomeAppEvent()
                  ) : {};
                }
                
                else if(inHomeState){
                  if(appState.todoIndexToUpdate == null){
                    yes ? context1.read<AppBloc>().add(
                      const GoToGetUserDataViewAppEvent()
                    ) : {};
                  }
                  else{
                    yes ? context1.read<AppBloc>().add(
                      const UpdateTodoIsCompletedStateAppEvent()
                    ) : {};
                  }
                }

                else if(inAddTodoState){
                  !yes && notNull ? context1.read<AppBloc>().add(
                    const GoToTodoHomeAppEvent()
                  ) : {};
                }
                
                //Future alert dialog conditions can be added here with more else if(s).
              });
            }
          );
        }

        //For snackbar display            
        if(appState is InTodoHomeViewAppState){
          final todoIndexToShow = appState.todoIndexToShow;

          if(todoIndexToShow != null){
            final username = await backend.getUsername();
            final pendingTodos = await backend.getPendingTodos();
            final completedTodos = await backend.getCompletedTodos();
            final totalTodos = [...pendingTodos.toList(), ...completedTodos.toList()];
            
            final todoToShow = totalTodos.firstWhere(
              (todo) => todo?.last == todoIndexToShow, orElse: () => []
            );
            final title = todoToShow?[0];
            final dueDateTime = todoToShow?[1];
            final content = todoToShow?[2];
            final isCompleted = todoToShow?[3];
            final datetimeOfCreation = todoToShow?[4];

            await Future.delayed(const Duration(seconds: 0)).then(
              (value) => showFullTodoDetails(
                context1,
                title!,
                content!,
                dueDateTime!,
                isCompleted!,
                datetimeOfCreation!,
                username ?? newUser
              )
            ).then(
              (_) => context1.read<AppBloc>().add(
                const ResetTodoIndexToShowAppEvent()
              )
            );
          }
        }
      },


      listenWhen: (initialState, newState) 
        => initialState != newState,
  
      builder: (_, appState){
        if (appState is InLandingPageViewAppState){
          return const LandingView();
        }
        else if(appState is InGetUserDataViewAppState){
          return const GetUserDataView();
        }
        else if(appState is InTodoHomeViewAppState){
          return const TodoHomeView();
        }
        else if(appState is InAddTodoViewAppState){
          return const AddTodoView();
        }
        //This should never happen
        else {
          return const SizedBox.shrink();
        }
      },
      buildWhen: (initialState, newState) 
        => initialState != newState,
    );
  }
}