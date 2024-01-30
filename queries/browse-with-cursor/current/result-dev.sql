 Limit  (cost=2906.06..3171.87 rows=11 width=387) (actual time=28.977..29.227 rows=11 loops=1)
   Buffers: shared hit=2109
   ->  Result  (cost=2906.06..382973.18 rows=15728 width=387) (actual time=28.976..29.224 rows=11 loops=1)
         Buffers: shared hit=2109
         ->  Sort  (cost=2906.06..2945.38 rows=15728 width=263) (actual time=28.863..28.867 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 32kB
               Buffers: shared hit=2002
               ->  HashAggregate  (cost=2319.45..2555.37 rows=15728 width=263) (actual time=18.557..24.643 rows=15725 loops=1)
                     Group Key: "Mod".id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=2002
                     ->  Hash Left Join  (cost=1.89..2201.49 rows=15728 width=255) (actual time=0.046..11.456 rows=15725 loops=1)
                           Hash Cond: ("Mod".id = ratingsub."modId")
                           Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                           Rows Removed by Filter: 3
                           Buffers: shared hit=2002
                           ->  Seq Scan on "Mod"  (cost=0.00..2158.28 rows=15728 width=239) (actual time=0.007..3.732 rows=15728 loops=1)
                                 Filter: visible
                                 Buffers: shared hit=2001
                           ->  Hash  (cost=1.88..1.88 rows=1 width=20) (actual time=0.031..0.033 rows=4 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                 Buffers: shared hit=1
                                 ->  Subquery Scan on ratingsub  (cost=1.85..1.88 rows=1 width=20) (actual time=0.024..0.029 rows=4 loops=1)
                                       Buffers: shared hit=1
                                       ->  GroupAggregate  (cost=1.85..1.87 rows=1 width=20) (actual time=0.024..0.027 rows=4 loops=1)
                                             Group Key: "ModRating"."modId"
                                             Buffers: shared hit=1
                                             ->  Sort  (cost=1.85..1.85 rows=1 width=5) (actual time=0.018..0.019 rows=4 loops=1)
                                                   Sort Key: "ModRating"."modId"
                                                   Sort Method: quicksort  Memory: 25kB
                                                   Buffers: shared hit=1
                                                   ->  Seq Scan on "ModRating"  (cost=0.00..1.84 rows=1 width=5) (actual time=0.012..0.013 rows=4 loops=1)
                                                         Filter: ("createdAt" > '2024-01-28 11:47:48.889'::timestamp without time zone)
                                                         Rows Removed by Filter: 67
                                                         Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.012..0.012 rows=1 loops=11)
                 Buffers: shared hit=44
                 ->  Unique  (cost=0.29..9.51 rows=1 width=111) (actual time=0.005..0.006 rows=1 loops=11)
                       Buffers: shared hit=44
                       ->  Nested Loop Left Join  (cost=0.29..9.51 rows=1 width=111) (actual time=0.005..0.005 rows=1 loops=11)
                             Join Filter: ("ModSource"."sourceUrl" = modsourcesource.url)
                             Rows Removed by Join Filter: 3
                             Buffers: shared hit=44
                             ->  Index Scan using "ModSource_pkey" on "ModSource"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.003..0.003 rows=1 loops=11)
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
                       ->  Nested Loop Left Join  (cost=0.00..3.04 rows=1 width=200) (actual time=0.005..0.006 rows=1 loops=11)
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
 Planning Time: 0.809 ms
 Execution Time: 29.433 ms
(88 rows)