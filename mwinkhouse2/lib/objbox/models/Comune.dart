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

}