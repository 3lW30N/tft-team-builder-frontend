# TFT Team Builder — frontend

Application Angular 22 pour saisir les champions et les items du joueur, puis afficher les compositions TFT les plus proches. Le calcul des scores est effectué par l'API Spring Boot du dépôt voisin `tft-team-builder`.

## Démarrage

Démarre d'abord PostgreSQL et l'API comme indiqué dans le README du backend (`docker compose up -d --build`, puis `./mvnw spring-boot:run`). Ensuite :

```powershell
npm install
npm start
```

Le site est disponible sur `http://localhost:4200`. `proxy.conf.json` redirige `/api/**` vers `localhost:8080` en retirant `/api`, et `/img/**` vers les images servies par le backend. `npm run build` crée le bundle dans `dist/frontend`. Le serveur `npm start` surveille les fichiers et recharge le front pendant le développement.

## Fonctionnement

- Le plateau est conservé dans `BoardStore` et peut être partagé par le paramètre `?board=` (`unitId.stars,...|itemId,...`). Les items constituent un pool libre; ils ne sont pas liés à un champion.
- L'écran des résultats envoie ce plateau à `POST /comp/match`. L'API renvoie les compositions triées, les scores, les champions présents ou manquants et les raisons du classement. Les étoiles des champions communs apportent un petit bonus au score (5 points maximum). Il n'y a plus de moteur de classement dans le front.
- L'écran de détail charge les compositions via `GET /comp/all` et les traits des champions via `GET /traits/all` (avec recours à `GET /traits/{unitId}` si nécessaire).
- `ApiService` normalise les réponses du backend pour les composants Angular. Le contrat complet figure dans [API_REQUIREMENTS.md](API_REQUIREMENTS.md).

## Vérification

```powershell
npm run build
```

Pour vérifier le parcours, ajoute un champion et un item, ouvre les résultats et vérifie que le détail de la première composition s'affiche. Le skill `test-tft-project` du dépôt backend décrit les tests des deux dépôts.
