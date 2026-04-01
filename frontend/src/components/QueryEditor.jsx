export default function QueryEditor({ sql, onChange, onRun, loading }) {
  function handleKey(e) {
    if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
      e.preventDefault();
      onRun();
    }
  }

  return (
    <div>
      <textarea
        value={sql}
        onChange={e => onChange(e.target.value)}
        onKeyDown={handleKey}
        rows={10}
        style={styles.textarea}
        placeholder="Escribe tu SQL aqui..."
        spellCheck={false}
      />
      <button onClick={onRun} disabled={loading} style={styles.button}>
        {loading ? 'Ejecutando...' : 'Ejecutar (Ctrl+Enter)'}
      </button>
    </div>
  );
}

const styles = {
  textarea: {
    width: '100%', boxSizing: 'border-box', fontFamily: 'monospace',
    fontSize: 14, padding: 12, border: '1px solid #ccc', borderRadius: 4,
    background: '#1e1e2e', color: '#cdd6f4', resize: 'vertical',
  },
  button: {
    marginTop: 8, padding: '10px 24px', background: '#e94560',
    color: '#fff', border: 'none', borderRadius: 4, cursor: 'pointer',
    fontSize: 14, fontFamily: 'monospace',
  },
};
