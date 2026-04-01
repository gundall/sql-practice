export default function QueryHistory({ history, onSelect, onDelete }) {
  return (
    <div style={styles.panel}>
      <h3 style={styles.heading}>Historial</h3>
      {history.length === 0
        ? <p style={styles.empty}>Aun no hay queries.</p>
        : history.map((item, i) => (
            <div key={i} style={styles.item} onClick={() => onSelect(item.sql)}>
              <div style={styles.itemHeader}>
                <span style={styles.time}>{item.ts}</span>
                <button
                  style={styles.deleteBtn}
                  onClick={e => { e.stopPropagation(); onDelete(i); }}
                  title="Eliminar"
                >×</button>
              </div>
              <pre style={styles.snippet}>
                {item.sql.slice(0, 80)}{item.sql.length > 80 ? '...' : ''}
              </pre>
            </div>
          ))
      }
    </div>
  );
}

const styles = {
  panel:      { background: '#f7f7f7', border: '1px solid #ddd', borderRadius: 4, padding: 12 },
  heading:    {
    margin: '0 0 12px', fontSize: 14, color: '#1a1a2e',
    textTransform: 'uppercase', letterSpacing: 1,
  },
  empty:      { color: '#aaa', fontSize: 12 },
  item:       { cursor: 'pointer', padding: '6px 0', borderBottom: '1px solid #eee' },
  itemHeader: { display: 'flex', justifyContent: 'space-between', alignItems: 'center' },
  time:       { fontSize: 10, color: '#aaa' },
  deleteBtn:  {
    background: 'none', border: 'none', color: '#aaa', cursor: 'pointer',
    fontSize: 14, lineHeight: 1, padding: '0 2px',
  },
  snippet:    {
    margin: '2px 0 0', fontSize: 11, color: '#333',
    whiteSpace: 'pre-wrap', wordBreak: 'break-all',
  },
};
