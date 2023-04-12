
import 'dart:async';
import 'dart:ffi';

import 'package:mwinkhouse2/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse2/objbox/models/ClasseCliente.dart';
import 'package:mwinkhouse2/objbox/models/ClasseEnergetica.dart';
import 'package:mwinkhouse2/objbox/models/Colloquio.dart';
import 'package:mwinkhouse2/objbox/models/Contatto.dart';
import 'package:mwinkhouse2/objbox/models/CriteriRicercaAnagrafica.dart';
import 'package:mwinkhouse2/objbox/models/CriteriRicercaImmobile.dart';
import 'package:mwinkhouse2/objbox/models/Immobile.dart';
import 'package:mwinkhouse2/objbox/models/StatoConservativo.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaAppuntamento.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaColloquio.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaContatto.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaImmobile.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaStanza.dart';
import 'package:mwinkhouse2/objectbox.g.dart';
import 'package:mwinkhouse2/objbox/models/Riscaldamento.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:async_task/async_task.dart';

class ObjectBox {

  late final Store store;

  late final Box<ClasseCliente> classeClienteBox;
  late final Box<TipologiaImmobile> tipologiaImmobileBox;
  late final Box<TipologiaContatto> tipologiaContattoBox;
  late final Box<TipologiaStanza> tipologiaStanzaBox;
  late final Box<TipologiaAppuntamento> tipologiaAppuntamentoBox;
  late final Box<TipologiaColloquio> tipologiaColloquioBox;
  late final Box<StatoConservativo> statoConservativoBox;
  late final Box<Riscaldamento> riscaldamentoBox;
  late final Box<ClasseEnergetica> classeEnergeticaBox;
  late final Box<Immobile> immobileBox;
  late final Box<Anagrafica> anagraficaBox;
  late final Box<Colloquio> colloquioBox;
  late final Box<Contatto> contattoBox;
  late final Admin _admin;

  ObjectBox._create(this.store) {

    if (Admin.isAvailable()) {
      // Keep a reference until no longer needed or manually closed.
      _admin = Admin(store);
    }

    immobileBox = Box<Immobile>(store);

    anagraficaBox = Box<Anagrafica>(store);

    colloquioBox = Box<Colloquio>(store);

    contattoBox = Box<Contatto>(store);

    classeClienteBox = Box<ClasseCliente>(store);
    if (classeClienteBox.isEmpty()) {
      _fillClasseCliente();
    }

    tipologiaImmobileBox = Box<TipologiaImmobile>(store);
    if (tipologiaImmobileBox.isEmpty()){
      _fillTipologiaImmobile();
    }

    tipologiaStanzaBox = Box<TipologiaStanza>(store);
    if (tipologiaStanzaBox.isEmpty()){
      _fillTipologiaStanza();
    }

    tipologiaAppuntamentoBox = Box<TipologiaAppuntamento>(store);
    if (tipologiaAppuntamentoBox.isEmpty()){
      _fillTipologiaAppuntamento();
    }

    tipologiaColloquioBox = Box<TipologiaColloquio>(store);
    if (tipologiaColloquioBox.isEmpty()){
      _fillTipologiaColloquio();
    }

    statoConservativoBox = Box<StatoConservativo>(store);
    if (statoConservativoBox.isEmpty()){
      _fillStatoConservativo();
    }

    classeEnergeticaBox = Box<ClasseEnergetica>(store);
    if (classeEnergeticaBox.isEmpty()){
      _fillClasseEnergetica();
    }

    riscaldamentoBox = Box<Riscaldamento>(store);
    if (riscaldamentoBox.isEmpty()){
      _fillRiscaldamento();
    }

    tipologiaContattoBox = Box<TipologiaContatto>(store);
    if (tipologiaContattoBox.isEmpty()){
      _fillTipologiaContatto();
    }

  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final databaseDirectory =
    p.join(documentsDirectory.path, "obx-demo-relations");

    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: databaseDirectory);
    return ObjectBox._create(store);
  }

  // ClasseCliente
  void _fillClasseCliente() {

    List<ClasseCliente> classiClienti = [];

    ClasseCliente cc1 = ClasseCliente();
    cc1.descrizione = 'Acquirente';
    classiClienti.add(cc1);
    ClasseCliente cc2 = ClasseCliente();
    cc2.descrizione = 'Proprietario';
    classiClienti.add(cc2);
    ClasseCliente cc3 = ClasseCliente();
    cc3.descrizione = 'Incaricato';
    classiClienti.add(cc3);
    ClasseCliente cc4 = ClasseCliente();
    cc4.descrizione = 'Procuratore';
    classiClienti.add(cc4);
    ClasseCliente cc5 = ClasseCliente();
    cc5.descrizione = 'Affittuario';
    classiClienti.add(cc5);
    ClasseCliente cc6 = ClasseCliente();
    cc6.descrizione = 'Locatore';
    classiClienti.add(cc6);
    ClasseCliente cc7 = ClasseCliente();
    cc7.descrizione = 'Acquirente';
    classiClienti.add(cc7);
    ClasseCliente cc8 = ClasseCliente();
    cc8.descrizione = 'Geometra';
    classiClienti.add(cc8);
    ClasseCliente cc9 = ClasseCliente();
    cc9.descrizione = 'Ingegnere';
    classiClienti.add(cc9);
    ClasseCliente cc10 = ClasseCliente();
    cc10.descrizione = 'Architetto';
    classiClienti.add(cc10);
    ClasseCliente cc11 = ClasseCliente();
    cc11.descrizione = 'Azienda edile';
    classiClienti.add(cc11);

    store.runInTransactionAsync(TxMode.write, _putClasseClienteInTx, classiClienti);
  }

  Stream<List<ClasseCliente>> getClassiCliente() {
    // Query for all notes, sorted by their date.
    // https://docs.objectbox.io/queries
    final builder = classeClienteBox.query()..order(ClasseCliente_.ordine, flags: Order.descending);
    // Build and watch the query,
    // set triggerImmediately to emit the query immediately on listen.
    return builder
        .watch(triggerImmediately: true)
    // Map it to a list of notes to be used by a StreamBuilder.
        .map((query) => query.find());
  }

  static void _putClasseClienteInTx(Store store, List<ClasseCliente> classiCliente) =>
      store.box<ClasseCliente>().putMany(classiCliente);

  Future<void> addClasseCliente(ClasseCliente c1) =>
      store.runInTransactionAsync(TxMode.write, _addClasseClienteInTx, c1);

  static void _addClasseClienteInTx(Store store, ClasseCliente c1) {
    // Perform ObjectBox operations that take longer than a few milliseconds
    // here. To keep it simple, this example just puts a single object.
    store.box<ClasseCliente>().put(c1);
  }

  // Tipologia Immobile
  void _fillTipologiaImmobile() {

    List<TipologiaImmobile> tipologieImmobili = [];

    TipologiaImmobile cc1 = TipologiaImmobile();
    cc1.descrizione = 'Abitazione singola';
    tipologieImmobili.add(cc1);
    TipologiaImmobile cc2 = TipologiaImmobile();
    cc2.descrizione = 'Appartamento in condominio';
    tipologieImmobili.add(cc2);
    TipologiaImmobile cc3 = TipologiaImmobile();
    cc3.descrizione = 'Appartamento ingresso indipendente';
    tipologieImmobili.add(cc3);
    TipologiaImmobile cc4 = TipologiaImmobile();
    cc4.descrizione = 'Bifamiliare';
    tipologieImmobili.add(cc4);
    TipologiaImmobile cc5 = TipologiaImmobile();
    cc5.descrizione = 'Casa indipendente';
    tipologieImmobili.add(cc5);
    TipologiaImmobile cc6 = TipologiaImmobile();
    cc6.descrizione = 'Villetta a schiera';
    tipologieImmobili.add(cc6);
    TipologiaImmobile cc7 = TipologiaImmobile();
    cc7.descrizione = 'Box auto';
    tipologieImmobili.add(cc7);
    TipologiaImmobile cc8 = TipologiaImmobile();
    cc8.descrizione = 'Casale rustico';
    tipologieImmobili.add(cc8);
    TipologiaImmobile cc9 = TipologiaImmobile();
    cc9.descrizione = 'Mansarda';
    tipologieImmobili.add(cc9);
    TipologiaImmobile cc10 = TipologiaImmobile();
    cc10.descrizione = 'Villa';
    tipologieImmobili.add(cc10);
    TipologiaImmobile cc11 = TipologiaImmobile();
    cc11.descrizione = 'Deposito';
    tipologieImmobili.add(cc11);
    TipologiaImmobile cc12 = TipologiaImmobile();
    cc12.descrizione = 'Locale Commerciale';
    tipologieImmobili.add(cc12);

    store.runInTransactionAsync(TxMode.write, _putTipologiaImmobileInTx, tipologieImmobili);
  }
  
  static void _putTipologiaImmobileInTx(Store store, List<TipologiaImmobile> tipologieImmobili) =>
      store.box<TipologiaImmobile>().putMany(tipologieImmobili);

  Future<void> addTipologiaImmobile(TipologiaImmobile c1) =>
      store.runInTransactionAsync(TxMode.write, _addTipologiaImmobileInTx, c1);

  static void _addTipologiaImmobileInTx(Store store, TipologiaImmobile c1) {
    store.box<TipologiaImmobile>().put(c1);
  }

  // Stato Conservativo
  void _fillStatoConservativo() {

    List<StatoConservativo> statiConservativi = [];

    StatoConservativo cc1 = StatoConservativo();
    cc1.descrizione = 'Nuovo';
    statiConservativi.add(cc1);
    StatoConservativo cc2 = StatoConservativo();
    cc2.descrizione = 'Ottimo';
    statiConservativi.add(cc2);
    StatoConservativo cc3 = StatoConservativo();
    cc3.descrizione = 'Buono';
    statiConservativi.add(cc3);
    StatoConservativo cc4 = StatoConservativo();
    cc4.descrizione = 'Da rimodernare';
    statiConservativi.add(cc4);
    StatoConservativo cc5 = StatoConservativo();
    cc5.descrizione = 'Da ristrutturare';
    statiConservativi.add(cc5);
    StatoConservativo cc6 = StatoConservativo();
    cc6.descrizione = 'Da tinteggiare';
    statiConservativi.add(cc6);
    StatoConservativo cc7 = StatoConservativo();
    cc7.descrizione = 'Da ultimare';
    statiConservativi.add(cc7);
    StatoConservativo cc8 = StatoConservativo();
    cc8.descrizione = 'Su progetto';
    statiConservativi.add(cc8);
    StatoConservativo cc9 = StatoConservativo();
    cc9.descrizione = 'Mediocre';
    statiConservativi.add(cc9);

    store.runInTransactionAsync(TxMode.write, _putStatoConservativoInTx, statiConservativi);
  }

  static void _putStatoConservativoInTx(Store store, List<StatoConservativo> statiConservativi) =>
      store.box<StatoConservativo>().putMany(statiConservativi);

  Future<void> addStatoConservativo(StatoConservativo c1) =>
      store.runInTransactionAsync(TxMode.write, _addStatoConservativoInTx, c1);

  static void _addStatoConservativoInTx(Store store, StatoConservativo c1) {
    store.box<StatoConservativo>().put(c1);
  }


  // Classe Energetica
  void _fillClasseEnergetica() {

    List<ClasseEnergetica> classiEnergetiche = [];

    ClasseEnergetica cc7 = ClasseEnergetica();
    cc7.descrizione = '< 15 Kwh/mq annuo = < 1.5 litri gasolio/mq annuo';
    cc7.nome = 'Casa passiva';
    classiEnergetiche.add(cc7);
    ClasseEnergetica cc1 = ClasseEnergetica();
    cc1.descrizione = '< 30 Kwh/mq annuo = < 3 litri gasolio/mq annuo';
    cc1.nome = 'A';
    classiEnergetiche.add(cc1);
    ClasseEnergetica cc2 = ClasseEnergetica();
    cc2.descrizione = 'tra 31 - 50 Kwh/mq annuo = < 3.1 - 5 litri gasolio/mq annuo';
    cc2.nome = 'B';
    classiEnergetiche.add(cc2);
    ClasseEnergetica cc3 = ClasseEnergetica();
    cc3.descrizione = 'tra 51 - 70 Kwh/mq annuo = < 5.1 - 7 litri gasolio/mq annuo';
    cc3.nome = 'C';
    classiEnergetiche.add(cc3);
    ClasseEnergetica cc4 = ClasseEnergetica();
    cc4.descrizione = 'tra 71 - 90 Kwh/mq annuo = < 7.1 - 9 litri gasolio/mq annuo';
    cc4.nome = 'D';
    classiEnergetiche.add(cc4);
    ClasseEnergetica cc5 = ClasseEnergetica();
    cc5.descrizione = 'tra 91 - 120 Kwh/mq annuo = < 9.1 - 12 litri gasolio/mq annuo';
    cc5.nome = 'E';
    classiEnergetiche.add(cc5);
    ClasseEnergetica cc6 = ClasseEnergetica();
    cc6.descrizione = 'tra 121 - 160 Kwh/mq annuo = < 12.1 - 16 litri gasolio/mq annuo';
    cc6.nome = 'F';
    classiEnergetiche.add(cc6);
    ClasseEnergetica cc8 = ClasseEnergetica();
    cc8.descrizione = '> 160 Kwh/mq annuo = > 16 litri gasolio/mq annuo';
    cc8.nome = 'G';
    classiEnergetiche.add(cc8);

    store.runInTransactionAsync(TxMode.write, _putClasseEnergeticaInTx, classiEnergetiche);
  }

  static void _putClasseEnergeticaInTx(Store store, List<ClasseEnergetica> classiEnergetiche) =>
      store.box<ClasseEnergetica>().putMany(classiEnergetiche);

  Future<void> addClasseEnergetica(ClasseEnergetica c1) =>
      store.runInTransactionAsync(TxMode.write, _addClasseEnergeticaInTx, c1);

  static void _addClasseEnergeticaInTx(Store store, ClasseEnergetica c1) {
    store.box<ClasseEnergetica>().put(c1);
  }
  
// tipologiaContattoBox
  void _fillTipologiaContatto() {

    List<TipologiaContatto> tipologieContatti = [];

    TipologiaContatto cc7 = TipologiaContatto();
    cc7.descrizione = 'Telefono fisso casa';
    tipologieContatti.add(cc7);
    TipologiaContatto cc1 = TipologiaContatto();
    cc1.descrizione = 'Telefono fisso ufficio';
    tipologieContatti.add(cc1);
    TipologiaContatto cc2 = TipologiaContatto();
    cc2.descrizione = 'Cellulare lavoro';
    tipologieContatti.add(cc2);
    TipologiaContatto cc3 = TipologiaContatto();
    cc3.descrizione = 'Cellulare personale';
    tipologieContatti.add(cc3);
    TipologiaContatto cc4 = TipologiaContatto();
    cc4.descrizione = 'Email';
    tipologieContatti.add(cc4);
    TipologiaContatto cc5 = TipologiaContatto();
    cc5.descrizione = 'Fax';
    tipologieContatti.add(cc5);

    store.runInTransactionAsync(TxMode.write, _putTipologiaContattoInTx, tipologieContatti);
  }

  static void _putTipologiaContattoInTx(Store store, List<TipologiaContatto> tipologieContatti) =>
      store.box<TipologiaContatto>().putMany(tipologieContatti);

  Future<void> addTipologiaContatto(TipologiaContatto c1) =>
      store.runInTransactionAsync(TxMode.write, _addTipologiaContattoInTx, c1);

  static void _addTipologiaContattoInTx(Store store, TipologiaContatto c1) {
    store.box<TipologiaContatto>().put(c1);
  }

// RiscaldamentoBox
  void _fillRiscaldamento() {

    List<Riscaldamento> riscaldamenti = [];

    Riscaldamento cc7 = Riscaldamento();
    cc7.descrizione = 'Caldaia autonoma';
    riscaldamenti.add(cc7);
    Riscaldamento cc1 = Riscaldamento();
    cc1.descrizione = 'Caldaia autonoma a condensazione';
    riscaldamenti.add(cc1);
    Riscaldamento cc2 = Riscaldamento();
    cc2.descrizione = 'Caldaia centralizzata';
    riscaldamenti.add(cc2);
    Riscaldamento cc3 = Riscaldamento();
    cc3.descrizione = 'Pompa di calore';
    riscaldamenti.add(cc3);
    Riscaldamento cc4 = Riscaldamento();
    cc4.descrizione = 'Stufa pellet';
    riscaldamenti.add(cc4);
    Riscaldamento cc5 = Riscaldamento();
    cc5.descrizione = 'Solo aria condizionata';
    riscaldamenti.add(cc5);

    store.runInTransactionAsync(TxMode.write, _putRiscaldamentoInTx, riscaldamenti);
  }

  static void _putRiscaldamentoInTx(Store store, List<Riscaldamento> riscaldamenti) =>
      store.box<Riscaldamento>().putMany(riscaldamenti);

  Future<void> addRiscaldamento(Riscaldamento c1) =>
      store.runInTransactionAsync(TxMode.write, _addRiscaldamentoInTx, c1);

  static void _addRiscaldamentoInTx(Store store, Riscaldamento c1) {
    store.box<Riscaldamento>().put(c1);
  }

// TipologiaStanzaBox
  void _fillTipologiaStanza() {

    List<TipologiaStanza> tipologieStanze = [];

    TipologiaStanza cc7 = TipologiaStanza();
    cc7.descrizione = 'Ambiente unico';
    tipologieStanze.add(cc7);
    TipologiaStanza cc1 = TipologiaStanza();
    cc1.descrizione = 'Antibagno';
    tipologieStanze.add(cc1);
    TipologiaStanza cc2 = TipologiaStanza();
    cc2.descrizione = 'Bagno';
    tipologieStanze.add(cc2);
    TipologiaStanza cc3 = TipologiaStanza();
    cc3.descrizione = 'Balcone';
    tipologieStanze.add(cc3);
    TipologiaStanza cc4 = TipologiaStanza();
    cc4.descrizione = 'Camera da letto';
    tipologieStanze.add(cc4);
    TipologiaStanza cc5 = TipologiaStanza();
    cc5.descrizione = 'Cantina';
    tipologieStanze.add(cc5);
    TipologiaStanza cc6 = TipologiaStanza();
    cc6.descrizione = 'Corridoio';
    tipologieStanze.add(cc6);
    TipologiaStanza cc9 = TipologiaStanza();
    cc9.descrizione = 'Cucina';
    tipologieStanze.add(cc9);
    TipologiaStanza cc8 = TipologiaStanza();
    cc8.descrizione = 'Deposito';
    tipologieStanze.add(cc8);
    TipologiaStanza cc10 = TipologiaStanza();
    cc10.descrizione = 'Disimpegno';
    tipologieStanze.add(cc10);
    TipologiaStanza cc11 = TipologiaStanza();
    cc11.descrizione = 'Lavanderia';
    tipologieStanze.add(cc11);
    TipologiaStanza cc12 = TipologiaStanza();
    cc12.descrizione = 'Locale commerciale';
    tipologieStanze.add(cc12);
    TipologiaStanza cc13 = TipologiaStanza();
    cc13.descrizione = 'Rimessa';
    tipologieStanze.add(cc13);
    TipologiaStanza cc14 = TipologiaStanza();
    cc14.descrizione = 'Ripostiglio';
    tipologieStanze.add(cc14);
    TipologiaStanza cc15 = TipologiaStanza();
    cc15.descrizione = 'Soffitta';
    tipologieStanze.add(cc15);
    TipologiaStanza cc16 = TipologiaStanza();
    cc16.descrizione = 'Soggiorno';
    tipologieStanze.add(cc16);
    TipologiaStanza cc17 = TipologiaStanza();
    cc17.descrizione = 'Sottoscala';
    tipologieStanze.add(cc17);
    TipologiaStanza cc18 = TipologiaStanza();
    cc18.descrizione = 'Studio';
    tipologieStanze.add(cc18);
    TipologiaStanza cc19 = TipologiaStanza();
    cc19.descrizione = 'Tavernetta';
    tipologieStanze.add(cc19);

    store.runInTransactionAsync(TxMode.write, _putTipologiaStanzaInTx, tipologieStanze);
  }

  static void _putTipologiaStanzaInTx(Store store, List<TipologiaStanza> tipologieStanze) =>
      store.box<TipologiaStanza>().putMany(tipologieStanze);

  Future<void> addTipologiaStanza(TipologiaStanza c1) =>
      store.runInTransactionAsync(TxMode.write, _addTipologiaStanzaInTx, c1);

  static void _addTipologiaStanzaInTx(Store store, TipologiaStanza c1) {
    store.box<TipologiaStanza>().put(c1);
  }

  // TipologiaAppuntamentoBox
  void _fillTipologiaAppuntamento() {
    
    List<TipologiaAppuntamento> tipologiaAppuntamento = [];
    
    TipologiaAppuntamento ta1 = TipologiaAppuntamento();
    ta1.descrizione = 'Stipula atti presso notaio';
    ta1.ordine = 1;
    tipologiaAppuntamento.add(ta1);

    TipologiaAppuntamento ta2 = TipologiaAppuntamento();
    ta2.descrizione = 'Colloquio con acquirente';
    ta2.ordine = 2;
    tipologiaAppuntamento.add(ta2);

    TipologiaAppuntamento ta3 = TipologiaAppuntamento();
    ta3.descrizione = 'Colloquio con proprietario';
    ta3.ordine = 3;
    tipologiaAppuntamento.add(ta3);

    TipologiaAppuntamento ta4 = TipologiaAppuntamento();
    ta4.descrizione = 'Generico';
    ta4.ordine = 4;
    tipologiaAppuntamento.add(ta4);

    TipologiaAppuntamento ta5 = TipologiaAppuntamento();
    ta5.descrizione = 'Valutazione immobile';
    ta5.ordine = 5;
    tipologiaAppuntamento.add(ta5);

    TipologiaAppuntamento ta6 = TipologiaAppuntamento();
    ta6.descrizione = 'Visita immobile';
    ta6.ordine = 5;
    tipologiaAppuntamento.add(ta6);

    store.runInTransactionAsync(TxMode.write, _putTipologiaAppuntamentoInTx, tipologiaAppuntamento);
  }
  
  static void _putTipologiaAppuntamentoInTx(Store store, List<TipologiaAppuntamento> tipologiaAppuntamento) =>
      store.box<TipologiaAppuntamento>().putMany(tipologiaAppuntamento);

  Future<void> addTipologiaAppuntamento(TipologiaAppuntamento c1) =>
      store.runInTransactionAsync(TxMode.write, _addTipologiaAppuntamentoInTx, c1);

  static void _addTipologiaAppuntamentoInTx(Store store, TipologiaAppuntamento c1) {
    store.box<TipologiaAppuntamento>().put(c1);
  }

  // TipologiaColloquioBox
  void _fillTipologiaColloquio() {

    List<TipologiaColloquio> tipologiaColloquio = [];

    TipologiaColloquio ta1 = TipologiaColloquio();
    ta1.descrizione = 'Ricerca immobile';
    tipologiaColloquio.add(ta1);

    TipologiaColloquio ta3 = TipologiaColloquio();
    ta3.descrizione = 'Generico';
    tipologiaColloquio.add(ta3);

    TipologiaColloquio ta4 = TipologiaColloquio();
    ta4.descrizione = 'Visita';
    tipologiaColloquio.add(ta4);

    store.runInTransactionAsync(TxMode.write, _putTipologiaColloquioInTx, tipologiaColloquio);
  }

  static void _putTipologiaColloquioInTx(Store store, List<TipologiaColloquio> tipologiaColloquio) =>
      store.box<TipologiaColloquio>().putMany(tipologiaColloquio);

  Future<void> addTipologiaColloquio(TipologiaColloquio c1) =>
      store.runInTransactionAsync(TxMode.write, _addTipologiaColloquioInTx, c1);

  static void _addTipologiaColloquioInTx(Store store, TipologiaColloquio c1) {
    store.box<TipologiaColloquio>().put(c1);
  }

  // ColloquioBox

  void removeColloquio(int codColloquio){
    colloquioBox.remove(codColloquio);
  }

  // ConattoBox

  void removeConatto(int codConatto){
    contattoBox.remove(codConatto);
  }

  // ImmobileBox
  
  static void _putImmobileInTx(Store store, List<Immobile> immobile) =>
      store.box<Immobile>().putMany(immobile);

  Future<void> addImmobile(Immobile c1) async {
    // store.runInTransactionAsync(TxMode.write, _addImmobileInTx, c1);
    List<AsyncTask> _taskTypeRegister() => [SaveImmobile(c1,store)];

    var asyncExecutor = AsyncExecutor(
      sequential: true, // Non-sequential tasks.
      parallelism: 0, // Concurrency with 2 threads.
      taskTypeRegister: _taskTypeRegister, // The top-level function to register the tasks types.
    );
    asyncExecutor.execute(SaveImmobile(c1, store));
  }

  static void _addImmobileInTx(Store store, Immobile c1) {

    store.box<Immobile>().put(c1);
  }

  void removeImmobile(int codImmobile) {
    immobileBox.remove(codImmobile);
  }

  Immobile? getImmobile(int codImmobile) {
    return immobileBox.get(codImmobile);
  }

  void removeImmobileEntity(Immobile immobile){
    store.runInTransaction(TxMode.write, () => {

      immobile.colloqui.forEach((element) {
        colloquioBox.remove(element.codColloquio??0);
      }),
      immobile.colloqui.removeRange(0, immobile.colloqui.length),
      immobile.colloqui.applyToDb(),

      immobile.stanze.forEach((element) {
        colloquioBox.remove(element.codStanzaImmobile??0);
      }),
      immobile.stanze.removeRange(0, immobile.stanze.length),
      immobile.stanze.applyToDb(),
      immobileBox.remove(immobile.codImmobile??0)
    });
  }

  Stream<List<Immobile>> getImmobili({List<int> notin=const []}) {
    // Query for all tasks, sorted by their date.
    // https://docs.objectbox.io/queries
    QueryBuilder<Immobile> qBuilderTasks;
    if (notin==null) {
      qBuilderTasks = immobileBox.query()
        ..order(Immobile_.codImmobile, flags: Order.descending);
    }else{
      qBuilderTasks = immobileBox.query(Immobile_.codImmobile.notOneOf(notin!))
        ..order(Immobile_.codImmobile, flags: Order.descending);
    }
    // Build and watch the query,
    // set triggerImmediately to emit the query immediately on listen.
    return qBuilderTasks
        .watch(triggerImmediately: true)
    // Map it to a list of tasks to be used by a StreamBuilder.
        .map((query) => query.find());
  }

  Stream<List<Immobile>> searchImmobili({required CriteriRicercaImmobile criteri}){

    QueryBuilder<Immobile> qBuilderImmobili = immobileBox.query(
        ((criteri.prezzoDa!=0.0)?Immobile_.prezzo.greaterOrEqual(criteri.prezzoDa):Immobile_.prezzo.notNull()) &
        ((criteri.prezzoA!=0.0)?Immobile_.prezzo.lessOrEqual(criteri.prezzoA):Immobile_.prezzo.notNull()) &
        ((criteri.mqDa!=0)?Immobile_.mq.greaterOrEqual(criteri.mqDa):Immobile_.mq.notNull()) &
        ((criteri.mqA!=0)?Immobile_.mq.lessOrEqual(criteri.mqA):Immobile_.mq.notNull()) &
        ((criteri.annoCostruzioneDa!=0)?Immobile_.annoCostruzione.greaterOrEqual(criteri.annoCostruzioneDa):Immobile_.annoCostruzione.notNull()) &
        ((criteri.annoCostruzioneA!=0)?Immobile_.annoCostruzione.lessOrEqual(criteri.annoCostruzioneA):Immobile_.annoCostruzione.notNull()) &
        ((criteri.indirizzo!='')?Immobile_.indirizzo.contains(criteri.indirizzo):Immobile_.indirizzo.notNull()) &
        ((criteri.zona!='')?Immobile_.zona.contains(criteri.zona):Immobile_.zona.notNull()) &
        ((criteri.provincia!='')?Immobile_.provincia.contains(criteri.provincia):Immobile_.provincia.notNull()) &
        ((criteri.cap!='')?Immobile_.cap.contains(criteri.zona):Immobile_.cap.notNull()) &
        ((criteri.citta!='')?Immobile_.citta.contains(criteri.citta):Immobile_.citta.notNull())
    );

    final statoConservativo = criteri.statoConservativo;
    if (statoConservativo!=null && statoConservativo.codStatoConservativo != null){
      qBuilderImmobili.link(Immobile_.statoConservativo, StatoConservativo_.codStatoConservativo.equals(statoConservativo.codStatoConservativo!));
    }
    final riscaldamento = criteri.riscaldamento;
    if (riscaldamento!=null && riscaldamento.codRiscaldamento != null){
      qBuilderImmobili.link(Immobile_.riscaldamento, Riscaldamento_.codRiscaldamento.equals(riscaldamento.codRiscaldamento!));
    }
    final tipologia = criteri.tipologiaImmobile;
    if (tipologia!=null && tipologia.codTipologiaImmobile != null){
      qBuilderImmobili.link(Immobile_.tipologiaImmobile, TipologiaImmobile_.codTipologiaImmobile.equals(tipologia.codTipologiaImmobile!));
    }
    final classeEnergetica = criteri.classeEnergetica;
    if (classeEnergetica!=null && classeEnergetica.codClasseEnergetica != null){
      qBuilderImmobili.link(Immobile_.classeEnergetica, ClasseEnergetica_.codClasseEnergetica.equals(classeEnergetica.codClasseEnergetica!));
    }

    return qBuilderImmobili
        .watch(triggerImmediately: true)
    // Map it to a list of tasks to be used by a StreamBuilder.
        .map((query) => query.find());
  }
  // AnagraficaBox

  static void _putAnagraficaInTx(Store store, List<Anagrafica> anagrafica) =>
      store.box<Anagrafica>().putMany(anagrafica);

  Future<void> addAnagrafica(Anagrafica c1) async {

    List<AsyncTask> _taskTypeRegister() => [SaveAnagrafica(c1,store)];

    var asyncExecutor = AsyncExecutor(
      sequential: true, // Non-sequential tasks.
      parallelism: 0, // Concurrency with 2 threads.
      taskTypeRegister: _taskTypeRegister, // The top-level function to register the tasks types.
    );
    asyncExecutor.execute(SaveAnagrafica(c1, store));
  }
      // store.runInTransactionAsync(TxMode.write, _addAnagraficaInTx, c1);

  static void _addAnagraficaInTx(Store store, Anagrafica c1) {
    store.box<Anagrafica>().put(c1);
  }

  void removeAnagrafica(int codAnagrafica) {
    anagraficaBox.remove(codAnagrafica);
  }

  Anagrafica? getAnagrafica(int codAnagrafica) {
    anagraficaBox.get(codAnagrafica);
  }
  void removeAnagraficaEntity(Anagrafica anagrafica){
    store.runInTransaction(TxMode.write, () => {

      anagrafica.colloqui.forEach((element) {
        colloquioBox.remove(element.codColloquio??0);
      }),
      anagrafica.colloqui.removeRange(0, anagrafica.colloqui.length),
      anagrafica.colloqui.applyToDb(),

      anagrafica.contatti.forEach((element) {
        contattoBox.remove(element.codContatto??0);
      }),
      anagrafica.contatti.removeRange(0, anagrafica.contatti.length),
      anagrafica.contatti.applyToDb(),

      anagraficaBox.remove(anagrafica.codAnagrafica??0)
    });
  }

  Stream<List<Anagrafica>> getAnagrafiche({List<int> notin=const []}) {
    // Query for all tasks, sorted by their date.
    // https://docs.objectbox.io/queries
    QueryBuilder<Anagrafica> qBuilderTasks;
    if (notin==null) {
      qBuilderTasks = anagraficaBox.query()
        ..order(Anagrafica_.codAnagrafica, flags: Order.descending);
    }else{
      qBuilderTasks = anagraficaBox.query(Anagrafica_.codAnagrafica.notOneOf(notin!))
        ..order(Anagrafica_.codAnagrafica, flags: Order.descending);
    }
    // Build and watch the query,
    // set triggerImmediately to emit the query immediately on listen.
    return qBuilderTasks
        .watch(triggerImmediately: true)
    // Map it to a list of tasks to be used by a StreamBuilder.
        .map((query) => query.find());
  }

  Stream<List<Anagrafica>> searchAnagrafiche({required CriteriRicercaAnagrafica criteri}){

    QueryBuilder<Anagrafica> qBuilderAnagrafiche = anagraficaBox.query(
        ((criteri.indirizzo!='')?Anagrafica_.indirizzo.contains(criteri.indirizzo):Anagrafica_.indirizzo.notNull()) &
        ((criteri.provincia!='')?Anagrafica_.provincia.contains(criteri.provincia):Anagrafica_.provincia.notNull()) &
        ((criteri.cap!='')?Anagrafica_.cap.contains(criteri.cap):Anagrafica_.cap.notNull()) &
        ((criteri.citta!='')?Anagrafica_.citta.contains(criteri.citta):Anagrafica_.citta.notNull()) &
        ((criteri.cognome!='')?Anagrafica_.cognome.contains(criteri.cognome):Anagrafica_.cognome.notNull()) &
        ((criteri.nome!='')?Anagrafica_.nome.contains(criteri.nome):Anagrafica_.nome.notNull()) &
        ((criteri.ragioneSociale!='')?Anagrafica_.ragioneSociale.contains(criteri.ragioneSociale):Anagrafica_.ragioneSociale.notNull())
    );

    final classeCliente = criteri.classeCliente;
    if (classeCliente!=null && classeCliente.codClasseCliente != null){
      qBuilderAnagrafiche.link(Anagrafica_.classeCliente, ClasseCliente_.codClasseCliente.equals(classeCliente.codClasseCliente!));
    }

    return qBuilderAnagrafiche
        .watch(triggerImmediately: true)
    // Map it to a list of tasks to be used by a StreamBuilder.
        .map((query) => query.find());
  }
  // Stream<List<Anagrafica>> getAnagrafichePropieta({int codImmobile=0}) {
  //   // Query for all tasks, sorted by their date.
  //   // https://docs.objectbox.io/queries
  //   QueryBuilder<Anagrafica> qBuilderTasks;
  //   qBuilderTasks = anagraficaBox.query();
  //   qBuilderTasks.linkMany(Anagrafica_.proprieta, Immobile_.codImmobile.equals(codImmobile));
  //   qBuilderTasks.order(Anagrafica_.codAnagrafica, flags: Order.descending);
  //   // Build and watch the query,
  //   // set triggerImmediately to emit the query immediately on listen.
  //   return qBuilderTasks
  //       .watch(triggerImmediately: true)
  //   // Map it to a list of tasks to be used by a StreamBuilder.
  //       .map((query) => query.find());
  // }
}

class SaveImmobile extends AsyncTask<Immobile, void>{

  final Immobile immobile;
  final Store store;

  SaveImmobile(this.immobile, this.store);

  @override
  AsyncTask<Immobile, void> instantiate(Immobile parameters, [Map<String, SharedData>? sharedData]) {
    return SaveImmobile(parameters, store);
  }

  @override
  Immobile parameters() {
    return immobile;
  }

  @override
  FutureOr<void> run() {
    store.box<Immobile>().put(immobile);
  }

}

class SaveAnagrafica extends AsyncTask<Anagrafica, void>{

  final Anagrafica anagrafica;
  final Store store;

  SaveAnagrafica(this.anagrafica, this.store);

  @override
  AsyncTask<Anagrafica, void> instantiate(Anagrafica parameters, [Map<String, SharedData>? sharedData]) {
    return SaveAnagrafica(parameters, store);
  }

  @override
  Anagrafica parameters() {
    return anagrafica;
  }

  @override
  FutureOr<void> run() {
    store.box<Anagrafica>().put(anagrafica);
  }

}
