import { createHash } from 'node:crypto'
import { existsSync, mkdirSync, readdirSync, readFileSync, writeFileSync } from 'node:fs'
import { resolve } from 'node:path'

const api = resolve(process.argv[2] || '../chaye_API')
const apiCommit = process.argv[3]
if (!apiCommit || !/^[0-9a-f]{40}$/.test(apiCommit)) {
  throw new Error('A full API commit SHA is required as the second argument')
}
const required = ['docker-compose.yml', 'database/migrations', 'database/schema.ts']
for (const path of required) {
  if (!existsSync(resolve(api, path))) throw new Error(`API source missing: ${path}`)
}

const sha256 = (path) => createHash('sha256').update(readFileSync(resolve(api, path))).digest('hex')
const manifest = {
  repository: 'Chaye-parcel-traveler/chaye_API',
  commit: apiCommit,
  dockerComposeSha256: sha256('docker-compose.yml'),
  schemaSha256: sha256('database/schema.ts'),
  migrations: readdirSync(resolve(api, 'database/migrations')).filter((name) => name.endsWith('.ts')).sort(),
}

mkdirSync('generated', { recursive: true })
writeFileSync('generated/api-manifest.json', `${JSON.stringify(manifest, null, 2)}\n`)
