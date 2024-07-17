class CriterioRicercaRest{
  String searchType = '';
  String columnName = '';
  String valueDa = '';
  String valueA = '';
  String logicalOperator = '';

  CriterioRicercaRest({required this.searchType, required this.columnName, required this.valueDa});

  Map<String, dynamic> toJson() => {
    'searchType': searchType,
    'column_name': columnName,
    'value_da': valueDa,
    // 'value_a': this.valueA,
    // 'logic_operatore': this.logicalOperator,
  };
}