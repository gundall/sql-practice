import { useEffect, useState } from 'react';

export default function SchemaExplorer() {
  const [schema, setSchema] = useState(null);
  const [error, setError]   = useState(null);

  useEffect(() => {
    fetch('/api/schema')
      .then(r => r.json())
      .then(data => {
        if (data.error) throw new Error(data.error);

        // Agrupar columnas por tabla
        const tables = {};
        for (const col of data.columns) {
          if (!tables[col.TABLE_NAME]) tables[col.TABLE_NAME] = [];
          tables[col.TABLE_NAME].push(col);
        }

        // Indexar FKs: "tabla.columna" → "refTabla.refColumna"
        const fkMap = {};
        for (const fk of data.fks) {
          fkMap[`${fk.TABLE_NAME}.${fk.COLUMN_NAME}`] =
            `${fk.REFERENCED_TABLE_NAME}.${fk.REFERENCED_COLUMN_NAME}`;
        }

        setSchema({ tables, fkMap });
      })
      .catch(e => setError(e.message));
  }, []);

  if (error)  return <pre style={styles.error}>{error}</pre>;
  if (!schema) return <p style={styles.loading}>Cargando esquema...</p>;

  return (
    <div style={styles.grid}>
      {Object.entries(schema.tables).map(([tableName, cols]) => (
        <div key={tableName} style={styles.table}>
          <div style={styles.tableHeader}>{tableName}</div>
          <table style={styles.colTable}>
            <tbody>
              {cols.map(col => {
                const fkRef = schema.fkMap[`${tableName}.${col.COLUMN_NAME}`];
                const isPK  = col.COLUMN_KEY === 'PRI';
                return (
                  <tr key={col.COLUMN_NAME} style={isPK ? styles.pkRow : undefined}>
                    <td style={styles.colName}>
                      {isPK && <span style={styles.pkBadge}>PK</span>}
                      {col.COLUMN_NAME}
                    </td>
                    <td style={styles.colType}>{col.COLUMN_TYPE}</td>
                    <td style={styles.colMeta}>
                      {col.IS_NULLABLE === 'NO' && <span style={styles.notNull}>NOT NULL</span>}
                      {fkRef && <span style={styles.fk}>→ {fkRef}</span>}
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      ))}
    </div>
  );
}

const styles = {
  grid:        { display: 'flex', flexWrap: 'wrap', gap: 20, marginTop: 16 },
  table:       { border: '1px solid #ddd', borderRadius: 4, overflow: 'hidden', minWidth: 280 },
  tableHeader: {
    background: '#1a1a2e', color: '#e94560', padding: '8px 12px',
    fontWeight: 'bold', fontSize: 14, letterSpacing: 1,
  },
  colTable:    { width: '100%', borderCollapse: 'collapse', fontSize: 12 },
  pkRow:       { background: '#fffbe6' },
  colName:     { padding: '5px 10px', fontFamily: 'monospace', color: '#1a1a2e' },
  colType:     { padding: '5px 10px', color: '#666', fontFamily: 'monospace' },
  colMeta:     { padding: '5px 10px' },
  pkBadge:     {
    background: '#e94560', color: '#fff', fontSize: 9, fontWeight: 'bold',
    borderRadius: 3, padding: '1px 4px', marginRight: 5,
  },
  notNull:     { color: '#aaa', fontSize: 10 },
  fk:          { color: '#2980b9', fontSize: 11, marginLeft: 4, fontFamily: 'monospace' },
  error:       {
    background: '#fff0f0', border: '1px solid #e94560', color: '#c0392b',
    padding: 12, borderRadius: 4,
  },
  loading:     { color: '#888' },
};
