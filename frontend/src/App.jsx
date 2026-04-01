import { useState, useEffect } from 'react';
import QueryEditor from './components/QueryEditor';
import ResultsTable from './components/ResultsTable';
import QueryHistory from './components/QueryHistory';
import SchemaExplorer from './components/SchemaExplorer';

const STARTER = `-- Prueba algunos queries
SELECT a.title, ar.name AS artist, g.name AS genre, a.price
FROM albums a
JOIN artists ar ON ar.id = a.artist_id
JOIN genres  g  ON g.id  = a.genre_id
ORDER BY a.price DESC;`;

export default function App() {
  const [tab, setTab]         = useState('editor');
  const [sql, setSql]         = useState(STARTER);
  const [results, setResults] = useState([]);
  const [error, setError]     = useState(null);
  const [loading, setLoading] = useState(false);
  const [history, setHistory] = useState(() => {
    try { return JSON.parse(localStorage.getItem('sql_history') || '[]'); }
    catch { return []; }
  });

  useEffect(() => {
    localStorage.setItem('sql_history', JSON.stringify(history));
  }, [history]);

  async function runQuery() {
    if (!sql.trim()) return;
    setLoading(true);
    setError(null);
    setResults([]);

    try {
      const res = await fetch('/api/query', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ sql }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || 'Error desconocido');
      setResults(data.results);
      setHistory(prev =>
        [{ sql, ts: new Date().toLocaleTimeString() }, ...prev].slice(0, 20)
      );
    } catch (e) {
      setError(e.message);
    } finally {
      setLoading(false);
    }
  }

  function deleteHistoryItem(i) {
    setHistory(prev => prev.filter((_, idx) => idx !== i));
  }

  return (
    <div style={styles.app}>
      <h1 style={styles.title}>Vinyl Vault — SQL Practice</h1>

      <div style={styles.tabs}>
        <button
          style={tab === 'editor' ? styles.tabActive : styles.tab}
          onClick={() => setTab('editor')}
        >Editor</button>
        <button
          style={tab === 'schema' ? styles.tabActive : styles.tab}
          onClick={() => setTab('schema')}
        >Esquema</button>
      </div>

      {tab === 'editor' && (
        <div style={styles.layout}>
          <div style={styles.left}>
            <QueryEditor sql={sql} onChange={setSql} onRun={runQuery} loading={loading} />
            {error && <pre style={styles.error}>{error}</pre>}
            {results.map((r, i) => (
              <div key={i} style={styles.resultBlock}>
                {results.length > 1 && (
                  <p style={styles.stmtLabel}>
                    Query {i + 1}: <code>{r.sql.slice(0, 60)}{r.sql.length > 60 ? '...' : ''}</code>
                  </p>
                )}
                {r.error
                  ? <pre style={styles.error}>{r.error}</pre>
                  : <ResultsTable columns={r.columns} rows={r.rows} />
                }
              </div>
            ))}
          </div>
          <div style={styles.right}>
            <QueryHistory history={history} onSelect={setSql} onDelete={deleteHistoryItem} />
          </div>
        </div>
      )}

      {tab === 'schema' && <SchemaExplorer />}
    </div>
  );
}

const styles = {
  app:         { fontFamily: 'monospace', maxWidth: 1200, margin: '0 auto', padding: 20 },
  title:       { color: '#1a1a2e', borderBottom: '2px solid #e94560', paddingBottom: 8, margin: '0 0 0' },
  tabs:        { display: 'flex', gap: 4, margin: '16px 0' },
  tab:         {
    padding: '8px 20px', border: '1px solid #ddd', borderRadius: '4px 4px 0 0',
    background: '#f7f7f7', cursor: 'pointer', fontFamily: 'monospace', fontSize: 13, color: '#666',
  },
  tabActive:   {
    padding: '8px 20px', border: '1px solid #e94560', borderBottom: '1px solid #fff',
    borderRadius: '4px 4px 0 0', background: '#fff', cursor: 'pointer',
    fontFamily: 'monospace', fontSize: 13, color: '#e94560', fontWeight: 'bold',
  },
  layout:      { display: 'flex', gap: 20, alignItems: 'flex-start' },
  left:        { flex: 1, minWidth: 0 },
  right:       { width: 280, flexShrink: 0 },
  resultBlock: { marginTop: 16 },
  stmtLabel:   { fontSize: 12, color: '#888', marginBottom: 4 },
  error:       {
    background: '#fff0f0', border: '1px solid #e94560', color: '#c0392b',
    padding: 12, borderRadius: 4, overflowX: 'auto', marginTop: 12,
  },
};
