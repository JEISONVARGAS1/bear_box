part of 'update_user_cubit.dart';

class UpdateUserState {
  final String gender;
  final bool isLoading;
  final DateTime? birthday;
  final UserModel userModel;
  final double priceSubscription;
  final DateTime? dateSubscription;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final List<SubscriptionModel> subscriptions;
  final TextEditingController phoneController;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController addressController;
  final GlobalKey<FormState> formSubscriptionKey;
  final TextEditingController birthdayController;
  final TextEditingController documentIdController;
  final List<SubscriptionModel> subscriptionsActive;
  final TextEditingController descriptionController;
  final TextEditingController subscriptionDateController;
  final TextEditingController addressDescriptionController;
  final TextEditingController priceSubscriptionController;

  const UpdateUserState({
    required this.gender,
    required this.formKey,
    required this.birthday,
    required this.isLoading,
    required this.userModel,
    required this.subscriptions,
    required this.nameController,
    required this.phoneController,
    required this.heightController,
    required this.weightController,
    required this.dateSubscription,
    required this.priceSubscription,
    required this.addressController,
    required this.birthdayController,
    required this.subscriptionsActive,
    required this.formSubscriptionKey,
    required this.documentIdController,
    required this.descriptionController,
    required this.subscriptionDateController,
    required this.priceSubscriptionController,
    required this.addressDescriptionController,
  });

  factory UpdateUserState.init() => UpdateUserState(
    gender: "MALE",
    birthday: null,
    isLoading: false,
    subscriptions: [],
    priceSubscription: 0,
    dateSubscription: null,
    subscriptionsActive: [],
    userModel: UserModel.init(),
    formKey: GlobalKey<FormState>(),
    nameController: TextEditingController(),
    phoneController: TextEditingController(),
    weightController: TextEditingController(),
    heightController: TextEditingController(),
    addressController: TextEditingController(),
    formSubscriptionKey: GlobalKey<FormState>(),
    birthdayController: TextEditingController(),
    documentIdController: TextEditingController(),
    descriptionController: TextEditingController(),
    subscriptionDateController: TextEditingController(),
    priceSubscriptionController: TextEditingController(),
    addressDescriptionController: TextEditingController(),
  );

  UpdateUserState copyWith({
    String? gender,
    bool? isLoading,
    DateTime? birthday,
    UserModel? userModel,
    double? priceSubscription,
    DateTime? dateSubscription,
    List<SubscriptionModel>? subscriptions,
    List<SubscriptionModel>? subscriptionsActive,
  }) => UpdateUserState(
    formKey: formKey,
    gender: gender ?? this.gender,
    nameController: nameController,
    phoneController: phoneController,
    weightController: weightController,
    heightController: heightController,
    birthday: birthday ?? this.birthday,
    addressController: addressController,
    birthdayController: birthdayController,
    userModel: userModel ?? this.userModel,
    isLoading: isLoading ?? this.isLoading,
    formSubscriptionKey: formSubscriptionKey,
    documentIdController: documentIdController,
    descriptionController: descriptionController,
    subscriptions: subscriptions ?? this.subscriptions,
    subscriptionDateController: subscriptionDateController,
    priceSubscriptionController: priceSubscriptionController,
    addressDescriptionController: addressDescriptionController,
    dateSubscription: dateSubscription ?? this.dateSubscription,
    priceSubscription: priceSubscription ?? this.priceSubscription,
    subscriptionsActive: subscriptionsActive ?? this.subscriptionsActive,
  );
}
