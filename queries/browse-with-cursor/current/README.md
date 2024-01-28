This is the current query used on the website as of **January 28th, 2024**. There have been a couple optimizations to this query before this repository was created which cut execution times from over a second second to only *~220ms*!

## Bottlenecks
### Rating Calculations
The most expensive operation in this query by far is retrieving the current mod's rating regardless of a timeframe specified. (see [`no-ratings`](../no-ratings/) and [`no-rating-timeframe`](../no-rating-timeframe/))

### Mod Source And Installer Subqueries
The subqueries to retrieve the mod's sources and installers (along with their source relation) is quite expensive as well. It is not nearly as bad as the rating calculations, though.

Adittionally, using `json_agg()` with a `LEFT JOIN` to retrieve the mod's sources and installers (along with their source relation) seems to make performance far worst **surprisingly** over the current subqueries. (see [`left-join-and-json-agg`](../left-join-and-json-agg/))