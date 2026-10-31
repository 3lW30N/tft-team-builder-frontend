# API contract — TFT Team Builder

The frontend uses the Spring Boot API in the sibling `tft-team-builder` repository.

## Reference data

- `GET /unit/all`: units with `id`, `name`, `cost`, and `imageLink`.
- `GET /item/all`: items with `id`, `name`, and `imageLink`.
- `GET /trait/all`: all traits.
- `GET /traits/all`: `{ unitId, traitIds }[]` for the comp detail page.
- `GET /traits/{unitId}`: traits for one unit (fallback for older API versions).

## Compositions

- `GET /comp/all`: compositions with nested builds.
- `GET /comp/{id}`: one composition.
- `POST /comp/match`: ranked compositions for the player's board.

Example request:

```json
{
  "units": [{ "unitId": "Aphelios", "stars": 2 }],
  "itemIds": ["Deathblade", "GuinsoosRageblade"]
}
```

Each response entry contains `comp`, `score` (0–100), `matchedUnits`,
`missingUnits`, and `reasons`. The API sorts entries by descending score.
Scoring uses champion overlap (60%, carries weighted twice), trait overlap
(25%), and item overlap (15%, with duplicate items counted separately).

The frontend sends the board's item pool independently from champion slots.
Each matched 2-star unit adds 1 point, and each matched 3-star unit adds 2
points. The star bonus is capped at 5 points, and the final score at 100.
