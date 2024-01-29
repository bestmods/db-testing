 Limit  (cost=3.90..374.74 rows=11 width=407) (actual time=0.337..1.124 rows=11 loops=1)
   Buffers: shared hit=327
   ->  GroupAggregate  (cost=3.90..2155183.23 rows=63928 width=407) (actual time=0.336..1.120 rows=11 loops=1)
         Group Key: "Mod".id, category.id, categoryparent.id
         Buffers: shared hit=327
         ->  Incremental Sort  (cost=3.90..38115.33 rows=63928 width=537) (actual time=0.264..0.458 rows=49 loops=1)
               Sort Key: "Mod".id DESC, category.id, categoryparent.id
               Presorted Key: "Mod".id
               Full-sort Groups: 2  Sort Method: quicksort  Average Memory: 44kB  Peak Memory: 44kB
               Buffers: shared hit=244
               ->  Nested Loop Left Join  (cost=1.57..35673.20 rows=63928 width=537) (actual time=0.111..0.395 rows=66 loops=1)
                     Buffers: shared hit=244
                     ->  Nested Loop Left Join  (cost=1.15..18728.56 rows=15808 width=404) (actual time=0.099..0.284 rows=21 loops=1)
                           Join Filter: ("Mod".id = "ModRating"."modId")
                           Buffers: shared hit=150
                           ->  Nested Loop Left Join  (cost=1.15..18489.64 rows=15808 width=341) (actual time=0.078..0.255 rows=21 loops=1)
                                 Buffers: shared hit=149
                                 ->  Nested Loop Left Join  (cost=0.87..13417.16 rows=15808 width=341) (actual time=0.044..0.184 rows=21 loops=1)
                                       Buffers: shared hit=102
                                       ->  Nested Loop Left Join  (cost=0.59..8041.16 rows=15808 width=341) (actual time=0.035..0.125 rows=21 loops=1)
                                             Buffers: shared hit=38
                                             ->  Nested Loop Left Join  (cost=0.44..7643.66 rows=15808 width=292) (actual time=0.032..0.109 rows=21 loops=1)
                                                   Buffers: shared hit=38
                                                   ->  Index Scan Backward using "Mod_pkey" on "Mod"  (cost=0.29..7250.02 rows=15808 width=239) (actual time=0.021..0.050 rows=21 loops=1)
                                                         Index Cond: (id <= 1000000)
                                                         Filter: visible
                                                         Buffers: shared hit=18
                                                   ->  Memoize  (cost=0.15..0.17 rows=1 width=57) (actual time=0.002..0.002 rows=1 loops=21)
                                                         Cache Key: "Mod"."categoryId"
                                                         Cache Mode: logical
                                                         Hits: 11  Misses: 10  Evictions: 0  Overflows: 0  Memory Usage: 2kB
                                                         Buffers: shared hit=20
                                                         ->  Index Scan using "Category_pkey" on "Category" category  (cost=0.14..0.16 rows=1 width=57) (actual time=0.002..0.002 rows=1 loops=10)
                                                               Index Cond: (id = "Mod"."categoryId")
                                                               Buffers: shared hit=20
                                             ->  Memoize  (cost=0.15..0.53 rows=1 width=53) (actual time=0.000..0.000 rows=0 loops=21)
                                                   Cache Key: category."parentId"
                                                   Cache Mode: logical
                                                   Hits: 20  Misses: 1  Evictions: 0  Overflows: 0  Memory Usage: 1kB
                                                   ->  Index Scan using "Category_pkey" on "Category" categoryparent  (cost=0.14..0.52 rows=1 width=53) (actual time=0.002..0.002 rows=0 loops=1)
                                                         Index Cond: (id = category."parentId")
                                       ->  Index Only Scan using "ModSource_pkey" on "ModSource"  (cost=0.29..0.33 rows=1 width=4) (actual time=0.002..0.002 rows=1 loops=21)
                                             Index Cond: ("modId" = "Mod".id)
                                             Heap Fetches: 21
                                             Buffers: shared hit=64
                                 ->  Index Only Scan using "ModInstaller_pkey" on "ModInstaller"  (cost=0.28..0.31 rows=1 width=4) (actual time=0.003..0.003 rows=0 loops=21)
                                       Index Cond: ("modId" = "Mod".id)
                                       Heap Fetches: 4
                                       Buffers: shared hit=47
                           ->  Materialize  (cost=0.00..1.80 rows=1 width=67) (actual time=0.001..0.001 rows=0 loops=21)
                                 Buffers: shared hit=1
                                 ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=67) (actual time=0.018..0.018 rows=0 loops=1)
                                       Filter: ("userId" = ''::text)
                                       Rows Removed by Filter: 67
                                       Buffers: shared hit=1
                     ->  Index Scan using "ModDownload_pkey" on "ModDownload"  (cost=0.41..1.01 rows=6 width=137) (actual time=0.003..0.004 rows=3 loops=21)
                           Index Cond: ("modId" = "Mod".id)
                           Buffers: shared hit=94
         SubPlan 1
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.018..0.018 rows=1 loops=11)
                 Buffers: shared hit=55
                 ->  Unique  (cost=0.43..16.51 rows=1 width=111) (actual time=0.006..0.009 rows=1 loops=11)
                       Buffers: shared hit=55
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=111) (actual time=0.006..0.008 rows=1 loops=11)
                             Buffers: shared hit=55
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.002..0.003 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Index Scan using "Source_pkey" on "Source" modsourcesource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.002..0.002 rows=1 loops=11)
                                   Index Cond: (url = "ModSource_1"."sourceUrl")
                                   Buffers: shared hit=22
         SubPlan 2
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.005..0.005 rows=1 loops=11)
                 Buffers: shared hit=28
                 ->  Unique  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.003 rows=0 loops=11)
                       Buffers: shared hit=28
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.003 rows=0 loops=11)
                             Buffers: shared hit=28
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller" "ModInstaller_1"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.002..0.002 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=24
                             ->  Index Scan using "Source_pkey" on "Source" modinstallersource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.002..0.002 rows=1 loops=2)
                                   Index Cond: (url = "ModInstaller_1"."sourceUrl")
                                   Buffers: shared hit=4
 Planning:
   Buffers: shared hit=116
 Planning Time: 7.346 ms
 Execution Time: 1.333 ms
(88 rows)