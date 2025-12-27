// ignore_for_file: depend_on_referenced_packages
import 'package:bearbox/feature/create_user/data/data_source/create_user_data_source.dart';
import 'package:bearbox/feature/create_user/data/repositories/create_user_repositories_impl.dart';
import 'package:bearbox/feature/create_user/domain/repositories/create_user_repositories.dart';
import 'package:bearbox/feature/create_user/domain/use_case/create_user_use_case.dart';
import 'package:bearbox/feature/create_user/domain/use_case/generate_medical_data_use_case.dart';
import 'package:bearbox/feature/create_user/presentation/cubit/create_user_cubit.dart';
import 'package:bearbox/feature/home/data/data_source/home_data_source.dart';
import 'package:bearbox/feature/home/data/repositories/home_repositories_impl.dart';
import 'package:bearbox/feature/home/domain/repositories/home_repositories.dart';
import 'package:bearbox/feature/home/domain/use_case/get_user_data_use_case.dart';
import 'package:bearbox/feature/home/domain/use_case/logout_use_case.dart';
import 'package:bearbox/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bearbox/feature/login/data/data_source/login_data_source.dart';
import 'package:bearbox/feature/login/data/repositories/login_repositories_impl.dart';
import 'package:bearbox/feature/login/domain/repositories/login_repositories.dart';
import 'package:bearbox/feature/login/domain/use_case/get_user_data_use_case.dart';
import 'package:bearbox/feature/login/domain/use_case/login_use_case.dart';
import 'package:bearbox/feature/login/domain/use_case/save_hive_user_data_use_case.dart';
import 'package:bearbox/feature/login/presentation/cubit/login_cubit.dart';
import 'package:bearbox/feature/medical_page/data/data_source/medical_page_data_source.dart';
import 'package:bearbox/feature/medical_page/data/repositories/medical_page_repositories_impl.dart';
import 'package:bearbox/feature/medical_page/domain/repositories/medical_page_repositories.dart';
import 'package:bearbox/feature/medical_page/domain/use_case/get_medical_history_use_case.dart';
import 'package:bearbox/feature/medical_page/domain/use_case/save_medical_data_use_case.dart';
import 'package:bearbox/feature/medical_page/presentation/cubit/medical_page_cubit.dart';
import 'package:bearbox/feature/subscriptions/data/repositories/subscriptions_repositories_impl.dart';
import 'package:bearbox/feature/subscriptions/domain/repositories/subscriptions_repositories.dart';
import 'package:bearbox/feature/subscriptions/domain/use_case/get_all_active_subscriptions_use_case.dart';
import 'package:bearbox/feature/subscriptions/domain/use_case/get_all_subscriptions_use_case.dart';
import 'package:bearbox/feature/subscriptions/presentation/cubit/subscriptions_cubit.dart';
import 'package:bearbox/feature/update_user/data/data_source/update_user_data_source.dart';
import 'package:bearbox/feature/update_user/data/repositories/update_user_repositories_impl.dart';
import 'package:bearbox/feature/update_user/domain/repositories/update_user_repositories.dart';
import 'package:bearbox/feature/update_user/domain/use_case/get_history_subscription_use_case.dart';
import 'package:bearbox/feature/update_user/domain/use_case/set_subscription_use_case.dart';
import 'package:bearbox/feature/update_user/domain/use_case/update_existed_workout_use_case.dart';
import 'package:bearbox/feature/update_user/domain/use_case/update_workout_use_case.dart';
import 'package:bearbox/feature/update_user/presentation/cubit/update_user_cubit.dart';
import 'package:bearbox/feature/users/data/data_source/user_data_source.dart';
import 'package:bearbox/feature/users/data/repositories/user_repositories_impl.dart';
import 'package:bearbox/feature/users/domain/repositories/user_repositories.dart';
import 'package:bearbox/feature/users/domain/use_case/delete_user_use_case.dart';
import 'package:bearbox/feature/users/domain/use_case/get_all_user_data_use_case.dart';
import 'package:bearbox/feature/users/presentation/cubit/users_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  try {
    sl
      //cubit
      ..registerFactory<UsersCubit>(
        () => UsersCubit(
          getAllUserDataUseCase: sl(),
          getMedicalHistoryUseCase: sl(),
          deleteUserUseCase: sl(),
        ),
      )
      ..registerFactory<SubscriptionsCubit>(
        () => SubscriptionsCubit(
          getUserDataUseCase: sl(),
          getAllSubscriptionsUseCase: sl(),
          getAllActiveSubscriptionsUseCase: sl(),
        ),
      )
      ..registerFactory<HomeCubit>(
        () => HomeCubit(
          logoutUseCase: sl(),
          getUserDataByEmailUseCase: sl(),
          getMedicalHistoryUseCase: sl(),
        ),
      )
      ..registerFactory<UpdateUserCubit>(
        () => UpdateUserCubit(
          updateUserUseCase: sl(),
          setSubscriptionUseCase: sl(),
          updateExistedWorkoutUseCase: sl(),
          getHistorySubscriptionUseCase: sl(),
        ),
      )
      ..registerFactory<CreateUserCubit>(
        () => CreateUserCubit(
          createUserUseCase: sl(),
          generateMedicalDataUseCase: sl(),
        ),
      )
      ..registerFactory<MedicalPageCubit>(
        () => MedicalPageCubit(saveMedicalDataUseCase: sl()),
      )
      ..registerFactory<LoginCubit>(
        () => LoginCubit(
          loginUseCase: sl(),
          getUserDataUseCase: sl(),
          saveHiveUserUseCase: sl(),
        ),
      )
      //user Case
      ..registerFactory<LogoutUseCase>(
        () => LogoutUseCase(homeRepository: sl()),
      )
      ..registerFactory<UpdateExistedWorkoutUseCase>(
        () => UpdateExistedWorkoutUseCase(updateUserRepository: sl()),
      )
      ..registerFactory<GetAllActiveSubscriptionsUseCase>(
        () => GetAllActiveSubscriptionsUseCase(subscriptionsRepositories: sl()),
      )
      ..registerFactory<GetHistorySubscriptionUseCase>(
        () => GetHistorySubscriptionUseCase(updateUserRepository: sl()),
      )
      ..registerFactory<SetSubscriptionUseCase>(
        () => SetSubscriptionUseCase(updateUserRepository: sl()),
      )
      ..registerFactory<GetAllSubscriptionsUseCase>(
        () => GetAllSubscriptionsUseCase(subscriptionsRepositories: sl()),
      )
      ..registerFactory<UpdateUserUseCase>(
        () => UpdateUserUseCase(updateUserRepository: sl()),
      )
      ..registerFactory<GenerateMedicalDataUseCase>(
        () => GenerateMedicalDataUseCase(createUserRepository: sl()),
      )
      ..registerFactory<SaveMedicalDataUseCase>(
        () => SaveMedicalDataUseCase(medicalPageRepository: sl()),
      )
      ..registerFactory<GetMedicalHistoryUseCase>(
        () => GetMedicalHistoryUseCase(medicalPageRepository: sl()),
      )
      ..registerFactory<CreateUserUseCase>(
        () => CreateUserUseCase(createUserRepository: sl()),
      )
      ..registerFactory<GetAllUserDataUseCase>(
        () => GetAllUserDataUseCase(userRepository: sl()),
      )
      ..registerFactory<DeleteUserUseCase>(
        () => DeleteUserUseCase(userRepository: sl()),
      )
      ..registerFactory<GetUserDataByEmailUseCase>(
        () => GetUserDataByEmailUseCase(homeRepository: sl()),
      )
      ..registerFactory<SaveHiveUserUseCase>(
        () => SaveHiveUserUseCase(loginRepository: sl()),
      )
      ..registerFactory<LoginUseCase>(() => LoginUseCase(loginRepository: sl()))
      ..registerFactory<GetUserDataUseCase>(
        () => GetUserDataUseCase(loginRepository: sl()),
      )
      //Repository
      ..registerFactory<SubscriptionsRepositories>(
        () => SubscriptionsRepositoriesImpl(db: sl()),
      )
      ..registerFactory<UpdateUserRepositories>(
        () => UpdateUserRepositoryImpl(updateUserDataSource: sl()),
      )
      ..registerFactory<CreateUserRepository>(
        () => CreateUserRepositoryImpl(createUserDataSource: sl()),
      )
      ..registerFactory<MedicalPageRepository>(
        () => MedicalPageRepositoryImpl(medicalPageDataSource: sl()),
      )
      ..registerFactory<UserRepository>(
        () => UserRepositoryImpl(userDataSource: sl()),
      )
      ..registerFactory<HomeRepository>(
        () => HomeRepositoryImpl(homeDataSource: sl()),
      )
      ..registerFactory<LoginRepository>(
        () => LoginRepositoryImpl(loginDataSource: sl()),
      )
      //Dara source
      ..registerFactory<UserDataSource>(
        () => UserDataSourceImpl(db: sl(), auth: sl()),
      )
      ..registerFactory<HomeDataSource>(
        () => HomeDataSourceImpl(db: sl(), auth: sl()),
      )
      ..registerFactory<LoginDataSource>(
        () => LoginDataSourceImpl(db: sl(), auth: sl()),
      )
      ..registerFactory<UpdateUserDataSource>(
        () => UpdateUserDataSourceImpl(db: sl(), storage: sl()),
      )
      ..registerFactory<CreateUserDataSource>(
        () => CreateUserDataSourceImpl(db: sl()),
      )
      ..registerFactory<MedicalPageDataSource>(
        () => MedicalPageDataSourceImpl(),
      )
      ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
      ..registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance)
      ..registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance,
      );
  } catch (e) {
    // Error initializing dependencies: $e
  }
}
