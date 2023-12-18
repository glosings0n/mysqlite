abstract class TodoStates {}

class InitialTodoStates extends TodoStates {}

class BottomNavState extends TodoStates {}

class CreatingTodoDBStates extends TodoStates {}

class InsertingIntoDBState extends TodoStates {}

class GettingDataFromDBState extends TodoStates {}

class DeletingDataFromDatabaseState extends TodoStates {}

class LoadingGetDataFromDB extends TodoStates {}

class FloatCurrentPosition extends TodoStates {}

class ChangeLanguagesToArabic extends TodoStates {}

class ChangeLanguagesToEnglish extends TodoStates {}

class ChangeLanguagesToFrench extends TodoStates {}

class ChangeThemeMode extends TodoStates {}

class SuccessUpdatingDataFromDatabaseState extends TodoStates{}