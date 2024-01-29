 Limit  (cost=5224.18..5434.22 rows=11 width=395) (actual time=92.909..93.027 rows=11 loops=1)
   Buffers: shared hit=2294
   ->  Result  (cost=5224.18..305550.34 rows=15728 width=395) (actual time=92.907..93.024 rows=11 loops=1)
         Buffers: shared hit=2294
         ->  Sort  (cost=5224.18..5263.50 rows=15728 width=331) (actual time=92.844..92.850 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 31kB
               Buffers: shared hit=2220
               ->  GroupAggregate  (cost=4244.37..4873.49 rows=15728 width=331) (actual time=42.135..87.543 rows=15728 loops=1)
                     Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=2220
                     ->  Sort  (cost=4244.37..4283.69 rows=15728 width=514) (actual time=42.110..43.168 rows=15734 loops=1)
                           Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                           Sort Method: quicksort  Memory: 7514kB
                           Buffers: shared hit=2220
                           ->  Hash Left Join  (cost=2511.92..3148.04 rows=15728 width=514) (actual time=13.923..36.949 rows=15734 loops=1)
                                 Hash Cond: ("Mod".id = ratingsub."modId")
                                 Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                 Buffers: shared hit=2220
                                 ->  Hash Left Join  (cost=2510.03..3104.83 rows=15728 width=498) (actual time=13.906..32.866 rows=15734 loops=1)
                                       Hash Cond: ("Mod".id = "ModRating"."modId")
                                       Buffers: shared hit=2219
                                       ->  Hash Left Join  (cost=2508.18..3061.69 rows=15728 width=435) (actual time=13.896..29.782 rows=15734 loops=1)
                                             Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                             Buffers: shared hit=2218
                                             ->  Hash Left Join  (cost=2358.72..2810.38 rows=15728 width=435) (actual time=13.094..25.554 rows=15734 loops=1)
                                                   Hash Cond: (category."parentId" = categoryparent.id)
                                                   Buffers: shared hit=2165
                                                   ->  Hash Left Join  (cost=2356.80..2762.90 rows=15728 width=339) (actual time=13.073..22.540 rows=15734 loops=1)
                                                         Hash Cond: ("Mod"."categoryId" = category.id)
                                                         Buffers: shared hit=2164
                                                         ->  Hash Right Join  (cost=2354.88..2715.42 rows=15728 width=239) (actual time=13.044..18.982 rows=15734 loops=1)
                                                               Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                               Buffers: shared hit=2163
                                                               ->  Seq Scan on "ModSource"  (cost=0.00..319.25 rows=15725 width=4) (actual time=0.007..1.229 rows=15725 loops=1)
                                                                     Buffers: shared hit=162
                                                               ->  Hash  (cost=2158.28..2158.28 rows=15728 width=239) (actual time=13.021..13.021 rows=15728 loops=1)
                                                                     Buckets: 16384  Batches: 1  Memory Usage: 4288kB
                                                                     Buffers: shared hit=2001
                                                                     ->  Seq Scan on "Mod"  (cost=0.00..2158.28 rows=15728 width=239) (actual time=0.009..7.837 rows=15728 loops=1)
                                                                           Filter: visible
                                                                           Buffers: shared hit=2001
                                                         ->  Hash  (cost=1.41..1.41 rows=41 width=104) (actual time=0.020..0.021 rows=41 loops=1)
                                                               Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                               Buffers: shared hit=1
                                                               ->  Seq Scan on "Category" category  (cost=0.00..1.41 rows=41 width=104) (actual time=0.004..0.011 rows=41 loops=1)
                                                                     Buffers: shared hit=1
                                                   ->  Hash  (cost=1.41..1.41 rows=41 width=100) (actual time=0.017..0.017 rows=41 loops=1)
                                                         Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                         Buffers: shared hit=1
                                                         ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.41 rows=41 width=100) (actual time=0.002..0.008 rows=41 loops=1)
                                                               Buffers: shared hit=1
                                             ->  Hash  (cost=95.87..95.87 rows=4287 width=4) (actual time=0.794..0.795 rows=4287 loops=1)
                                                   Buckets: 8192  Batches: 1  Memory Usage: 215kB
                                                   Buffers: shared hit=53
                                                   ->  Seq Scan on "ModInstaller"  (cost=0.00..95.87 rows=4287 width=4) (actual time=0.004..0.398 rows=4287 loops=1)
                                                         Buffers: shared hit=53
                                       ->  Hash  (cost=1.84..1.84 rows=1 width=67) (actual time=0.007..0.007 rows=0 loops=1)
                                             Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "ModRating"  (cost=0.00..1.84 rows=1 width=67) (actual time=0.007..0.007 rows=0 loops=1)
                                                   Filter: ("userId" = ''::text)
                                                   Rows Removed by Filter: 67
                                                   Buffers: shared hit=1
                                 ->  Hash  (cost=1.88..1.88 rows=1 width=20) (actual time=0.012..0.013 rows=0 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                       Buffers: shared hit=1
                                       ->  Subquery Scan on ratingsub  (cost=1.85..1.88 rows=1 width=20) (actual time=0.011..0.012 rows=0 loops=1)
                                             Buffers: shared hit=1
                                             ->  GroupAggregate  (cost=1.85..1.87 rows=1 width=20) (actual time=0.011..0.011 rows=0 loops=1)
                                                   Group Key: "ModRating_1"."modId"
                                                   Buffers: shared hit=1
                                                   ->  Sort  (cost=1.85..1.85 rows=1 width=5) (actual time=0.010..0.010 rows=0 loops=1)
                                                         Sort Key: "ModRating_1"."modId"
                                                         Sort Method: quicksort  Memory: 25kB
                                                         Buffers: shared hit=1
                                                         ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.84 rows=1 width=5) (actual time=0.005..0.005 rows=0 loops=1)
                                                               Filter: ("createdAt" > '2024-01-28 11:47:48.889'::timestamp without time zone)
                                                               Rows Removed by Filter: 67
                                                               Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.010..0.010 rows=1 loops=11)
                 Buffers: shared hit=44
                 ->  Unique  (cost=0.29..9.51 rows=1 width=111) (actual time=0.004..0.005 rows=1 loops=11)
                       Buffers: shared hit=44
                       ->  Nested Loop Left Join  (cost=0.29..9.51 rows=1 width=111) (actual time=0.004..0.004 rows=1 loops=11)
                             Join Filter: ("ModSource_1"."sourceUrl" = modsourcesource.url)
                             Rows Removed by Join Filter: 3
                             Buffers: shared hit=44
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.002..0.002 rows=1 loops=11)
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
                             Join Filter: ("ModInstaller_1"."sourceUrl" = modinstallersource.url)
                             Rows Removed by Join Filter: 1
                             Buffers: shared hit=30
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller" "ModInstaller_1"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.001..0.001 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=26
                             ->  Seq Scan on "Source" modinstallersource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.000..0.000 rows=3 loops=4)
                                   Buffers: shared hit=4
 Planning Time: 3.559 ms
 Execution Time: 93.194 ms
(110 rows)