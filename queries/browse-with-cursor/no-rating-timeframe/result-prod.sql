 Limit  (cost=2989.49..3406.76 rows=11 width=387) (actual time=62.418..62.905 rows=11 loops=1)
   Buffers: shared hit=2640
   ->  Result  (cost=2989.49..222209.74 rows=5779 width=387) (actual time=62.416..62.899 rows=11 loops=1)
         Buffers: shared hit=2640
         ->  Sort  (cost=2989.49..3003.93 rows=5779 width=263) (actual time=62.184..62.191 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 32kB
               Buffers: shared hit=2518
               ->  HashAggregate  (cost=2773.95..2860.63 rows=5779 width=263) (actual time=39.512..51.995 rows=16464 loops=1)
                     Group Key: "Mod".id, ratingsub.pos_count, ratingsub.neg_count
                     Batches: 1  Memory Usage: 8977kB
                     Buffers: shared hit=2518
                     ->  Hash Left Join  (cost=3.65..2730.60 rows=5779 width=255) (actual time=0.166..24.076 rows=16464 loops=1)
                           Hash Cond: ("Mod".id = ratingsub."modId")
                           Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                           Rows Removed by Filter: 48
                           Buffers: shared hit=2518
                           ->  Seq Scan on "Mod"  (cost=0.00..2683.28 rows=16628 width=239) (actual time=0.025..16.525 rows=16512 loops=1)
                                 Filter: visible
                                 Buffers: shared hit=2517
                           ->  Hash  (cost=3.06..3.06 rows=47 width=20) (actual time=0.130..0.133 rows=49 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                 Buffers: shared hit=1
                                 ->  Subquery Scan on ratingsub  (cost=2.12..3.06 rows=47 width=20) (actual time=0.084..0.109 rows=49 loops=1)
                                       Buffers: shared hit=1
                                       ->  HashAggregate  (cost=2.12..2.59 rows=47 width=20) (actual time=0.083..0.097 rows=49 loops=1)
                                             Group Key: "ModRating"."modId"
                                             Batches: 1  Memory Usage: 24kB
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "ModRating"  (cost=0.00..1.64 rows=64 width=5) (actual time=0.012..0.022 rows=67 loops=1)
                                                   Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=16.54..16.55 rows=1 width=32) (actual time=0.021..0.021 rows=1 loops=11)
                 Buffers: shared hit=55
                 ->  Unique  (cost=0.43..16.52 rows=1 width=111) (actual time=0.010..0.010 rows=1 loops=11)
                       Buffers: shared hit=55
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=111) (actual time=0.009..0.010 rows=1 loops=11)
                             Buffers: shared hit=55
                             ->  Index Scan using "ModSource_pkey" on "ModSource"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.005..0.005 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Index Scan using "Source_pkey" on "Source" modsourcesource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.003..0.003 rows=1 loops=11)
                                   Index Cond: (url = "ModSource"."sourceUrl")
                                   Buffers: shared hit=22
         SubPlan 2
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.010..0.010 rows=1 loops=11)
                 Buffers: shared hit=34
                 ->  Unique  (cost=0.43..16.51 rows=1 width=128) (actual time=0.005..0.005 rows=0 loops=11)
                       Buffers: shared hit=34
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.004 rows=0 loops=11)
                             Buffers: shared hit=34
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.002..0.002 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=26
                             ->  Index Scan using "Source_pkey" on "Source" modinstallersource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.002..0.002 rows=1 loops=4)
                                   Index Cond: (url = "ModInstaller"."sourceUrl")
                                   Buffers: shared hit=8
         SubPlan 3
           ->  Subquery Scan on subquery  (cost=0.00..2.85 rows=1 width=32) (actual time=0.018..0.019 rows=1 loops=11)
                 Buffers: shared hit=22
                 ->  Unique  (cost=0.00..2.84 rows=1 width=106) (actual time=0.012..0.014 rows=1 loops=11)
                       Buffers: shared hit=22
                       ->  Nested Loop Left Join  (cost=0.00..2.84 rows=1 width=106) (actual time=0.012..0.013 rows=1 loops=11)
                             Join Filter: ("Category".id = categoryparent.id)
                             Buffers: shared hit=22
                             ->  Seq Scan on "Category"  (cost=0.00..1.41 rows=1 width=57) (actual time=0.005..0.006 rows=1 loops=11)
                                   Filter: (id = "Mod"."categoryId")
                                   Rows Removed by Filter: 40
                                   Buffers: shared hit=11
                             ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.41 rows=1 width=53) (actual time=0.004..0.004 rows=1 loops=11)
                                   Filter: (id = "Mod"."categoryId")
                                   Rows Removed by Filter: 26
                                   Buffers: shared hit=11
         SubPlan 4
           ->  Aggregate  (cost=1.97..1.98 rows=1 width=32) (actual time=0.009..0.009 rows=1 loops=11)
                 Buffers: shared hit=11
                 ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.96 rows=1 width=1) (actual time=0.008..0.008 rows=0 loops=11)
                       Filter: (("modId" = "Mod".id) AND ("userId" = ''::text))
                       Rows Removed by Filter: 67
                       Buffers: shared hit=11
 Planning:
   Buffers: shared hit=8
 Planning Time: 1.011 ms
 Execution Time: 63.165 ms
(84 rows)