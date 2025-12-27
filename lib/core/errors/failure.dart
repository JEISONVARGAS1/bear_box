abstract class Failure {
  late String message;
}

class CreateWorkoutFailure implements Failure {
  @override
  String message;

  CreateWorkoutFailure({this.message = ""});
}

class CreateRecipesFailure implements Failure {
  @override
  String message;

  CreateRecipesFailure({this.message = ""});
}

class UpdateUserFailure implements Failure {
  @override
  String message;

  UpdateUserFailure({this.message = ""});
}

class MedicalDataFailure implements Failure {
  @override
  String message;

  MedicalDataFailure({this.message = ""});
}
