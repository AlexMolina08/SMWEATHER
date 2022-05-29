class CountryModel{
  final String name;
  final String code;

  CountryModel({required this.name, required this.code});


  @override
  String toString() {
    return 'CountryModel{name: $name, code: $code}';
  }

  String get getName => name;
  String get getCode => code;

}

