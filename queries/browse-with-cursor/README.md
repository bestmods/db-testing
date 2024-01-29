This query is compiled and executed in the [`GetMods()`](https://github.com/bestmods/bestmods/blob/main/src/utils/content/mod.ts#L11) function when retrieving new mod rows as a user scroll downs on the [Browse](https://bestmods.io/browse) page

With that said, our static query used in this repository uses a cursor ID of `1000000` with no user ID set (same as the user not being signed into the website). The default `timeframe` date is set to `2024-01-28 11:47:48.889 UTC` in the queries. So it will calculate the mod's rating from after that date.

## Bottlenecks
### Rating Calculations
The most expensive operation in this query by far is retrieving the current mod's rating regardless of a timeframe specified. (see [`no-ratings`](./no-ratings/) and [`no-rating-timeframe`](./no-rating-timeframe/))

### Mod Source And Installer Subqueries
The subqueries to retrieve the mod's sources and installers (along with their source relation) is quite expensive as well. It is not nearly as bad as the rating calculations, though.

Adittionally, using `json_agg()` with a `LEFT JOIN` to retrieve the mod's sources and installers (along with their source relation) seems to make performance far worst **surprisingly** over the current subqueries. (see [`left-join-and-json-agg`](./left-join-and-json-agg/))

## Important Table Definitions
The following are important table definitions, indexes, and primary keys related to the queries in this repository. Please note that this is from the development database, but it should be similar on production. The Prisma schema for the website may be found [here](https://github.com/bestmods/bestmods/blob/main/prisma/schema.prisma).

### `ModRating`
```sql
  Column   |              Type              | Collation | Nullable |      Default
-----------+--------------------------------+-----------+----------+-------------------
 modId     | integer                        |           | not null |
 userId    | text                           |           | not null |
 createdAt | timestamp(3) without time zone |           | not null | CURRENT_TIMESTAMP
 positive  | boolean                        |           | not null | true
Indexes:
    "ModRating_pkey" PRIMARY KEY, btree ("modId", "userId")
    "ModRating_createdAt_idx" btree ("createdAt")
Foreign-key constraints:
    "ModRating_modId_fkey" FOREIGN KEY ("modId") REFERENCES "Mod"(id) ON UPDATE CASCADE ON DELETE CASCADE
    "ModRating_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON UPDATE CASCADE ON DELETE CASCADE
```

### `ModSource`
```sql
  Column   |  Type   | Collation | Nullable | Default
-----------+---------+-----------+----------+---------
 modId     | integer |           | not null |
 sourceUrl | text    |           | not null |
 primary   | boolean |           | not null | false
 query     | text    |           | not null |
Indexes:
    "ModSource_pkey" PRIMARY KEY, btree ("modId", "sourceUrl")
Foreign-key constraints:
    "ModSource_modId_fkey" FOREIGN KEY ("modId") REFERENCES "Mod"(id) ON UPDATE CASCADE ON DELETE CASCADE
    "ModSource_sourceUrl_fkey" FOREIGN KEY ("sourceUrl") REFERENCES "Source"(url) ON UPDATE CASCADE ON DELETE CASCADE
```

### `ModInstaller`
```sql
  Column   |  Type   | Collation | Nullable | Default
-----------+---------+-----------+----------+---------
 modId     | integer |           | not null |
 sourceUrl | text    |           | not null |
 url       | text    |           | not null |
Indexes:
    "ModInstaller_pkey" PRIMARY KEY, btree ("modId", "sourceUrl")
Foreign-key constraints:
    "ModInstaller_modId_fkey" FOREIGN KEY ("modId") REFERENCES "Mod"(id) ON UPDATE CASCADE ON DELETE CASCADE
    "ModInstaller_sourceUrl_fkey" FOREIGN KEY ("sourceUrl") REFERENCES "Source"(url) ON UPDATE CASCADE ON DELETE CASCADE

```