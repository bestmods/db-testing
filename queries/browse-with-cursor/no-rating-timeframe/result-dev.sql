 Limit  (cost=2447.82..2713.63 rows=11 width=387) (actual time=28.183..28.424 rows=11 loops=1)
   Buffers: shared hit=2109
   ->  Result  (cost=2447.82..134316.22 rows=5457 width=387) (actual time=28.182..28.422 rows=11 loops=1)
         Buffers: shared hit=2109
         ->  Sort  (cost=2447.82..2461.46 rows=5457 width=263) (actual time=28.092..28.095 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 32kB
               Buffers: shared hit=2002
               ->  HashAggregate  (cost=2244.29..2326.14 rows=5457 width=263) (actual time=18.918..24.175 rows=15678 loops=1)
                     Group Key: "Mod".id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=2002
                     ->  Hash Left Join  (cost=3.76..2203.36 rows=5457 width=255) (actual time=0.091..11.508 rows=15678 loops=1)
                           Hash Cond: ("Mod".id = ratingsub."modId")
                           Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                           Rows Removed by Filter: 50
                           Buffers: shared hit=2002
                           ->  Seq Scan on "Mod"  (cost=0.00..2158.28 rows=15728 width=239) (actual time=0.007..3.789 rows=15728 loops=1)
                                 Filter: visible
                                 Buffers: shared hit=2001
                           ->  Hash  (cost=3.15..3.15 rows=49 width=20) (actual time=0.076..0.077 rows=52 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                 Buffers: shared hit=1
                                 ->  Subquery Scan on ratingsub  (cost=2.17..3.15 rows=49 width=20) (actual time=0.044..0.064 rows=52 loops=1)
                                       Buffers: shared hit=1
                                       ->  HashAggregate  (cost=2.17..2.66 rows=49 width=20) (actual time=0.043..0.055 rows=52 loops=1)
                                             Group Key: "ModRating"."modId"
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "ModRating"  (cost=0.00..1.67 rows=67 width=5) (actual time=0.004..0.010 rows=71 loops=1)
                                                   Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.010..0.010 rows=1 loops=11)
                 Buffers: shared hit=44
                 ->  Unique  (cost=0.29..9.51 rows=1 width=111) (actual time=0.004..0.005 rows=1 loops=11)
                       Buffers: shared hit=44
                       ->  Nested Loop Left Join  (cost=0.29..9.51 rows=1 width=111) (actual time=0.004..0.004 rows=1 loops=11)
                             Join Filter: ("ModSource"."sourceUrl" = modsourcesource.url)
                             Rows Removed by Join Filter: 3
                             Buffers: shared hit=44
                             ->  Index Scan using "ModSource_pkey" on "ModSource"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.002..0.002 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Seq Scan on "Source" modsourcesource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.001..0.001 rows=4 loops=11)
                                   Buffers: shared hit=11
         SubPlan 2
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.004..0.004 rows=1 loops=11)
                 Buffers: shared hit=30
                 ->  Unique  (cost=0.28..9.51 rows=1 width=128) (actual time=0.002..0.002 rows=0 loops=11)
                       Buffers: shared hit=30
                       ->  Nested Loop Left Join  (cost=0.28..9.50 rows=1 width=128) (actual time=0.002..0.002 rows=0 loops=11)
                             Join Filter: ("ModInstaller"."sourceUrl" = modinstallersource.url)
                             Rows Removed by Join Filter: 1
                             Buffers: shared hit=30
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.001..0.001 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=26
                             ->  Seq Scan on "Source" modinstallersource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.000..0.001 rows=3 loops=4)
                                   Buffers: shared hit=4
         SubPlan 3
           ->  Subquery Scan on subquery  (cost=0.00..3.05 rows=1 width=32) (actual time=0.007..0.008 rows=1 loops=11)
                 Buffers: shared hit=22
                 ->  Unique  (cost=0.00..3.04 rows=1 width=200) (actual time=0.005..0.006 rows=1 loops=11)
                       Buffers: shared hit=22
                       ->  Nested Loop Left Join  (cost=0.00..3.04 rows=1 width=200) (actual time=0.005..0.005 rows=1 loops=11)
                             Join Filter: ("Category".id = categoryparent.id)
                             Buffers: shared hit=22
                             ->  Seq Scan on "Category"  (cost=0.00..1.51 rows=1 width=104) (actual time=0.002..0.003 rows=1 loops=11)
                                   Filter: (id = "Mod"."categoryId")
                                   Rows Removed by Filter: 40
                                   Buffers: shared hit=11
                             ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.51 rows=1 width=100) (actual time=0.002..0.002 rows=1 loops=11)
                                   Filter: (id = "Mod"."categoryId")
                                   Rows Removed by Filter: 25
                                   Buffers: shared hit=11
         SubPlan 4
           ->  Aggregate  (cost=2.01..2.02 rows=1 width=32) (actual time=0.005..0.005 rows=1 loops=11)
                 Buffers: shared hit=11
                 ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..2.00 rows=1 width=1) (actual time=0.005..0.005 rows=0 loops=11)
                       Filter: (("modId" = "Mod".id) AND ("userId" = ''::text))
                       Rows Removed by Filter: 71
                       Buffers: shared hit=11
 Planning Time: 0.729 ms
 Execution Time: 28.570 ms
(82 rows)