import 'enums.dart';

const kOTPResendingDuration = 2;

class CountryModel {
  bool? isActive;
  String? countrySymbol;

  CountryModel({this.isActive, this.countrySymbol});
}

class AppConstants {
  static const String appName = 'Student Registration App';
  static const String unknownError =
      'An unexpected error occurred. Please try again.';

  static ThemeType selectedTheme = ThemeType.LIGHT;

  static List<CountryModel> countries = [
    CountryModel(isActive: true, countrySymbol: 'SA'),
    CountryModel(isActive: true, countrySymbol: 'US'),
    CountryModel(isActive: true, countrySymbol: 'AE'),
    CountryModel(isActive: true, countrySymbol: 'IN'),
    CountryModel(isActive: true, countrySymbol: 'LK'),
  ];
}
