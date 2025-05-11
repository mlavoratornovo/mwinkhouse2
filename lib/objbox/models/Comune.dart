class Comune {

  String? codIstat;
  String? comune;
  String? regione;
  String? provincia;
  String? cap;

  Comune({String? initString}){
    if (initString != null && initString.trim() != ''){
      List<String> l = initString.split('/');
      codIstat = l[0];
      comune = l[1];
      provincia = l[2];
      regione = l[3];
      cap = l[4];
    }
  }
  factory Comune.fromJson(Map<String, dynamic> json){
    Comune instance = Comune();
    instance.codIstat = json['codice'];
    instance.comune = json['nome'];
    instance.provincia = json['provincia']?['nome'];
    instance.regione = json['regione']?['nome'];
    instance.cap = json['cap']?[0];
    return instance;
  }
}