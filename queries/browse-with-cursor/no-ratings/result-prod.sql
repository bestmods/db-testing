 Limit  (cost=0.29..422.42 rows=11 width=367) (actual time=0.123..0.614 rows=11 loops=1)
   Buffers: shared hit=132
   ->  Group  (cost=0.29..638348.74 rows=16634 width=367) (actual time=0.122..0.611 rows=11 loops=1)
         Group Key: "Mod".id
         Buffers: shared hit=132
         ->  Index Scan Backward using "Mod_pkey" on "Mod"  (cost=0.29..7605.06 rows=16634 width=239) (actual time=0.017..0.036 rows=11 loops=1)
               Index Cond: (id <= 1000000)
               Filter: visible
               Buffers: shared hit=10
         SubPlan 1
           ->  Aggregate  (cost=16.54..16.55 rows=1 width=32) (actual time=0.017..0.017 rows=1 loops=11)
                 Buffers: shared hit=55
                 ->  Unique  (cost=0.43..16.52 rows=1 width=111) (actual time=0.007..0.008 rows=1 loops=11)
                       Buffers: shared hit=55
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=111) (actual time=0.006..0.007 rows=1 loops=11)
                             Buffers: shared hit=55
                             ->  Index Scan using "ModSource_pkey" on "ModSource"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.003..0.003 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Index Scan using "Source_pkey" on "Source" modsourcesource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.002..0.002 rows=1 loops=11)
                                   Index Cond: (url = "ModSource"."sourceUrl")
                                   Buffers: shared hit=22
         SubPlan 2
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.007..0.007 rows=1 loops=11)
                 Buffers: shared hit=34
                 ->  Unique  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.004 rows=0 loops=11)
                       Buffers: shared hit=34
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.003 rows=0 loops=11)
                             Buffers: shared hit=34
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.002..0.002 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=26
                             ->  Index Scan using "Source_pkey" on "Source" modinstallersource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.001..0.001 rows=1 loops=4)
                                   Index Cond: (url = "ModInstaller"."sourceUrl")
                                   Buffers: shared hit=8
         SubPlan 3
           ->  Subquery Scan on subquery  (cost=0.00..2.85 rows=1 width=32) (actual time=0.014..0.016 rows=1 loops=11)
                 Buffers: shared hit=22
                 ->  Unique  (cost=0.00..2.84 rows=1 width=106) (actual time=0.010..0.012 rows=1 loops=11)
                       Buffers: shared hit=22
                       ->  Nested Loop Left Join  (cost=0.00..2.84 rows=1 width=106) (actual time=0.010..0.011 rows=1 loops=11)
                             Join Filter: ("Category".id = categoryparent.id)
                             Buffers: shared hit=22
                             ->  Seq Scan on "Category"  (cost=0.00..1.41 rows=1 width=57) (actual time=0.004..0.005 rows=1 loops=11)
                                   Filter: (id = "Mod"."categoryId")
                                   Rows Removed by Filter: 40
                                   Buffers: shared hit=11
                             ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.41 rows=1 width=53) (actual time=0.003..0.003 rows=1 loops=11)
                                   Filter: (id = "Mod"."categoryId")
                                   Rows Removed by Filter: 26
                                   Buffers: shared hit=11
         SubPlan 4
           ->  Aggregate  (cost=1.97..1.98 rows=1 width=32) (actual time=0.008..0.008 rows=1 loops=11)
                 Buffers: shared hit=11
                 ->  Seq Scan on "ModRating"  (cost=0.00..1.96 rows=1 width=1) (actual time=0.007..0.007 rows=0 loops=11)
                       Filter: (("modId" = "Mod".id) AND ("userId" = ''::text))
                       Rows Removed by Filter: 67
                       Buffers: shared hit=11
 Planning:
   Buffers: shared hit=4
 Planning Time: 0.692 ms
 Execution Time: 0.706 ms
(62 rows)