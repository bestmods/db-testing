 Limit  (cost=5817.83..6182.00 rows=11 width=395) (actual time=155.275..155.486 rows=11 loops=1)
   Buffers: shared hit=2780
   ->  Result  (cost=5817.83..547670.97 rows=16367 width=395) (actual time=155.274..155.482 rows=11 loops=1)
         Buffers: shared hit=2780
         ->  Sort  (cost=5817.83..5858.75 rows=16367 width=331) (actual time=155.173..155.186 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 32kB
               Buffers: shared hit=2691
               ->  GroupAggregate  (cost=4798.22..5452.90 rows=16367 width=331) (actual time=69.954..144.951 rows=16293 loops=1)
                     Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=2691
                     ->  Sort  (cost=4798.22..4839.13 rows=16367 width=420) (actual time=69.922..71.637 rows=16299 loops=1)
                           Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                           Sort Method: quicksort  Memory: 5746kB
                           Buffers: shared hit=2691
                           ->  Hash Left Join  (cost=2991.60..3652.65 rows=16367 width=420) (actual time=21.948..58.248 rows=16299 loops=1)
                                 Hash Cond: ("Mod".id = ratingsub."modId")
                                 Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                 Buffers: shared hit=2691
                                 ->  Hash Left Join  (cost=2989.74..3607.80 rows=16367 width=404) (actual time=21.924..52.718 rows=16299 loops=1)
                                       Hash Cond: ("Mod".id = "ModRating"."modId")
                                       Buffers: shared hit=2690
                                       ->  Hash Left Join  (cost=2987.93..3563.01 rows=16367 width=341) (actual time=21.903..48.873 rows=16299 loops=1)
                                             Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                             Buffers: shared hit=2689
                                             ->  Hash Left Join  (cost=2833.62..3303.04 rows=16367 width=341) (actual time=20.467..42.584 rows=16299 loops=1)
                                                   Hash Cond: (category."parentId" = categoryparent.id)
                                                   Buffers: shared hit=2634
                                                   ->  Hash Left Join  (cost=2831.88..3256.00 rows=16367 width=292) (actual time=20.435..38.890 rows=16299 loops=1)
                                                         Hash Cond: ("Mod"."categoryId" = category.id)
                                                         Buffers: shared hit=2633
                                                         ->  Hash Right Join  (cost=2830.13..3205.78 rows=16367 width=239) (actual time=20.379..33.419 rows=16299 loops=1)
                                                               Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                               Buffers: shared hit=2632
                                                               ->  Seq Scan on "ModSource"  (cost=0.00..332.67 rows=16367 width=4) (actual time=0.013..1.964 rows=16290 loops=1)
                                                                     Buffers: shared hit=169
                                                               ->  Hash  (cost=2626.17..2626.17 rows=16317 width=239) (actual time=20.327..20.328 rows=16293 loops=1)
                                                                     Buckets: 16384  Batches: 1  Memory Usage: 4440kB
                                                                     Buffers: shared hit=2463
                                                                     ->  Seq Scan on "Mod"  (cost=0.00..2626.17 rows=16317 width=239) (actual time=0.011..12.392 rows=16293 loops=1)
                                                                           Filter: visible
                                                                           Buffers: shared hit=2463
                                                         ->  Hash  (cost=1.33..1.33 rows=33 width=57) (actual time=0.044..0.044 rows=41 loops=1)
                                                               Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                               Buffers: shared hit=1
                                                               ->  Seq Scan on "Category" category  (cost=0.00..1.33 rows=33 width=57) (actual time=0.009..0.021 rows=41 loops=1)
                                                                     Buffers: shared hit=1
                                                   ->  Hash  (cost=1.33..1.33 rows=33 width=53) (actual time=0.025..0.026 rows=41 loops=1)
                                                         Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                         Buffers: shared hit=1
                                                         ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.33 rows=33 width=53) (actual time=0.006..0.013 rows=41 loops=1)
                                                               Buffers: shared hit=1
                                             ->  Hash  (cost=99.14..99.14 rows=4414 width=4) (actual time=1.422..1.423 rows=4421 loops=1)
                                                   Buckets: 8192  Batches: 1  Memory Usage: 220kB
                                                   Buffers: shared hit=55
                                                   ->  Seq Scan on "ModInstaller"  (cost=0.00..99.14 rows=4414 width=4) (actual time=0.006..0.712 rows=4421 loops=1)
                                                         Buffers: shared hit=55
                                       ->  Hash  (cost=1.80..1.80 rows=1 width=67) (actual time=0.014..0.016 rows=0 loops=1)
                                             Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=67) (actual time=0.014..0.014 rows=0 loops=1)
                                                   Filter: ("userId" = ''::text)
                                                   Rows Removed by Filter: 67
                                                   Buffers: shared hit=1
                                 ->  Hash  (cost=1.84..1.84 rows=1 width=20) (actual time=0.016..0.019 rows=0 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                       Buffers: shared hit=1
                                       ->  Subquery Scan on ratingsub  (cost=1.81..1.84 rows=1 width=20) (actual time=0.016..0.018 rows=0 loops=1)
                                             Buffers: shared hit=1
                                             ->  GroupAggregate  (cost=1.81..1.83 rows=1 width=20) (actual time=0.016..0.017 rows=0 loops=1)
                                                   Group Key: "ModRating_1"."modId"
                                                   Buffers: shared hit=1
                                                   ->  Sort  (cost=1.81..1.81 rows=1 width=5) (actual time=0.014..0.015 rows=0 loops=1)
                                                         Sort Key: "ModRating_1"."modId"
                                                         Sort Method: quicksort  Memory: 25kB
                                                         Buffers: shared hit=1
                                                         ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.80 rows=1 width=5) (actual time=0.009..0.009 rows=0 loops=1)
                                                               Filter: ("createdAt" > '2024-01-28 11:47:48.889'::timestamp without time zone)
                                                               Rows Removed by Filter: 67
                                                               Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.017..0.017 rows=1 loops=11)
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
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.007..0.008 rows=1 loops=11)
                 Buffers: shared hit=34
                 ->  Unique  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.003 rows=0 loops=11)
                       Buffers: shared hit=34
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.003 rows=0 loops=11)
                             Buffers: shared hit=34
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller" "ModInstaller_1"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.002..0.002 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=26
                             ->  Index Scan using "Source_pkey" on "Source" modinstallersource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.002..0.002 rows=1 loops=4)
                                   Index Cond: (url = "ModInstaller_1"."sourceUrl")
                                   Buffers: shared hit=8
 Planning:
   Buffers: shared hit=86
 Planning Time: 5.796 ms
 Execution Time: 155.717 ms
(110 rows)