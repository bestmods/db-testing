 Limit  (cost=0.29..270.25 rows=11 width=367) (actual time=0.101..0.510 rows=11 loops=1)
   Buffers: shared hit=116
   ->  Group  (cost=0.29..386006.74 rows=15728 width=367) (actual time=0.100..0.507 rows=11 loops=1)
         Group Key: "Mod".id
         Buffers: shared hit=116
         ->  Index Scan Backward using "Mod_pkey" on "Mod"  (cost=0.29..6175.54 rows=15728 width=239) (actual time=0.013..0.024 rows=11 loops=1)
               Index Cond: (id <= 1000000)
               Filter: visible
               Buffers: shared hit=9
         SubPlan 1
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.014..0.015 rows=1 loops=11)
                 Buffers: shared hit=44
                 ->  Unique  (cost=0.29..9.51 rows=1 width=111) (actual time=0.005..0.006 rows=1 loops=11)
                       Buffers: shared hit=44
                       ->  Nested Loop Left Join  (cost=0.29..9.51 rows=1 width=111) (actual time=0.005..0.005 rows=1 loops=11)
                             Join Filter: ("ModSource"."sourceUrl" = modsourcesource.url)
                             Rows Removed by Join Filter: 3
                             Buffers: shared hit=44
                             ->  Index Scan using "ModSource_pkey" on "ModSource"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.002..0.002 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Seq Scan on "Source" modsourcesource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.001..0.001 rows=4 loops=11)
                                   Buffers: shared hit=11
         SubPlan 2
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.006..0.006 rows=1 loops=11)
                 Buffers: shared hit=30
                 ->  Unique  (cost=0.28..9.51 rows=1 width=128) (actual time=0.003..0.003 rows=0 loops=11)
                       Buffers: shared hit=30
                       ->  Nested Loop Left Join  (cost=0.28..9.50 rows=1 width=128) (actual time=0.003..0.003 rows=0 loops=11)
                             Join Filter: ("ModInstaller"."sourceUrl" = modinstallersource.url)
                             Rows Removed by Join Filter: 1
                             Buffers: shared hit=30
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.002..0.002 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=26
                             ->  Seq Scan on "Source" modinstallersource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.001..0.001 rows=3 loops=4)
                                   Buffers: shared hit=4
         SubPlan 3
           ->  Subquery Scan on subquery  (cost=0.00..3.05 rows=1 width=32) (actual time=0.011..0.012 rows=1 loops=11)
                 Buffers: shared hit=22
                 ->  Unique  (cost=0.00..3.04 rows=1 width=200) (actual time=0.008..0.009 rows=1 loops=11)
                       Buffers: shared hit=22
                       ->  Nested Loop Left Join  (cost=0.00..3.04 rows=1 width=200) (actual time=0.007..0.008 rows=1 loops=11)
                             Join Filter: ("Category".id = categoryparent.id)
                             Buffers: shared hit=22
                             ->  Seq Scan on "Category"  (cost=0.00..1.51 rows=1 width=104) (actual time=0.003..0.004 rows=1 loops=11)
                                   Filter: (id = "Mod"."categoryId")
                                   Rows Removed by Filter: 40
                                   Buffers: shared hit=11
                             ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.51 rows=1 width=100) (actual time=0.003..0.003 rows=1 loops=11)
                                   Filter: (id = "Mod"."categoryId")
                                   Rows Removed by Filter: 25
                                   Buffers: shared hit=11
         SubPlan 4
           ->  Aggregate  (cost=2.01..2.02 rows=1 width=32) (actual time=0.007..0.008 rows=1 loops=11)
                 Buffers: shared hit=11
                 ->  Seq Scan on "ModRating"  (cost=0.00..2.00 rows=1 width=1) (actual time=0.007..0.007 rows=0 loops=11)
                       Filter: (("modId" = "Mod".id) AND ("userId" = ''::text))
                       Rows Removed by Filter: 71
                       Buffers: shared hit=11
 Planning Time: 0.504 ms
 Execution Time: 0.583 ms
(62 rows)