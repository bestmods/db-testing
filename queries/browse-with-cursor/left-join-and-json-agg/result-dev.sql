 Limit  (cost=4058.32..4058.35 rows=11 width=403) (actual time=215.762..215.777 rows=11 loops=1)
   Buffers: shared hit=2222
   ->  Sort  (cost=4058.32..4071.96 rows=5457 width=403) (actual time=215.761..215.774 rows=11 loops=1)
         Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
         Sort Method: top-N heapsort  Memory: 36kB
         Buffers: shared hit=2222
         ->  GroupAggregate  (cost=3568.29..3936.64 rows=5457 width=403) (actual time=56.621..209.269 rows=15678 loops=1)
               Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
               Buffers: shared hit=2222
               ->  Sort  (cost=3568.29..3581.94 rows=5457 width=699) (actual time=56.545..58.703 rows=15680 loops=1)
                     Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
                     Sort Method: quicksort  Memory: 9941kB
                     Buffers: shared hit=2222
                     ->  Hash Left Join  (cost=2532.75..3229.58 rows=5457 width=699) (actual time=14.509..47.140 rows=15680 loops=1)
                           Hash Cond: ("Mod".id = ratingsub."modId")
                           Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                           Rows Removed by Filter: 54
                           Buffers: shared hit=2222
                           ->  Hash Left Join  (cost=2528.99..3184.50 rows=15728 width=683) (actual time=14.453..42.164 rows=15734 loops=1)
                                 Hash Cond: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=2221
                                 ->  Hash Left Join  (cost=2527.14..3141.36 rows=15728 width=682) (actual time=14.441..38.258 rows=15734 loops=1)
                                       Hash Cond: (category."parentId" = categoryparent.id)
                                       Buffers: shared hit=2220
                                       ->  Hash Left Join  (cost=2525.21..3093.87 rows=15728 width=586) (actual time=14.425..34.302 rows=15734 loops=1)
                                             Hash Cond: ("Mod"."categoryId" = category.id)
                                             Buffers: shared hit=2219
                                             ->  Hash Left Join  (cost=2523.29..3046.39 rows=15728 width=486) (actual time=14.405..29.967 rows=15734 loops=1)
                                                   Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                                   Buffers: shared hit=2218
                                                   ->  Hash Right Join  (cost=2356.08..2777.34 rows=15728 width=354) (actual time=12.548..23.792 rows=15734 loops=1)
                                                         Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                         Buffers: shared hit=2164
                                                         ->  Hash Left Join  (cost=1.20..381.17 rows=15725 width=115) (actual time=0.023..5.297 rows=15725 loops=1)
                                                               Hash Cond: ("ModSource"."sourceUrl" = modsourcesource.url)
                                                               Buffers: shared hit=163
                                                               ->  Seq Scan on "ModSource"  (cost=0.00..319.25 rows=15725 width=51) (actual time=0.005..1.361 rows=15725 loops=1)
                                                                     Buffers: shared hit=162
                                                               ->  Hash  (cost=1.09..1.09 rows=9 width=96) (actual time=0.007..0.008 rows=9 loops=1)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                                     Buffers: shared hit=1
                                                                     ->  Seq Scan on "Source" modsourcesource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.003..0.004 rows=9 loops=1)
                                                                           Buffers: shared hit=1
                                                         ->  Hash  (cost=2158.28..2158.28 rows=15728 width=239) (actual time=12.506..12.507 rows=15728 loops=1)
                                                               Buckets: 16384  Batches: 1  Memory Usage: 4288kB
                                                               Buffers: shared hit=2001
                                                               ->  Seq Scan on "Mod"  (cost=0.00..2158.28 rows=15728 width=239) (actual time=0.008..7.527 rows=15728 loops=1)
                                                                     Filter: visible
                                                                     Buffers: shared hit=2001
                                                   ->  Hash  (cost=113.62..113.62 rows=4287 width=132) (actual time=1.848..1.850 rows=4287 loops=1)
                                                         Buckets: 8192  Batches: 1  Memory Usage: 688kB
                                                         Buffers: shared hit=54
                                                         ->  Hash Left Join  (cost=1.20..113.62 rows=4287 width=132) (actual time=0.012..1.263 rows=4287 loops=1)
                                                               Hash Cond: ("ModInstaller"."sourceUrl" = modinstallersource.url)
                                                               Buffers: shared hit=54
                                                               ->  Seq Scan on "ModInstaller"  (cost=0.00..95.87 rows=4287 width=68) (actual time=0.003..0.300 rows=4287 loops=1)
                                                                     Buffers: shared hit=53
                                                               ->  Hash  (cost=1.09..1.09 rows=9 width=96) (actual time=0.005..0.005 rows=9 loops=1)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                                     Buffers: shared hit=1
                                                                     ->  Seq Scan on "Source" modinstallersource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.002..0.003 rows=9 loops=1)
                                                                           Buffers: shared hit=1
                                             ->  Hash  (cost=1.41..1.41 rows=41 width=104) (actual time=0.014..0.015 rows=41 loops=1)
                                                   Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                   Buffers: shared hit=1
                                                   ->  Seq Scan on "Category" category  (cost=0.00..1.41 rows=41 width=104) (actual time=0.003..0.008 rows=41 loops=1)
                                                         Buffers: shared hit=1
                                       ->  Hash  (cost=1.41..1.41 rows=41 width=100) (actual time=0.012..0.013 rows=41 loops=1)
                                             Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.41 rows=41 width=100) (actual time=0.002..0.006 rows=41 loops=1)
                                                   Buffers: shared hit=1
                                 ->  Hash  (cost=1.84..1.84 rows=1 width=5) (actual time=0.008..0.008 rows=0 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.84 rows=1 width=5) (actual time=0.008..0.008 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 71
                                             Buffers: shared hit=1
                           ->  Hash  (cost=3.15..3.15 rows=49 width=20) (actual time=0.042..0.043 rows=52 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                 Buffers: shared hit=1
                                 ->  Subquery Scan on ratingsub  (cost=2.17..3.15 rows=49 width=20) (actual time=0.026..0.037 rows=52 loops=1)
                                       Buffers: shared hit=1
                                       ->  HashAggregate  (cost=2.17..2.66 rows=49 width=20) (actual time=0.025..0.031 rows=52 loops=1)
                                             Group Key: "ModRating_1"."modId"
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.67 rows=67 width=5) (actual time=0.002..0.005 rows=71 loops=1)
                                                   Buffers: shared hit=1
 Planning Time: 4.561 ms
 Execution Time: 215.966 ms
(91 rows)