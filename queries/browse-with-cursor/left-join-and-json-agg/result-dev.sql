 Limit  (cost=4044.68..4044.70 rows=11 width=403) (actual time=201.466..201.480 rows=11 loops=1)
   Buffers: shared hit=2222
   ->  Sort  (cost=4044.68..4058.32 rows=5457 width=403) (actual time=201.465..201.478 rows=11 loops=1)
         Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
         Sort Method: top-N heapsort  Memory: 35kB
         Buffers: shared hit=2222
         ->  GroupAggregate  (cost=3568.29..3923.00 rows=5457 width=403) (actual time=53.362..195.025 rows=15680 loops=1)
               Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
               Buffers: shared hit=2222
               ->  Sort  (cost=3568.29..3581.94 rows=5457 width=761) (actual time=53.315..55.179 rows=15682 loops=1)
                     Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
                     Sort Method: quicksort  Memory: 9942kB
                     Buffers: shared hit=2222
                     ->  Hash Left Join  (cost=2532.75..3229.58 rows=5457 width=761) (actual time=15.433..46.912 rows=15682 loops=1)
                           Hash Cond: ("Mod".id = ratingsub."modId")
                           Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                           Rows Removed by Filter: 52
                           Buffers: shared hit=2222
                           ->  Hash Left Join  (cost=2528.99..3184.50 rows=15728 width=745) (actual time=15.381..41.980 rows=15734 loops=1)
                                 Hash Cond: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=2221
                                 ->  Hash Left Join  (cost=2527.14..3141.36 rows=15728 width=682) (actual time=15.371..38.019 rows=15734 loops=1)
                                       Hash Cond: (category."parentId" = categoryparent.id)
                                       Buffers: shared hit=2220
                                       ->  Hash Left Join  (cost=2525.21..3093.87 rows=15728 width=586) (actual time=15.356..34.064 rows=15734 loops=1)
                                             Hash Cond: ("Mod"."categoryId" = category.id)
                                             Buffers: shared hit=2219
                                             ->  Hash Left Join  (cost=2523.29..3046.39 rows=15728 width=486) (actual time=15.338..29.870 rows=15734 loops=1)
                                                   Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                                   Buffers: shared hit=2218
                                                   ->  Hash Right Join  (cost=2356.08..2777.34 rows=15728 width=354) (actual time=13.459..24.078 rows=15734 loops=1)
                                                         Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                         Buffers: shared hit=2164
                                                         ->  Hash Left Join  (cost=1.20..381.17 rows=15725 width=115) (actual time=0.025..5.087 rows=15725 loops=1)
                                                               Hash Cond: ("ModSource"."sourceUrl" = modsourcesource.url)
                                                               Buffers: shared hit=163
                                                               ->  Seq Scan on "ModSource"  (cost=0.00..319.25 rows=15725 width=51) (actual time=0.006..1.268 rows=15725 loops=1)
                                                                     Buffers: shared hit=162
                                                               ->  Hash  (cost=1.09..1.09 rows=9 width=96) (actual time=0.008..0.009 rows=9 loops=1)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                                     Buffers: shared hit=1
                                                                     ->  Seq Scan on "Source" modsourcesource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.004..0.005 rows=9 loops=1)
                                                                           Buffers: shared hit=1
                                                         ->  Hash  (cost=2158.28..2158.28 rows=15728 width=239) (actual time=13.420..13.421 rows=15728 loops=1)
                                                               Buckets: 16384  Batches: 1  Memory Usage: 4288kB
                                                               Buffers: shared hit=2001
                                                               ->  Seq Scan on "Mod"  (cost=0.00..2158.28 rows=15728 width=239) (actual time=0.009..8.071 rows=15728 loops=1)
                                                                     Filter: visible
                                                                     Buffers: shared hit=2001
                                                   ->  Hash  (cost=113.62..113.62 rows=4287 width=132) (actual time=1.872..1.874 rows=4287 loops=1)
                                                         Buckets: 8192  Batches: 1  Memory Usage: 688kB
                                                         Buffers: shared hit=54
                                                         ->  Hash Left Join  (cost=1.20..113.62 rows=4287 width=132) (actual time=0.011..1.290 rows=4287 loops=1)
                                                               Hash Cond: ("ModInstaller"."sourceUrl" = modinstallersource.url)
                                                               Buffers: shared hit=54
                                                               ->  Seq Scan on "ModInstaller"  (cost=0.00..95.87 rows=4287 width=68) (actual time=0.003..0.310 rows=4287 loops=1)
                                                                     Buffers: shared hit=53
                                                               ->  Hash  (cost=1.09..1.09 rows=9 width=96) (actual time=0.004..0.005 rows=9 loops=1)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                                     Buffers: shared hit=1
                                                                     ->  Seq Scan on "Source" modinstallersource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.002..0.003 rows=9 loops=1)
                                                                           Buffers: shared hit=1
                                             ->  Hash  (cost=1.41..1.41 rows=41 width=104) (actual time=0.014..0.014 rows=41 loops=1)
                                                   Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                   Buffers: shared hit=1
                                                   ->  Seq Scan on "Category" category  (cost=0.00..1.41 rows=41 width=104) (actual time=0.003..0.008 rows=41 loops=1)
                                                         Buffers: shared hit=1
                                       ->  Hash  (cost=1.41..1.41 rows=41 width=100) (actual time=0.011..0.012 rows=41 loops=1)
                                             Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.41 rows=41 width=100) (actual time=0.001..0.005 rows=41 loops=1)
                                                   Buffers: shared hit=1
                                 ->  Hash  (cost=1.84..1.84 rows=1 width=67) (actual time=0.007..0.007 rows=0 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.84 rows=1 width=67) (actual time=0.006..0.006 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 67
                                             Buffers: shared hit=1
                           ->  Hash  (cost=3.15..3.15 rows=49 width=20) (actual time=0.039..0.040 rows=49 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                 Buffers: shared hit=1
                                 ->  Subquery Scan on ratingsub  (cost=2.17..3.15 rows=49 width=20) (actual time=0.023..0.034 rows=49 loops=1)
                                       Buffers: shared hit=1
                                       ->  HashAggregate  (cost=2.17..2.66 rows=49 width=20) (actual time=0.023..0.029 rows=49 loops=1)
                                             Group Key: "ModRating_1"."modId"
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.67 rows=67 width=5) (actual time=0.001..0.004 rows=67 loops=1)
                                                   Buffers: shared hit=1
 Planning Time: 4.564 ms
 Execution Time: 201.661 ms
(91 rows)