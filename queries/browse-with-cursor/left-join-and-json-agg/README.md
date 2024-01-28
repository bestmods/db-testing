This query attempts to use two `LEFT JOIN` operations for the mod source and installer relations (one join to the relation directly and another to the relation's source relation).

Surprisingly, this performs far worse than the subqueries used in the current query. I've read that `LEFT JOIN` plus `json_agg()` should result in better performance than subqueries most of the time.

With that said, using `GROUP BY` instead of `json_agg()` results in similar performance.