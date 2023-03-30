class CriterioRicercaRest{
  String searchType = '';
  String columnName = '';
  String valueDa = '';
  String valueA = '';
  String logicalOperator = '';

  Map<String, dynamic> toJson() => {
    'searchType': this.searchType,
    'column_name': this.columnName,
    'value_da': this.valueDa,
    'value_a': this.valueA,
    'logic_operatore': this.logicalOperator,
  };
}