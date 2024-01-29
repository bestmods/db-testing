This repository stores and records static and complex [PostgreSQL](https://www.postgresql.org/) queries generated from [Best Mods](https://bestmods.io/) along with performance measurements and attempts at optimization.

## Motives
With [Best Mods](https://bestmods.io/) starting to receive more traffic, I wanted to optimize our expensive PSQL queries. With that said, I felt documenting this was a neat way to learn more about optimizing PSQL/SQL queries. I also want to get a lot better at optimizing SQL queries since database optimization is very important when creating a larger application that users interact with along with scaling. I will admit I don't have much experience in database optimization, but I feel I am learning quite a bit already!

## Queries
* [Browse With Cursor](./queries/browse-with-cursor)

## Notes
* The development database only includes `~15000` mods.
* The production database includes much more mod data (at least `16000` mods and counting, not including sources, installers, etc.).

## Credits
* [Christian Deacon](https://github.com/gamemann)