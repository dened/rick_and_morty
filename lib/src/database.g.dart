// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class KvTable extends Table with TableInfo<KvTable, KvTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  KvTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kMeta = const VerificationMeta('k');
  late final GeneratedColumn<String> k = GeneratedColumn<String>(
    'k',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _vstringMeta = const VerificationMeta(
    'vstring',
  );
  late final GeneratedColumn<String> vstring = GeneratedColumn<String>(
    'vstring',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _vintMeta = const VerificationMeta('vint');
  late final GeneratedColumn<int> vint = GeneratedColumn<int>(
    'vint',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _vfloatMeta = const VerificationMeta('vfloat');
  late final GeneratedColumn<double> vfloat = GeneratedColumn<double>(
    'vfloat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _vboolMeta = const VerificationMeta('vbool');
  late final GeneratedColumn<int> vbool = GeneratedColumn<int>(
    'vbool',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _metaCreatedAtMeta = const VerificationMeta(
    'metaCreatedAt',
  );
  late final GeneratedColumn<int> metaCreatedAt = GeneratedColumn<int>(
    'meta_created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
    defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'),
  );
  static const VerificationMeta _metaUpdatedAtMeta = const VerificationMeta(
    'metaUpdatedAt',
  );
  late final GeneratedColumn<int> metaUpdatedAt = GeneratedColumn<int>(
    'meta_updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (strftime(\'%s\', \'now\')) CHECK (meta_updated_at >= meta_created_at)',
    defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    k,
    vstring,
    vint,
    vfloat,
    vbool,
    metaCreatedAt,
    metaUpdatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kv_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<KvTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('k')) {
      context.handle(_kMeta, k.isAcceptableOrUnknown(data['k']!, _kMeta));
    } else if (isInserting) {
      context.missing(_kMeta);
    }
    if (data.containsKey('vstring')) {
      context.handle(
        _vstringMeta,
        vstring.isAcceptableOrUnknown(data['vstring']!, _vstringMeta),
      );
    }
    if (data.containsKey('vint')) {
      context.handle(
        _vintMeta,
        vint.isAcceptableOrUnknown(data['vint']!, _vintMeta),
      );
    }
    if (data.containsKey('vfloat')) {
      context.handle(
        _vfloatMeta,
        vfloat.isAcceptableOrUnknown(data['vfloat']!, _vfloatMeta),
      );
    }
    if (data.containsKey('vbool')) {
      context.handle(
        _vboolMeta,
        vbool.isAcceptableOrUnknown(data['vbool']!, _vboolMeta),
      );
    }
    if (data.containsKey('meta_created_at')) {
      context.handle(
        _metaCreatedAtMeta,
        metaCreatedAt.isAcceptableOrUnknown(
          data['meta_created_at']!,
          _metaCreatedAtMeta,
        ),
      );
    }
    if (data.containsKey('meta_updated_at')) {
      context.handle(
        _metaUpdatedAtMeta,
        metaUpdatedAt.isAcceptableOrUnknown(
          data['meta_updated_at']!,
          _metaUpdatedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {k};
  @override
  KvTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KvTableData(
      k: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}k'],
      )!,
      vstring: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vstring'],
      ),
      vint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vint'],
      ),
      vfloat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vfloat'],
      ),
      vbool: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vbool'],
      ),
      metaCreatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meta_created_at'],
      )!,
      metaUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meta_updated_at'],
      )!,
    );
  }

  @override
  KvTable createAlias(String alias) {
    return KvTable(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  bool get dontWriteConstraints => true;
}

class KvTableData extends DataClass implements Insertable<KvTableData> {
  /// req Key is the key of the key-value pair
  final String k;

  /// string
  final String? vstring;

  /// int
  final int? vint;

  /// float
  final double? vfloat;

  /// bool
  final int? vbool;

  ///req Created date(unixtime in seconds)
  final int metaCreatedAt;

  ///req Updated date(unixtime in seconds)
  final int metaUpdatedAt;
  const KvTableData({
    required this.k,
    this.vstring,
    this.vint,
    this.vfloat,
    this.vbool,
    required this.metaCreatedAt,
    required this.metaUpdatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['k'] = Variable<String>(k);
    if (!nullToAbsent || vstring != null) {
      map['vstring'] = Variable<String>(vstring);
    }
    if (!nullToAbsent || vint != null) {
      map['vint'] = Variable<int>(vint);
    }
    if (!nullToAbsent || vfloat != null) {
      map['vfloat'] = Variable<double>(vfloat);
    }
    if (!nullToAbsent || vbool != null) {
      map['vbool'] = Variable<int>(vbool);
    }
    map['meta_created_at'] = Variable<int>(metaCreatedAt);
    map['meta_updated_at'] = Variable<int>(metaUpdatedAt);
    return map;
  }

  KvTableCompanion toCompanion(bool nullToAbsent) {
    return KvTableCompanion(
      k: Value(k),
      vstring: vstring == null && nullToAbsent
          ? const Value.absent()
          : Value(vstring),
      vint: vint == null && nullToAbsent ? const Value.absent() : Value(vint),
      vfloat: vfloat == null && nullToAbsent
          ? const Value.absent()
          : Value(vfloat),
      vbool: vbool == null && nullToAbsent
          ? const Value.absent()
          : Value(vbool),
      metaCreatedAt: Value(metaCreatedAt),
      metaUpdatedAt: Value(metaUpdatedAt),
    );
  }

  factory KvTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KvTableData(
      k: serializer.fromJson<String>(json['k']),
      vstring: serializer.fromJson<String?>(json['vstring']),
      vint: serializer.fromJson<int?>(json['vint']),
      vfloat: serializer.fromJson<double?>(json['vfloat']),
      vbool: serializer.fromJson<int?>(json['vbool']),
      metaCreatedAt: serializer.fromJson<int>(json['meta_created_at']),
      metaUpdatedAt: serializer.fromJson<int>(json['meta_updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'k': serializer.toJson<String>(k),
      'vstring': serializer.toJson<String?>(vstring),
      'vint': serializer.toJson<int?>(vint),
      'vfloat': serializer.toJson<double?>(vfloat),
      'vbool': serializer.toJson<int?>(vbool),
      'meta_created_at': serializer.toJson<int>(metaCreatedAt),
      'meta_updated_at': serializer.toJson<int>(metaUpdatedAt),
    };
  }

  KvTableData copyWith({
    String? k,
    Value<String?> vstring = const Value.absent(),
    Value<int?> vint = const Value.absent(),
    Value<double?> vfloat = const Value.absent(),
    Value<int?> vbool = const Value.absent(),
    int? metaCreatedAt,
    int? metaUpdatedAt,
  }) => KvTableData(
    k: k ?? this.k,
    vstring: vstring.present ? vstring.value : this.vstring,
    vint: vint.present ? vint.value : this.vint,
    vfloat: vfloat.present ? vfloat.value : this.vfloat,
    vbool: vbool.present ? vbool.value : this.vbool,
    metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
    metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
  );
  KvTableData copyWithCompanion(KvTableCompanion data) {
    return KvTableData(
      k: data.k.present ? data.k.value : this.k,
      vstring: data.vstring.present ? data.vstring.value : this.vstring,
      vint: data.vint.present ? data.vint.value : this.vint,
      vfloat: data.vfloat.present ? data.vfloat.value : this.vfloat,
      vbool: data.vbool.present ? data.vbool.value : this.vbool,
      metaCreatedAt: data.metaCreatedAt.present
          ? data.metaCreatedAt.value
          : this.metaCreatedAt,
      metaUpdatedAt: data.metaUpdatedAt.present
          ? data.metaUpdatedAt.value
          : this.metaUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KvTableData(')
          ..write('k: $k, ')
          ..write('vstring: $vstring, ')
          ..write('vint: $vint, ')
          ..write('vfloat: $vfloat, ')
          ..write('vbool: $vbool, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    k,
    vstring,
    vint,
    vfloat,
    vbool,
    metaCreatedAt,
    metaUpdatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KvTableData &&
          other.k == this.k &&
          other.vstring == this.vstring &&
          other.vint == this.vint &&
          other.vfloat == this.vfloat &&
          other.vbool == this.vbool &&
          other.metaCreatedAt == this.metaCreatedAt &&
          other.metaUpdatedAt == this.metaUpdatedAt);
}

class KvTableCompanion extends UpdateCompanion<KvTableData> {
  final Value<String> k;
  final Value<String?> vstring;
  final Value<int?> vint;
  final Value<double?> vfloat;
  final Value<int?> vbool;
  final Value<int> metaCreatedAt;
  final Value<int> metaUpdatedAt;
  final Value<int> rowid;
  const KvTableCompanion({
    this.k = const Value.absent(),
    this.vstring = const Value.absent(),
    this.vint = const Value.absent(),
    this.vfloat = const Value.absent(),
    this.vbool = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KvTableCompanion.insert({
    required String k,
    this.vstring = const Value.absent(),
    this.vint = const Value.absent(),
    this.vfloat = const Value.absent(),
    this.vbool = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : k = Value(k);
  static Insertable<KvTableData> custom({
    Expression<String>? k,
    Expression<String>? vstring,
    Expression<int>? vint,
    Expression<double>? vfloat,
    Expression<int>? vbool,
    Expression<int>? metaCreatedAt,
    Expression<int>? metaUpdatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (k != null) 'k': k,
      if (vstring != null) 'vstring': vstring,
      if (vint != null) 'vint': vint,
      if (vfloat != null) 'vfloat': vfloat,
      if (vbool != null) 'vbool': vbool,
      if (metaCreatedAt != null) 'meta_created_at': metaCreatedAt,
      if (metaUpdatedAt != null) 'meta_updated_at': metaUpdatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KvTableCompanion copyWith({
    Value<String>? k,
    Value<String?>? vstring,
    Value<int?>? vint,
    Value<double?>? vfloat,
    Value<int?>? vbool,
    Value<int>? metaCreatedAt,
    Value<int>? metaUpdatedAt,
    Value<int>? rowid,
  }) {
    return KvTableCompanion(
      k: k ?? this.k,
      vstring: vstring ?? this.vstring,
      vint: vint ?? this.vint,
      vfloat: vfloat ?? this.vfloat,
      vbool: vbool ?? this.vbool,
      metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
      metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (k.present) {
      map['k'] = Variable<String>(k.value);
    }
    if (vstring.present) {
      map['vstring'] = Variable<String>(vstring.value);
    }
    if (vint.present) {
      map['vint'] = Variable<int>(vint.value);
    }
    if (vfloat.present) {
      map['vfloat'] = Variable<double>(vfloat.value);
    }
    if (vbool.present) {
      map['vbool'] = Variable<int>(vbool.value);
    }
    if (metaCreatedAt.present) {
      map['meta_created_at'] = Variable<int>(metaCreatedAt.value);
    }
    if (metaUpdatedAt.present) {
      map['meta_updated_at'] = Variable<int>(metaUpdatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KvTableCompanion(')
          ..write('k: $k, ')
          ..write('vstring: $vstring, ')
          ..write('vint: $vint, ')
          ..write('vfloat: $vfloat, ')
          ..write('vbool: $vbool, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final KvTable kvTable = KvTable(this);
  late final Index kvMetaCreatedAtIdx = Index(
    'kv_meta_created_at_idx',
    'CREATE INDEX IF NOT EXISTS kv_meta_created_at_idx ON kv_table (meta_created_at)',
  );
  late final Index kvMetaUpdatedAtIdx = Index(
    'kv_meta_updated_at_idx',
    'CREATE INDEX IF NOT EXISTS kv_meta_updated_at_idx ON kv_table (meta_updated_at)',
  );
  late final Trigger kvTableUpdateTrigger = Trigger(
    'CREATE TRIGGER IF NOT EXISTS kv_table_update_trigger AFTER UPDATE ON kv_table BEGIN UPDATE kv_table SET meta_updated_at = strftime(\'%s\', \'now\') WHERE k = NEW.k;END',
    'kv_table_update_trigger',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    kvTable,
    kvMetaCreatedAtIdx,
    kvMetaUpdatedAtIdx,
    kvTableUpdateTrigger,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'kv_table',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('kv_table', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $KvTableCreateCompanionBuilder =
    KvTableCompanion Function({
      required String k,
      Value<String?> vstring,
      Value<int?> vint,
      Value<double?> vfloat,
      Value<int?> vbool,
      Value<int> metaCreatedAt,
      Value<int> metaUpdatedAt,
      Value<int> rowid,
    });
typedef $KvTableUpdateCompanionBuilder =
    KvTableCompanion Function({
      Value<String> k,
      Value<String?> vstring,
      Value<int?> vint,
      Value<double?> vfloat,
      Value<int?> vbool,
      Value<int> metaCreatedAt,
      Value<int> metaUpdatedAt,
      Value<int> rowid,
    });

class $KvTableFilterComposer extends Composer<_$Database, KvTable> {
  $KvTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get k => $composableBuilder(
    column: $table.k,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vstring => $composableBuilder(
    column: $table.vstring,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vint => $composableBuilder(
    column: $table.vint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vfloat => $composableBuilder(
    column: $table.vfloat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vbool => $composableBuilder(
    column: $table.vbool,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get metaCreatedAt => $composableBuilder(
    column: $table.metaCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get metaUpdatedAt => $composableBuilder(
    column: $table.metaUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $KvTableOrderingComposer extends Composer<_$Database, KvTable> {
  $KvTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get k => $composableBuilder(
    column: $table.k,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vstring => $composableBuilder(
    column: $table.vstring,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vint => $composableBuilder(
    column: $table.vint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vfloat => $composableBuilder(
    column: $table.vfloat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vbool => $composableBuilder(
    column: $table.vbool,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get metaCreatedAt => $composableBuilder(
    column: $table.metaCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get metaUpdatedAt => $composableBuilder(
    column: $table.metaUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $KvTableAnnotationComposer extends Composer<_$Database, KvTable> {
  $KvTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get k =>
      $composableBuilder(column: $table.k, builder: (column) => column);

  GeneratedColumn<String> get vstring =>
      $composableBuilder(column: $table.vstring, builder: (column) => column);

  GeneratedColumn<int> get vint =>
      $composableBuilder(column: $table.vint, builder: (column) => column);

  GeneratedColumn<double> get vfloat =>
      $composableBuilder(column: $table.vfloat, builder: (column) => column);

  GeneratedColumn<int> get vbool =>
      $composableBuilder(column: $table.vbool, builder: (column) => column);

  GeneratedColumn<int> get metaCreatedAt => $composableBuilder(
    column: $table.metaCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get metaUpdatedAt => $composableBuilder(
    column: $table.metaUpdatedAt,
    builder: (column) => column,
  );
}

class $KvTableTableManager
    extends
        RootTableManager<
          _$Database,
          KvTable,
          KvTableData,
          $KvTableFilterComposer,
          $KvTableOrderingComposer,
          $KvTableAnnotationComposer,
          $KvTableCreateCompanionBuilder,
          $KvTableUpdateCompanionBuilder,
          (KvTableData, BaseReferences<_$Database, KvTable, KvTableData>),
          KvTableData,
          PrefetchHooks Function()
        > {
  $KvTableTableManager(_$Database db, KvTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $KvTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $KvTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $KvTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> k = const Value.absent(),
                Value<String?> vstring = const Value.absent(),
                Value<int?> vint = const Value.absent(),
                Value<double?> vfloat = const Value.absent(),
                Value<int?> vbool = const Value.absent(),
                Value<int> metaCreatedAt = const Value.absent(),
                Value<int> metaUpdatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KvTableCompanion(
                k: k,
                vstring: vstring,
                vint: vint,
                vfloat: vfloat,
                vbool: vbool,
                metaCreatedAt: metaCreatedAt,
                metaUpdatedAt: metaUpdatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String k,
                Value<String?> vstring = const Value.absent(),
                Value<int?> vint = const Value.absent(),
                Value<double?> vfloat = const Value.absent(),
                Value<int?> vbool = const Value.absent(),
                Value<int> metaCreatedAt = const Value.absent(),
                Value<int> metaUpdatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KvTableCompanion.insert(
                k: k,
                vstring: vstring,
                vint: vint,
                vfloat: vfloat,
                vbool: vbool,
                metaCreatedAt: metaCreatedAt,
                metaUpdatedAt: metaUpdatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $KvTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      KvTable,
      KvTableData,
      $KvTableFilterComposer,
      $KvTableOrderingComposer,
      $KvTableAnnotationComposer,
      $KvTableCreateCompanionBuilder,
      $KvTableUpdateCompanionBuilder,
      (KvTableData, BaseReferences<_$Database, KvTable, KvTableData>),
      KvTableData,
      PrefetchHooks Function()
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $KvTableTableManager get kvTable => $KvTableTableManager(_db, _db.kvTable);
}
