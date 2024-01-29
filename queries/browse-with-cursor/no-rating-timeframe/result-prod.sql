 Limit  (cost=4148.34..4512.51 rows=11 width=395) (actual time=156.944..157.151 rows=11 loops=1)
   Buffers: shared hit=2778 dirtied=2
   ->  Result  (cost=4148.34..192457.78 rows=5688 width=395) (actual time=156.942..157.146 rows=11 loops=1)
         Buffers: shared hit=2778 dirtied=2
         ->  Sort  (cost=4148.34..4162.56 rows=5688 width=331) (actual time=156.870..156.882 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 31kB
               Buffers: shared hit=2692 dirtied=2
               ->  GroupAggregate  (cost=3793.99..4021.51 rows=5688 width=331) (actual time=74.778..147.047 rows=16247 loops=1)
                     Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=2692 dirtied=2
                     ->  Sort  (cost=3793.99..3808.21 rows=5688 width=420) (actual time=74.748..76.473 rows=16249 loops=1)
                           Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                           Sort Method: quicksort  Memory: 5732kB
                           Buffers: shared hit=2692 dirtied=2
                           ->  Hash Left Join  (cost=2936.80..3439.24 rows=5688 width=420) (actual time=40.028..63.127 rows=16249 loops=1)
                                 Hash Cond: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=2692 dirtied=2
                                 ->  Hash Left Join  (cost=2934.99..3422.49 rows=5688 width=357) (actual time=40.008..59.064 rows=16249 loops=1)
                                       Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                       Buffers: shared hit=2691 dirtied=2
                                       ->  Hash Right Join  (cost=2780.67..3231.47 rows=5688 width=357) (actual time=38.558..52.865 rows=16249 loops=1)
                                             Hash Cond: ("ModSource"."modId" = "Mod".id)
                                             Buffers: shared hit=2636 dirtied=2
                                             ->  Seq Scan on "ModSource"  (cost=0.00..332.67 rows=16367 width=4) (actual time=0.013..1.751 rows=16292 loops=1)
                                                   Buffers: shared hit=169
                                             ->  Hash  (cost=2709.76..2709.76 rows=5673 width=357) (actual time=38.517..38.523 rows=16247 loops=1)
                                                   Buckets: 16384 (originally 8192)  Batches: 1 (originally 1)  Memory Usage: 5328kB
                                                   Buffers: shared hit=2467 dirtied=2
                                                   ->  Hash Left Join  (cost=7.13..2709.76 rows=5673 width=357) (actual time=0.164..27.025 rows=16247 loops=1)
                                                         Hash Cond: (category."parentId" = categoryparent.id)
                                                         Buffers: shared hit=2467 dirtied=2
                                                         ->  Hash Left Join  (cost=5.39..2692.31 rows=5673 width=308) (actual time=0.140..22.220 rows=16247 loops=1)
                                                               Hash Cond: ("Mod"."categoryId" = category.id)
                                                               Buffers: shared hit=2466 dirtied=2
                                                               ->  Hash Left Join  (cost=3.65..2673.77 rows=5673 width=255) (actual time=0.108..16.329 rows=16247 loops=1)
                                                                     Hash Cond: ("Mod".id = ratingsub."modId")
                                                                     Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                                                     Rows Removed by Filter: 48
                                                                     Buffers: shared hit=2465 dirtied=2
                                                                     ->  Seq Scan on "Mod"  (cost=0.00..2627.24 rows=16324 width=239) (actual time=0.014..10.980 rows=16295 loops=1)
                                                                           Filter: visible
                                                                           Buffers: shared hit=2464 dirtied=2
                                                                     ->  Hash  (cost=3.06..3.06 rows=47 width=20) (actual time=0.086..0.089 rows=49 loops=1)
                                                                           Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                                           Buffers: shared hit=1
                                                                           ->  Subquery Scan on ratingsub  (cost=2.12..3.06 rows=47 width=20) (actual time=0.061..0.077 rows=49 loops=1)
                                                                                 Buffers: shared hit=1
                                                                                 ->  HashAggregate  (cost=2.12..2.59 rows=47 width=20) (actual time=0.060..0.070 rows=49 loops=1)
                                                                                       Group Key: "ModRating_1"."modId"
                                                                                       Batches: 1  Memory Usage: 24kB
                                                                                       Buffers: shared hit=1
                                                                                       ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.64 rows=64 width=5) (actual time=0.007..0.013 rows=67 loops=1)
                                                                                             Buffers: shared hit=1
                                                               ->  Hash  (cost=1.33..1.33 rows=33 width=57) (actual time=0.026..0.027 rows=41 loops=1)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                     Buffers: shared hit=1
                                                                     ->  Seq Scan on "Category" category  (cost=0.00..1.33 rows=33 width=57) (actual time=0.006..0.014 rows=41 loops=1)
                                                                           Buffers: shared hit=1
                                                         ->  Hash  (cost=1.33..1.33 rows=33 width=53) (actual time=0.020..0.020 rows=41 loops=1)
                                                               Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                               Buffers: shared hit=1
                                                               ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.33 rows=33 width=53) (actual time=0.003..0.010 rows=41 loops=1)
                                                                     Buffers: shared hit=1
                                       ->  Hash  (cost=99.14..99.14 rows=4414 width=4) (actual time=1.439..1.440 rows=4421 loops=1)
                                             Buckets: 8192  Batches: 1  Memory Usage: 220kB
                                             Buffers: shared hit=55
                                             ->  Seq Scan on "ModInstaller"  (cost=0.00..99.14 rows=4414 width=4) (actual time=0.006..0.710 rows=4421 loops=1)
                                                   Buffers: shared hit=55
                                 ->  Hash  (cost=1.80..1.80 rows=1 width=67) (actual time=0.014..0.014 rows=0 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=67) (actual time=0.013..0.014 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 67
                                             Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.015..0.015 rows=1 loops=11)
                 Buffers: shared hit=55
                 ->  Unique  (cost=0.43..16.51 rows=1 width=111) (actual time=0.007..0.007 rows=1 loops=11)
                       Buffers: shared hit=55
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=111) (actual time=0.006..0.007 rows=1 loops=11)
                             Buffers: shared hit=55
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.003..0.003 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Index Scan using "Source_pkey" on "Source" modsourcesource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.002..0.002 rows=1 loops=11)
                                   Index Cond: (url = "ModSource_1"."sourceUrl")
                                   Buffers: shared hit=22
         SubPlan 2
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.005..0.006 rows=1 loops=11)
                 Buffers: shared hit=31
                 ->  Unique  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.003 rows=0 loops=11)
                       Buffers: shared hit=31
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.003 rows=0 loops=11)
                             Buffers: shared hit=31
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller" "ModInstaller_1"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.002..0.002 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=25
                             ->  Index Scan using "Source_pkey" on "Source" modinstallersource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.001..0.002 rows=1 loops=3)
                                   Index Cond: (url = "ModInstaller_1"."sourceUrl")
                                   Buffers: shared hit=6
 Planning:
   Buffers: shared hit=84
 Planning Time: 6.355 ms
 Execution Time: 157.476 ms
(106 rows)