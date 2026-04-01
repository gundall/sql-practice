import express from 'express';
import cors from 'cors';
import mysql from 'mysql2/promise';

const app = express();
app.use(cors());
app.use(express.json());

const pool = mysql.createPool({
  host:               process.env.DB_HOST,
  port:               Number(process.env.DB_PORT) || 3306,
  database:           process.env.DB_NAME,
  user:               process.env.DB_USER,
  password:           process.env.DB_PASSWORD,
  waitForConnections: true,
  connectionLimit:    10,
});

function parseStatements(sql) {
  // Split by semicolons, preserving strings and comments (simple heuristic)
  const statements = [];
  let current = '';
  let inString = false;
  let stringChar = '';

  for (let i = 0; i < sql.length; i++) {
    const ch = sql[i];

    if (inString) {
      current += ch;
      if (ch === stringChar && sql[i - 1] !== '\\') inString = false;
    } else if (ch === '"' || ch === "'" || ch === '`') {
      inString = true;
      stringChar = ch;
      current += ch;
    } else if (ch === ';') {
      const stmt = current.trim();
      if (stmt) statements.push(stmt);
      current = '';
    } else {
      current += ch;
    }
  }
  const last = current.trim();
  if (last) statements.push(last);
  return statements;
}

app.post('/query', async (req, res) => {
  const { sql } = req.body;

  if (!sql || typeof sql !== 'string' || sql.trim() === '') {
    return res.status(400).json({ error: 'El campo sql es obligatorio.' });
  }

  const statements = parseStatements(sql);
  if (statements.length === 0) {
    return res.status(400).json({ error: 'No se encontraron statements SQL.' });
  }

  const results = [];

  for (const stmt of statements) {
    try {
      const [rows, fields] = await pool.execute(stmt);

      if (Array.isArray(rows)) {
        results.push({ sql: stmt, columns: fields ? fields.map(f => f.name) : [], rows });
      } else {
        results.push({
          sql: stmt,
          columns: ['affectedRows', 'insertId', 'info'],
          rows: [{ affectedRows: rows.affectedRows, insertId: rows.insertId, info: rows.info }],
        });
      }
    } catch (err) {
      results.push({ sql: stmt, error: err.message });
    }
  }

  return res.json({ results });
});

app.get('/schema', async (_req, res) => {
  const db = process.env.DB_NAME;
  try {
    const [columns] = await pool.execute(
      `SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE, IS_NULLABLE, COLUMN_KEY, EXTRA
       FROM information_schema.COLUMNS
       WHERE TABLE_SCHEMA = ?
       ORDER BY TABLE_NAME, ORDINAL_POSITION`, [db]);

    const [fks] = await pool.execute(
      `SELECT TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
       FROM information_schema.KEY_COLUMN_USAGE
       WHERE TABLE_SCHEMA = ? AND REFERENCED_TABLE_NAME IS NOT NULL`, [db]);

    res.json({ columns, fks });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/health', (_req, res) => res.json({ status: 'ok' }));

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => console.log(`Backend escuchando en :${PORT}`));
