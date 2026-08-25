# Chaye database

Ce dépôt décrit la responsabilité base de données et l'infrastructure MariaDB
utilisées par `chaye_API`. Les migrations applicatives restent dans
`chaye_API/database/migrations`; elles ne sont pas dupliquées ici.

## Configuration actuelle

- MariaDB 11, identique au service CI de l'API;
- port hôte `3307` par défaut, port conteneur `3306`;
- volume nommé persistant `mariadb-data`;
- healthcheck MariaDB officiel;
- phpMyAdmin optionnel via le profil `tools`;
- aucun mot de passe réel versionné.

## Démarrage local

```bash
cp .env.example .env
# Remplacer les deux mots de passe d'exemple.
docker compose config
docker compose up --wait db
```

Pour lancer aussi phpMyAdmin :

```bash
docker compose --profile tools up --wait
```

L'API doit utiliser `MYSQL_HOST=db` lorsqu'elle rejoint ce réseau Compose, ou
`127.0.0.1` et `MYSQL_PORT=3307` lorsqu'elle tourne sur l'hôte.

## Source de vérité et dérive

Le manifeste `generated/api-manifest.json` référence le commit API audité. Le
workflow `database-drift.yml` le recalcule depuis le dépôt public de l'API et
ouvre une PR si la mise à jour est déterministe. Si l'API est inaccessible ou
si une décision d'architecture est nécessaire, le workflow ouvre une issue et
ne modifie jamais la branche principale.
