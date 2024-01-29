 Limit  (cost=4240.48..4450.61 rows=11 width=375) (actual time=39.304..39.455 rows=11 loops=1)
   Buffers: shared hit=2293
   ->  GroupAggregate  (cost=4240.48..304684.60 rows=15728 width=375) (actual time=39.303..39.452 rows=11 loops=1)
         Group Key: "Mod".id, category.id, categoryparent.id
         Buffers: shared hit=2293
         ->  Sort  (cost=4240.48..4279.80 rows=15728 width=498) (actual time=39.220..39.225 rows=12 loops=1)
               Sort Key: "Mod".id DESC, category.id, categoryparent.id
               Sort Method: quicksort  Memory: 7514kB
               Buffers: shared hit=2219
               ->  Hash Left Join  (cost=2549.35..3144.15 rows=15728 width=498) (actual time=15.149..34.084 rows=15734 loops=1)
                     Hash Cond: ("Mod".id = "ModRating"."modId")
                     Buffers: shared hit=2219
                     ->  Hash Left Join  (cost=2547.50..3101.01 rows=15728 width=435) (actual time=15.138..31.105 rows=15734 loops=1)
                           Hash Cond: ("Mod".id = "ModInstaller"."modId")
                           Buffers: shared hit=2218
                           ->  Hash Left Join  (cost=2398.04..2849.70 rows=15728 width=435) (actual time=14.387..26.948 rows=15734 loops=1)
                                 Hash Cond: (category."parentId" = categoryparent.id)
                                 Buffers: shared hit=2165
                                 ->  Hash Left Join  (cost=2396.12..2802.22 rows=15728 width=339) (actual time=14.371..24.170 rows=15734 loops=1)
                                       Hash Cond: ("Mod"."categoryId" = category.id)
                                       Buffers: shared hit=2164
                                       ->  Hash Right Join  (cost=2394.20..2754.74 rows=15728 width=239) (actual time=14.349..20.646 rows=15734 loops=1)
                                             Hash Cond: ("ModSource"."modId" = "Mod".id)
                                             Buffers: shared hit=2163
                                             ->  Seq Scan on "ModSource"  (cost=0.00..319.25 rows=15725 width=4) (actual time=0.006..1.194 rows=15725 loops=1)
                                                   Buffers: shared hit=162
                                             ->  Hash  (cost=2197.60..2197.60 rows=15728 width=239) (actual time=14.328..14.329 rows=15728 loops=1)
                                                   Buckets: 16384  Batches: 1  Memory Usage: 4288kB
                                                   Buffers: shared hit=2001
                                                   ->  Seq Scan on "Mod"  (cost=0.00..2197.60 rows=15728 width=239) (actual time=0.009..8.624 rows=15728 loops=1)
                                                         Filter: (visible AND (id <= 1000000))
                                                         Buffers: shared hit=2001
                                       ->  Hash  (cost=1.41..1.41 rows=41 width=104) (actual time=0.014..0.015 rows=41 loops=1)
                                             Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "Category" category  (cost=0.00..1.41 rows=41 width=104) (actual time=0.003..0.008 rows=41 loops=1)
                                                   Buffers: shared hit=1
                                 ->  Hash  (cost=1.41..1.41 rows=41 width=100) (actual time=0.012..0.012 rows=41 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.41 rows=41 width=100) (actual time=0.001..0.005 rows=41 loops=1)
                                             Buffers: shared hit=1
                           ->  Hash  (cost=95.87..95.87 rows=4287 width=4) (actual time=0.744..0.744 rows=4287 loops=1)
                                 Buckets: 8192  Batches: 1  Memory Usage: 215kB
                                 Buffers: shared hit=53
                                 ->  Seq Scan on "ModInstaller"  (cost=0.00..95.87 rows=4287 width=4) (actual time=0.004..0.375 rows=4287 loops=1)
                                       Buffers: shared hit=53
                     ->  Hash  (cost=1.84..1.84 rows=1 width=67) (actual time=0.007..0.008 rows=0 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 8kB
                           Buffers: shared hit=1
                           ->  Seq Scan on "ModRating"  (cost=0.00..1.84 rows=1 width=67) (actual time=0.007..0.007 rows=0 loops=1)
                                 Filter: ("userId" = ''::text)
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
                             ->  Seq Scan on "Source" modinstallersource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.000..0.001 rows=3 loops=4)
                                   Buffers: shared hit=4
 Planning Time: 1.859 ms
 Execution Time: 39.584 ms
(84 rows)