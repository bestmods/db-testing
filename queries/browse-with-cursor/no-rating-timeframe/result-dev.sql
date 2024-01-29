 Limit  (cost=14892.68..15102.73 rows=11 width=427) (actual time=438.494..438.622 rows=11 loops=1)
   Buffers: shared hit=3421, temp read=4737 written=4747
   ->  Result  (cost=14892.68..444243.76 rows=22485 width=427) (actual time=438.492..438.619 rows=11 loops=1)
         Buffers: shared hit=3421, temp read=4737 written=4747
         ->  Sort  (cost=14892.68..14948.89 rows=22485 width=363) (actual time=438.400..438.413 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 42kB
               Buffers: shared hit=3347, temp read=4737 written=4747
               ->  GroupAggregate  (cost=13379.51..14391.33 rows=22485 width=363) (actual time=142.466..431.885 rows=15680 loops=1)
                     Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=3347, temp read=4737 written=4747
                     ->  Sort  (cost=13379.51..13435.72 rows=22485 width=647) (actual time=142.382..153.693 rows=64984 loops=1)
                           Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                           Sort Method: external merge  Disk: 27752kB
                           Buffers: shared hit=3347, temp read=4737 written=4747
                           ->  Hash Left Join  (cost=2994.66..5296.71 rows=22485 width=647) (actual time=40.025..102.185 rows=64984 loops=1)
                                 Hash Cond: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=3347, temp read=1268 written=1268
                                 ->  Hash Right Join  (cost=2992.81..5235.83 rows=22485 width=584) (actual time=40.006..88.308 rows=64984 loops=1)
                                       Hash Cond: ("ModDownload"."modId" = "Mod".id)
                                       Buffers: shared hit=3346, temp read=1268 written=1268
                                       ->  Seq Scan on "ModDownload"  (cost=0.00..1775.11 rows=64811 width=137) (actual time=0.020..15.836 rows=64811 loops=1)
                                             Buffers: shared hit=1127
                                       ->  Hash  (cost=2924.60..2924.60 rows=5457 width=451) (actual time=39.958..39.967 rows=15682 loops=1)
                                             Buckets: 16384 (originally 8192)  Batches: 2 (originally 1)  Memory Usage: 3969kB
                                             Buffers: shared hit=2219, temp read=323 written=623
                                             ->  Hash Left Join  (cost=2424.87..2924.60 rows=5457 width=451) (actual time=14.953..33.824 rows=15682 loops=1)
                                                   Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                                   Buffers: shared hit=2219, temp read=323 written=323
                                                   ->  Hash Left Join  (cost=2275.42..2739.80 rows=5457 width=451) (actual time=14.176..29.558 rows=15682 loops=1)
                                                         Hash Cond: (category."parentId" = categoryparent.id)
                                                         Buffers: shared hit=2166, temp read=323 written=323
                                                         ->  Hash Left Join  (cost=2273.49..2722.08 rows=5457 width=355) (actual time=14.161..26.656 rows=15682 loops=1)
                                                               Hash Cond: ("Mod"."categoryId" = category.id)
                                                               Buffers: shared hit=2165, temp read=323 written=323
                                                               ->  Hash Right Join  (cost=2271.57..2704.35 rows=5457 width=255) (actual time=14.137..23.024 rows=15682 loops=1)
                                                                     Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                                     Buffers: shared hit=2164, temp read=323 written=323
                                                                     ->  Seq Scan on "ModSource"  (cost=0.00..319.25 rows=15725 width=4) (actual time=0.008..1.100 rows=15725 loops=1)
                                                                           Buffers: shared hit=162
                                                                     ->  Hash  (cost=2203.36..2203.36 rows=5457 width=255) (actual time=14.110..14.113 rows=15680 loops=1)
                                                                           Buckets: 16384 (originally 8192)  Batches: 2 (originally 1)  Memory Usage: 3969kB
                                                                           Buffers: shared hit=2002, temp written=252
                                                                           ->  Hash Left Join  (cost=3.76..2203.36 rows=5457 width=255) (actual time=0.056..8.737 rows=15680 loops=1)
                                                                                 Hash Cond: ("Mod".id = ratingsub."modId")
                                                                                 Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                                                                 Rows Removed by Filter: 48
                                                                                 Buffers: shared hit=2002
                                                                                 ->  Seq Scan on "Mod"  (cost=0.00..2158.28 rows=15728 width=239) (actual time=0.008..3.171 rows=15728 loops=1)
                                                                                       Filter: visible
                                                                                       Buffers: shared hit=2001
                                                                                 ->  Hash  (cost=3.15..3.15 rows=49 width=20) (actual time=0.044..0.046 rows=49 loops=1)
                                                                                       Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                                                       Buffers: shared hit=1
                                                                                       ->  Subquery Scan on ratingsub  (cost=2.17..3.15 rows=49 width=20) (actual time=0.028..0.039 rows=49 loops=1)
                                                                                             Buffers: shared hit=1
                                                                                             ->  HashAggregate  (cost=2.17..2.66 rows=49 width=20) (actual time=0.028..0.034 rows=49 loops=1)
                                                                                                   Group Key: "ModRating_1"."modId"
                                                                                                   Buffers: shared hit=1
                                                                                                   ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.67 rows=67 width=5) (actual time=0.003..0.006 rows=67 loops=1)
                                                                                                         Buffers: shared hit=1
                                                               ->  Hash  (cost=1.41..1.41 rows=41 width=104) (actual time=0.015..0.016 rows=41 loops=1)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                     Buffers: shared hit=1
                                                                     ->  Seq Scan on "Category" category  (cost=0.00..1.41 rows=41 width=104) (actual time=0.004..0.009 rows=41 loops=1)
                                                                           Buffers: shared hit=1
                                                         ->  Hash  (cost=1.41..1.41 rows=41 width=100) (actual time=0.011..0.012 rows=41 loops=1)
                                                               Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                               Buffers: shared hit=1
                                                               ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.41 rows=41 width=100) (actual time=0.001..0.005 rows=41 loops=1)
                                                                     Buffers: shared hit=1
                                                   ->  Hash  (cost=95.87..95.87 rows=4287 width=4) (actual time=0.773..0.773 rows=4287 loops=1)
                                                         Buckets: 8192  Batches: 1  Memory Usage: 215kB
                                                         Buffers: shared hit=53
                                                         ->  Seq Scan on "ModInstaller"  (cost=0.00..95.87 rows=4287 width=4) (actual time=0.005..0.384 rows=4287 loops=1)
                                                               Buffers: shared hit=53
                                 ->  Hash  (cost=1.84..1.84 rows=1 width=67) (actual time=0.010..0.010 rows=0 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.84 rows=1 width=67) (actual time=0.009..0.010 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 67
                                             Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.012..0.012 rows=1 loops=11)
                 Buffers: shared hit=44
                 ->  Unique  (cost=0.29..9.51 rows=1 width=111) (actual time=0.006..0.006 rows=1 loops=11)
                       Buffers: shared hit=44
                       ->  Nested Loop Left Join  (cost=0.29..9.51 rows=1 width=111) (actual time=0.005..0.006 rows=1 loops=11)
                             Join Filter: ("ModSource_1"."sourceUrl" = modsourcesource.url)
                             Rows Removed by Join Filter: 3
                             Buffers: shared hit=44
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.003..0.003 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Seq Scan on "Source" modsourcesource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.001..0.001 rows=4 loops=11)
                                   Buffers: shared hit=11
         SubPlan 2
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.005..0.005 rows=1 loops=11)
                 Buffers: shared hit=30
                 ->  Unique  (cost=0.28..9.51 rows=1 width=128) (actual time=0.002..0.002 rows=0 loops=11)
                       Buffers: shared hit=30
                       ->  Nested Loop Left Join  (cost=0.28..9.50 rows=1 width=128) (actual time=0.002..0.002 rows=0 loops=11)
                             Join Filter: ("ModInstaller_1"."sourceUrl" = modinstallersource.url)
                             Rows Removed by Join Filter: 1
                             Buffers: shared hit=30
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller" "ModInstaller_1"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.001..0.001 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=26
                             ->  Seq Scan on "Source" modinstallersource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.000..0.000 rows=3 loops=4)
                                   Buffers: shared hit=4
 Planning Time: 7.883 ms
 Execution Time: 441.586 ms
(113 rows)