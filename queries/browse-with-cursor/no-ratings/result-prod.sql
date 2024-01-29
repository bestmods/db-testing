 Limit  (cost=2.35..380.05 rows=11 width=375) (actual time=0.746..1.286 rows=11 loops=1)
   Buffers: shared hit=313
   ->  GroupAggregate  (cost=2.35..561996.44 rows=16367 width=375) (actual time=0.745..1.269 rows=11 loops=1)
         Group Key: "Mod".id, category.id, categoryparent.id
         Buffers: shared hit=313
         ->  Incremental Sort  (cost=2.35..20061.47 rows=16367 width=404) (actual time=0.659..0.666 rows=12 loops=1)
               Sort Key: "Mod".id DESC, category.id, categoryparent.id
               Presorted Key: "Mod".id
               Full-sort Groups: 1  Sort Method: quicksort  Average Memory: 36kB  Peak Memory: 36kB
               Buffers: shared hit=227
               ->  Nested Loop Left Join  (cost=1.15..19326.46 rows=16367 width=404) (actual time=0.125..0.603 rows=33 loops=1)
                     Buffers: shared hit=227
                     ->  Nested Loop Left Join  (cost=0.87..13753.21 rows=16324 width=404) (actual time=0.117..0.453 rows=33 loops=1)
                           Join Filter: ("Mod".id = "ModRating"."modId")
                           Buffers: shared hit=127
                           ->  Nested Loop Left Join  (cost=0.87..13506.55 rows=16324 width=341) (actual time=0.090..0.404 rows=33 loops=1)
                                 Buffers: shared hit=126
                                 ->  Nested Loop Left Join  (cost=0.59..8262.11 rows=16324 width=341) (actual time=0.072..0.283 rows=33 loops=1)
                                       Buffers: shared hit=49
                                       ->  Nested Loop Left Join  (cost=0.44..7851.81 rows=16324 width=292) (actual time=0.068..0.233 rows=33 loops=1)
                                             Buffers: shared hit=49
                                             ->  Index Scan Backward using "Mod_pkey" on "Mod"  (cost=0.29..7445.50 rows=16324 width=239) (actual time=0.041..0.108 rows=33 loops=1)
                                                   Index Cond: (id <= 1000000)
                                                   Filter: visible
                                                   Buffers: shared hit=23
                                             ->  Memoize  (cost=0.15..0.17 rows=1 width=57) (actual time=0.003..0.003 rows=1 loops=33)
                                                   Cache Key: "Mod"."categoryId"
                                                   Cache Mode: logical
                                                   Hits: 20  Misses: 13  Evictions: 0  Overflows: 0  Memory Usage: 3kB
                                                   Buffers: shared hit=26
                                                   ->  Index Scan using "Category_pkey" on "Category" category  (cost=0.14..0.16 rows=1 width=57) (actual time=0.003..0.003 rows=1 loops=13)
                                                         Index Cond: (id = "Mod"."categoryId")
                                                         Buffers: shared hit=26
                                       ->  Memoize  (cost=0.15..0.53 rows=1 width=53) (actual time=0.000..0.000 rows=0 loops=33)
                                             Cache Key: category."parentId"
                                             Cache Mode: logical
                                             Hits: 32  Misses: 1  Evictions: 0  Overflows: 0  Memory Usage: 1kB
                                             ->  Index Scan using "Category_pkey" on "Category" categoryparent  (cost=0.14..0.52 rows=1 width=53) (actual time=0.002..0.002 rows=0 loops=1)
                                                   Index Cond: (id = category."parentId")
                                 ->  Index Only Scan using "ModInstaller_pkey" on "ModInstaller"  (cost=0.28..0.31 rows=1 width=4) (actual time=0.002..0.002 rows=0 loops=33)
                                       Index Cond: ("modId" = "Mod".id)
                                       Heap Fetches: 10
                                       Buffers: shared hit=77
                           ->  Materialize  (cost=0.00..1.80 rows=1 width=67) (actual time=0.001..0.001 rows=0 loops=33)
                                 Buffers: shared hit=1
                                 ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=67) (actual time=0.023..0.023 rows=0 loops=1)
                                       Filter: ("userId" = ''::text)
                                       Rows Removed by Filter: 67
                                       Buffers: shared hit=1
                     ->  Index Only Scan using "ModSource_pkey" on "ModSource"  (cost=0.29..0.33 rows=1 width=4) (actual time=0.003..0.004 rows=1 loops=33)
                           Index Cond: ("modId" = "Mod".id)
                           Heap Fetches: 33
                           Buffers: shared hit=100
         SubPlan 1
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.029..0.030 rows=1 loops=11)
                 Buffers: shared hit=55
                 ->  Unique  (cost=0.43..16.51 rows=1 width=111) (actual time=0.012..0.013 rows=1 loops=11)
                       Buffers: shared hit=55
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=111) (actual time=0.011..0.012 rows=1 loops=11)
                             Buffers: shared hit=55
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.006..0.006 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Index Scan using "Source_pkey" on "Source" modsourcesource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.003..0.003 rows=1 loops=11)
                                   Index Cond: (url = "ModSource_1"."sourceUrl")
                                   Buffers: shared hit=22
         SubPlan 2
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.010..0.010 rows=1 loops=11)
                 Buffers: shared hit=31
                 ->  Unique  (cost=0.43..16.51 rows=1 width=128) (actual time=0.005..0.005 rows=0 loops=11)
                       Buffers: shared hit=31
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=128) (actual time=0.004..0.005 rows=0 loops=11)
                             Buffers: shared hit=31
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller" "ModInstaller_1"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.003..0.003 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=25
                             ->  Index Scan using "Source_pkey" on "Source" modinstallersource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.003..0.003 rows=1 loops=3)
                                   Index Cond: (url = "ModInstaller_1"."sourceUrl")
                                   Buffers: shared hit=6
 Planning:
   Buffers: shared hit=80
 Planning Time: 4.672 ms
 Execution Time: 1.501 ms
(83 rows)