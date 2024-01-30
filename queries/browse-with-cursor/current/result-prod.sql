 Limit  (cost=3473.70..3890.97 rows=11 width=387) (actual time=80.118..81.055 rows=11 loops=1)
   Buffers: shared hit=2640
   ->  Result  (cost=3473.70..634239.29 rows=16628 width=387) (actual time=80.116..81.049 rows=11 loops=1)
         Buffers: shared hit=2640
         ->  Sort  (cost=3473.70..3515.27 rows=16628 width=263) (actual time=79.903..79.914 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 32kB
               Buffers: shared hit=2518
               ->  HashAggregate  (cost=2853.52..3102.94 rows=16628 width=263) (actual time=50.488..64.316 rows=16510 loops=1)
                     Group Key: "Mod".id, ratingsub.pos_count, ratingsub.neg_count
                     Batches: 1  Memory Usage: 8977kB
                     Buffers: shared hit=2518
                     ->  Hash Left Join  (cost=1.85..2728.81 rows=16628 width=255) (actual time=0.129..28.736 rows=16510 loops=1)
                           Hash Cond: ("Mod".id = ratingsub."modId")
                           Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                           Buffers: shared hit=2518
                           ->  Seq Scan on "Mod"  (cost=0.00..2683.28 rows=16628 width=239) (actual time=0.013..19.584 rows=16510 loops=1)
                                 Filter: visible
                                 Buffers: shared hit=2517
                           ->  Hash  (cost=1.84..1.84 rows=1 width=20) (actual time=0.104..0.107 rows=0 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                 Buffers: shared hit=1
                                 ->  Subquery Scan on ratingsub  (cost=1.81..1.84 rows=1 width=20) (actual time=0.103..0.105 rows=0 loops=1)
                                       Buffers: shared hit=1
                                       ->  GroupAggregate  (cost=1.81..1.83 rows=1 width=20) (actual time=0.103..0.104 rows=0 loops=1)
                                             Group Key: "ModRating"."modId"
                                             Buffers: shared hit=1
                                             ->  Sort  (cost=1.81..1.81 rows=1 width=5) (actual time=0.101..0.102 rows=0 loops=1)
                                                   Sort Key: "ModRating"."modId"
                                                   Sort Method: quicksort  Memory: 25kB
                                                   Buffers: shared hit=1
                                                   ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=5) (actual time=0.096..0.097 rows=0 loops=1)
                                                         Filter: ("createdAt" > '2024-01-28 11:47:48.889'::timestamp without time zone)
                                                         Rows Removed by Filter: 67
                                                         Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=16.54..16.55 rows=1 width=32) (actual time=0.034..0.034 rows=1 loops=11)
                 Buffers: shared hit=55
                 ->  Unique  (cost=0.43..16.52 rows=1 width=111) (actual time=0.015..0.016 rows=1 loops=11)
                       Buffers: shared hit=55
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=111) (actual time=0.014..0.015 rows=1 loops=11)
                             Buffers: shared hit=55
                             ->  Index Scan using "ModSource_pkey" on "ModSource"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.007..0.007 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Index Scan using "Source_pkey" on "Source" modsourcesource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.004..0.004 rows=1 loops=11)
                                   Index Cond: (url = "ModSource"."sourceUrl")
                                   Buffers: shared hit=22
         SubPlan 2
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.014..0.014 rows=1 loops=11)
                 Buffers: shared hit=34
                 ->  Unique  (cost=0.43..16.51 rows=1 width=128) (actual time=0.007..0.007 rows=0 loops=11)
                       Buffers: shared hit=34
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=128) (actual time=0.006..0.007 rows=0 loops=11)
                             Buffers: shared hit=34
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.004..0.004 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=26
                             ->  Index Scan using "Source_pkey" on "Source" modinstallersource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.003..0.003 rows=1 loops=4)
                                   Index Cond: (url = "ModInstaller"."sourceUrl")
                                   Buffers: shared hit=8
         SubPlan 3
           ->  Subquery Scan on subquery  (cost=0.00..2.85 rows=1 width=32) (actual time=0.027..0.030 rows=1 loops=11)
                 Buffers: shared hit=22
                 ->  Unique  (cost=0.00..2.84 rows=1 width=106) (actual time=0.019..0.023 rows=1 loops=11)
                       Buffers: shared hit=22
                       ->  Nested Loop Left Join  (cost=0.00..2.84 rows=1 width=106) (actual time=0.018..0.021 rows=1 loops=11)
                             Join Filter: ("Category".id = categoryparent.id)
                             Buffers: shared hit=22
                             ->  Seq Scan on "Category"  (cost=0.00..1.41 rows=1 width=57) (actual time=0.008..0.011 rows=1 loops=11)
                                   Filter: (id = "Mod"."categoryId")
                                   Rows Removed by Filter: 40
                                   Buffers: shared hit=11
                             ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.41 rows=1 width=53) (actual time=0.006..0.006 rows=1 loops=11)
                                   Filter: (id = "Mod"."categoryId")
                                   Rows Removed by Filter: 25
                                   Buffers: shared hit=11
         SubPlan 4
           ->  Aggregate  (cost=1.97..1.98 rows=1 width=32) (actual time=0.016..0.016 rows=1 loops=11)
                 Buffers: shared hit=11
                 ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.96 rows=1 width=1) (actual time=0.014..0.014 rows=0 loops=11)
                       Filter: (("modId" = "Mod".id) AND ("userId" = ''::text))
                       Rows Removed by Filter: 67
                       Buffers: shared hit=11
 Planning:
   Buffers: shared hit=8
 Planning Time: 1.420 ms
 Execution Time: 81.458 ms
(88 rows)