 Limit  (cost=6.10..382.04 rows=11 width=407) (actual time=0.424..1.110 rows=11 loops=1)
   Buffers: shared hit=366
   ->  GroupAggregate  (cost=6.10..684123.99 rows=20017 width=407) (actual time=0.423..1.107 rows=11 loops=1)
         Group Key: "Mod".id, category.id, categoryparent.id
         Buffers: shared hit=366
         ->  Incremental Sort  (cost=6.10..21232.17 rows=20017 width=537) (actual time=0.303..0.554 rows=36 loops=1)
               Sort Key: "Mod".id DESC, category.id, categoryparent.id
               Presorted Key: "Mod".id
               Full-sort Groups: 2  Sort Method: quicksort  Average Memory: 42kB  Peak Memory: 42kB
               Buffers: shared hit=280
               ->  Nested Loop Left Join  (cost=1.57..20458.78 rows=20017 width=537) (actual time=0.111..0.449 rows=71 loops=1)
                     Buffers: shared hit=280
                     ->  Nested Loop Left Join  (cost=1.15..9958.03 rows=4718 width=404) (actual time=0.089..0.314 rows=29 loops=1)
                           Buffers: shared hit=164
                           ->  Nested Loop Left Join  (cost=0.87..8114.65 rows=4606 width=404) (actual time=0.080..0.241 rows=29 loops=1)
                                 Join Filter: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=105
                                 ->  Nested Loop Left Join  (cost=0.87..8043.76 rows=4606 width=341) (actual time=0.063..0.212 rows=29 loops=1)
                                       Buffers: shared hit=104
                                       ->  Nested Loop Left Join  (cost=0.59..6447.90 rows=4606 width=341) (actual time=0.057..0.160 rows=29 loops=1)
                                             Buffers: shared hit=45
                                             ->  Nested Loop Left Join  (cost=0.44..6328.42 rows=4606 width=292) (actual time=0.054..0.141 rows=29 loops=1)
                                                   Buffers: shared hit=45
                                                   ->  Index Scan Backward using "Mod_pkey" on "Mod"  (cost=0.29..6209.99 rows=4606 width=239) (actual time=0.031..0.077 rows=29 loops=1)
                                                         Index Cond: (id <= 14375)
                                                         Filter: visible
                                                         Buffers: shared hit=27
                                                   ->  Memoize  (cost=0.15..0.17 rows=1 width=57) (actual time=0.002..0.002 rows=1 loops=29)
                                                         Cache Key: "Mod"."categoryId"
                                                         Cache Mode: logical
                                                         Hits: 20  Misses: 9  Evictions: 0  Overflows: 0  Memory Usage: 2kB
                                                         Buffers: shared hit=18
                                                         ->  Index Scan using "Category_pkey" on "Category" category  (cost=0.14..0.16 rows=1 width=57) (actual time=0.003..0.003 rows=1 loops=9)
                                                               Index Cond: (id = "Mod"."categoryId")
                                                               Buffers: shared hit=18
                                             ->  Memoize  (cost=0.15..0.53 rows=1 width=53) (actual time=0.000..0.000 rows=0 loops=29)
                                                   Cache Key: category."parentId"
                                                   Cache Mode: logical
                                                   Hits: 28  Misses: 1  Evictions: 0  Overflows: 0  Memory Usage: 1kB
                                                   ->  Index Scan using "Category_pkey" on "Category" categoryparent  (cost=0.14..0.52 rows=1 width=53) (actual time=0.002..0.002 rows=0 loops=1)
                                                         Index Cond: (id = category."parentId")
                                       ->  Index Only Scan using "ModInstaller_pkey" on "ModInstaller"  (cost=0.28..0.34 rows=1 width=4) (actual time=0.001..0.001 rows=0 loops=29)
                                             Index Cond: ("modId" = "Mod".id)
                                             Heap Fetches: 0
                                             Buffers: shared hit=59
                                 ->  Materialize  (cost=0.00..1.80 rows=1 width=67) (actual time=0.001..0.001 rows=0 loops=29)
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=67) (actual time=0.015..0.015 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 67
                                             Buffers: shared hit=1
                           ->  Index Only Scan using "ModSource_pkey" on "ModSource"  (cost=0.29..0.39 rows=1 width=4) (actual time=0.001..0.002 rows=1 loops=29)
                                 Index Cond: ("modId" = "Mod".id)
                                 Heap Fetches: 0
                                 Buffers: shared hit=59
                     ->  Index Scan using "ModDownload_pkey" on "ModDownload"  (cost=0.41..2.17 rows=6 width=137) (actual time=0.003..0.004 rows=2 loops=29)
                           Index Cond: ("modId" = "Mod".id)
                           Buffers: shared hit=116
         SubPlan 1
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.018..0.018 rows=1 loops=11)
                 Buffers: shared hit=55
                 ->  Unique  (cost=0.43..16.51 rows=1 width=111) (actual time=0.008..0.008 rows=1 loops=11)
                       Buffers: shared hit=55
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=111) (actual time=0.007..0.008 rows=1 loops=11)
                             Buffers: shared hit=55
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.003..0.003 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Index Scan using "Source_pkey" on "Source" modsourcesource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.003..0.003 rows=1 loops=11)
                                   Index Cond: (url = "ModSource_1"."sourceUrl")
                                   Buffers: shared hit=22
         SubPlan 2
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.008..0.008 rows=1 loops=11)
                 Buffers: shared hit=31
                 ->  Unique  (cost=0.43..16.51 rows=1 width=128) (actual time=0.005..0.005 rows=0 loops=11)
                       Buffers: shared hit=31
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=128) (actual time=0.005..0.005 rows=0 loops=11)
                             Buffers: shared hit=31
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller" "ModInstaller_1"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.002..0.002 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=25
                             ->  Index Scan using "Source_pkey" on "Source" modinstallersource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.008..0.008 rows=1 loops=3)
                                   Index Cond: (url = "ModInstaller_1"."sourceUrl")
                                   Buffers: shared hit=6
 Planning:
   Buffers: shared hit=112
 Planning Time: 7.731 ms
 Execution Time: 1.257 ms
(88 rows)