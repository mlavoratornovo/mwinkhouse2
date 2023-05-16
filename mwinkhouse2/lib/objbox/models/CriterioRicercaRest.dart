class CriterioRicercaRest{
  String searchType = '';
  String columnName = '';
  String valueDa = '';
  String valueA = '';
  String logicalOperator = '';

  CriterioRicercaRest({required this.searchType, required this.columnName, required this.valueDa});

  Map<String, dynamic> toJson() => {
    'searchType': this.searchType,
    'column_name': this.columnName,
    'value_da': this.valueDa,
    // 'value_a': this.valueA,
    // 'logic_operatore': this.logicalOperator,
  };
}