 Limit  (cost=12389.31..12753.49 rows=11 width=427) (actual time=605.970..606.317 rows=11 loops=1)
   Buffers: shared hit=68381
   ->  Result  (cost=12389.31..747882.03 rows=22216 width=427) (actual time=605.969..606.313 rows=11 loops=1)
         Buffers: shared hit=68381
         ->  Sort  (cost=12389.31..12444.85 rows=22216 width=363) (actual time=605.902..606.059 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 45kB
               Buffers: shared hit=68298
               ->  GroupAggregate  (cost=4423.62..11893.96 rows=22216 width=363) (actual time=37.411..591.265 rows=15670 loops=1)
                     Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=68298
                     ->  Nested Loop Left Join  (cost=4423.62..10949.78 rows=22216 width=553) (actual time=37.367..152.506 rows=64935 loops=1)
                           Buffers: shared hit=68298
                           ->  Merge Left Join  (cost=4423.21..5062.77 rows=5491 width=420) (actual time=37.345..54.371 rows=15672 loops=1)
                                 Merge Cond: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=2815
                                 ->  Gather Merge  (cost=4421.40..5047.21 rows=5491 width=357) (actual time=37.317..46.425 rows=15672 loops=1)
                                       Workers Planned: 1
                                       Workers Launched: 1
                                       Buffers: shared hit=2814
                                       ->  Sort  (cost=3421.39..3429.46 rows=3230 width=357) (actual time=33.825..35.625 rows=7836 loops=2)
                                             Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                                             Sort Method: quicksort  Memory: 3046kB
                                             Buffers: shared hit=2814
                                             Worker 0:  Sort Method: quicksort  Memory: 2592kB
                                             ->  Hash Left Join  (cost=674.01..3233.12 rows=3230 width=357) (actual time=7.526..27.184 rows=7836 loops=2)
                                                   Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                                   Buffers: shared hit=2795
                                                   ->  Hash Left Join  (cost=525.32..3063.63 rows=3230 width=357) (actual time=6.117..23.106 rows=7836 loops=2)
                                                         Hash Cond: ("Mod".id = "ModSource"."modId")
                                                         Buffers: shared hit=2689
                                                         ->  Hash Left Join  (cost=7.13..2497.02 rows=3230 width=357) (actual time=0.231..13.444 rows=7835 loops=2)
                                                               Hash Cond: (category."parentId" = categoryparent.id)
                                                               Buffers: shared hit=2363
                                                               ->  Hash Left Join  (cost=5.39..2486.33 rows=3230 width=308) (actual time=0.190..11.622 rows=7835 loops=2)
                                                                     Hash Cond: ("Mod"."categoryId" = category.id)
                                                                     Buffers: shared hit=2361
                                                                     ->  Hash Left Join  (cost=3.65..2475.02 rows=3230 width=255) (actual time=0.139..8.845 rows=7835 loops=2)
                                                                           Hash Cond: ("Mod".id = ratingsub."modId")
                                                                           Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                                                           Rows Removed by Filter: 24
                                                                           Buffers: shared hit=2359
                                                                           ->  Parallel Seq Scan on "Mod"  (cost=0.00..2446.95 rows=9295 width=239) (actual time=0.008..6.179 rows=7859 loops=2)
                                                                                 Filter: visible
                                                                                 Buffers: shared hit=2354
                                                                           ->  Hash  (cost=3.06..3.06 rows=47 width=20) (actual time=0.107..0.115 rows=49 loops=2)
                                                                                 Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                                                 Buffers: shared hit=2
                                                                                 ->  Subquery Scan on ratingsub  (cost=2.12..3.06 rows=47 width=20) (actual time=0.064..0.093 rows=49 loops=2)
                                                                                       Buffers: shared hit=2
                                                                                       ->  HashAggregate  (cost=2.12..2.59 rows=47 width=20) (actual time=0.064..0.083 rows=49 loops=2)
                                                                                             Group Key: "ModRating_1"."modId"
                                                                                             Batches: 1  Memory Usage: 24kB
                                                                                             Buffers: shared hit=2
                                                                                             Worker 0:  Batches: 1  Memory Usage: 24kB
                                                                                             ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.64 rows=64 width=5) (actual time=0.016..0.024 rows=67 loops=2)
                                                                                                   Buffers: shared hit=2
                                                                     ->  Hash  (cost=1.33..1.33 rows=33 width=57) (actual time=0.039..0.040 rows=41 loops=2)
                                                                           Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                           Buffers: shared hit=2
                                                                           ->  Seq Scan on "Category" category  (cost=0.00..1.33 rows=33 width=57) (actual time=0.010..0.020 rows=41 loops=2)
                                                                                 Buffers: shared hit=2
                                                               ->  Hash  (cost=1.33..1.33 rows=33 width=53) (actual time=0.030..0.031 rows=41 loops=2)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                     Buffers: shared hit=2
                                                                     ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.33 rows=33 width=53) (actual time=0.003..0.013 rows=41 loops=2)
                                                                           Buffers: shared hit=2
                                                         ->  Hash  (cost=320.86..320.86 rows=15786 width=4) (actual time=5.824..5.825 rows=15715 loops=2)
                                                               Buckets: 16384  Batches: 1  Memory Usage: 681kB
                                                               Buffers: shared hit=326
                                                               ->  Seq Scan on "ModSource"  (cost=0.00..320.86 rows=15786 width=4) (actual time=0.016..2.601 rows=15715 loops=2)
                                                                     Buffers: shared hit=326
                                                   ->  Hash  (cost=95.53..95.53 rows=4253 width=4) (actual time=1.372..1.373 rows=4283 loops=2)
                                                         Buckets: 8192  Batches: 1  Memory Usage: 215kB
                                                         Buffers: shared hit=106
                                                         ->  Seq Scan on "ModInstaller"  (cost=0.00..95.53 rows=4253 width=4) (actual time=0.016..0.619 rows=4283 loops=2)
                                                               Buffers: shared hit=106
                                 ->  Sort  (cost=1.81..1.81 rows=1 width=67) (actual time=0.023..0.024 rows=0 loops=1)
                                       Sort Key: "ModRating"."modId" DESC
                                       Sort Method: quicksort  Memory: 25kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=67) (actual time=0.015..0.015 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 67
                                             Buffers: shared hit=1
                           ->  Index Scan using "ModDownload_pkey" on "ModDownload"  (cost=0.41..1.01 rows=6 width=137) (actual time=0.003..0.005 rows=4 loops=15672)
                                 Index Cond: ("modId" = "Mod".id)
                                 Buffers: shared hit=65483
         SubPlan 1
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.016..0.016 rows=1 loops=11)
                 Buffers: shared hit=55
                 ->  Unique  (cost=0.43..16.51 rows=1 width=111) (actual time=0.008..0.008 rows=1 loops=11)
                       Buffers: shared hit=55
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=111) (actual time=0.005..0.005 rows=1 loops=11)
                             Buffers: shared hit=55
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.002..0.002 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Index Scan using "Source_pkey" on "Source" modsourcesource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.002..0.002 rows=1 loops=11)
                                   Index Cond: (url = "ModSource_1"."sourceUrl")
                                   Buffers: shared hit=22
         SubPlan 2
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.005..0.005 rows=1 loops=11)
                 Buffers: shared hit=28
                 ->  Unique  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.003 rows=0 loops=11)
                       Buffers: shared hit=28
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=128) (actual time=0.002..0.002 rows=0 loops=11)
                             Buffers: shared hit=28
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller" "ModInstaller_1"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.001..0.002 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=24
                             ->  Index Scan using "Source_pkey" on "Source" modinstallersource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.002..0.002 rows=1 loops=2)
                                   Index Cond: (url = "ModInstaller_1"."sourceUrl")
                                   Buffers: shared hit=4
 Planning:
   Buffers: shared hit=120
 Planning Time: 14.460 ms
 Execution Time: 606.542 ms
(118 rows)