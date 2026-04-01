export default function ResultsTable({ columns, rows }) {
  if (!columns.length) return <p style={{ color: '#888' }}>La query no devolvio columnas.</p>;

  return (
    <div style={styles.wrapper}>
      <p style={styles.meta}>{rows.length} fila{rows.length !== 1 ? 's' : ''} devuelta{rows.length !== 1 ? 's' : ''}</p>
      <div style={styles.scroll}>
        <table style={styles.table}>
          <thead>
            <tr>{columns.map(c => <th key={c} style={styles.th}>{c}</th>)}</tr>
          </thead>
          <tbody>
            {rows.map((row, i) => (
              <tr key={i} style={i % 2 === 0 ? styles.rowEven : styles.rowOdd}>
                {columns.map(c => (
                  <td key={c} style={styles.td}>
                    {row[c] === null
                      ? <span style={styles.null}>NULL</span>
                      : String(row[c])}
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

const styles = {
  wrapper: { marginTop: 16 },
  meta:    { color: '#888', fontSize: 12, marginBottom: 4 },
  scroll:  { overflowX: 'auto' },
  table:   { borderCollapse: 'collapse', width: '100%', fontSize: 13 },
  th:      {
    background: '#1a1a2e', color: '#e94560', padding: '8px 12px',
    textAlign: 'left', borderBottom: '2px solid #e94560', whiteSpace: 'nowrap',
  },
  td:      { padding: '6px 12px', borderBottom: '1px solid #eee', whiteSpace: 'nowrap' },
  rowEven: { background: '#fafafa' },
  rowOdd:  { background: '#fff' },
  null:    { color: '#aaa', fontStyle: 'italic' },
};
