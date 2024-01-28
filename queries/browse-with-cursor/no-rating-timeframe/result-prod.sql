 Limit  (cost=11880.35..12244.52 rows=11 width=427) (actual time=186.500..186.853 rows=11 loops=1)
   Buffers: shared hit=21387 dirtied=1
   ->  Result  (cost=11880.35..738003.95 rows=21933 width=427) (actual time=186.489..186.840 rows=11 loops=1)
         Buffers: shared hit=21387 dirtied=1
         ->  Sort  (cost=11880.35..11935.19 rows=21933 width=363) (actual time=186.412..186.536 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 41kB
               Buffers: shared hit=21301 dirtied=1
               ->  GroupAggregate  (cost=4236.61..11391.31 rows=21933 width=363) (actual time=24.716..181.781 rows=4543 loops=1)
                     Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=21301 dirtied=1
                     ->  Nested Loop Left Join  (cost=4236.61..10459.16 rows=21933 width=553) (actual time=24.655..59.377 rows=18184 loops=1)
                           Buffers: shared hit=21298 dirtied=1
                           ->  Merge Left Join  (cost=4236.20..4838.37 rows=5170 width=420) (actual time=24.613..29.765 rows=4545 loops=1)
                                 Merge Cond: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=2659 dirtied=1
                                 ->  Gather Merge  (cost=4234.39..4823.62 rows=5170 width=357) (actual time=24.582..27.329 rows=4545 loops=1)
                                       Workers Planned: 1
                                       Workers Launched: 1
                                       Buffers: shared hit=2658 dirtied=1
                                       ->  Sort  (cost=3234.38..3241.98 rows=3041 width=357) (actual time=21.311..21.838 rows=2272 loops=2)
                                             Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                                             Sort Method: quicksort  Memory: 1000kB
                                             Buffers: shared hit=2658 dirtied=1
                                             Worker 0:  Sort Method: quicksort  Memory: 554kB
                                             ->  Hash Left Join  (cost=654.46..3058.45 rows=3041 width=357) (actual time=7.256..19.135 rows=2272 loops=2)
                                                   Hash Cond: ("Mod".id = "ModSource"."modId")
                                                   Buffers: shared hit=2639 dirtied=1
                                                   ->  Hash Left Join  (cost=153.03..2512.48 rows=2969 width=357) (actual time=1.761..12.484 rows=2272 loops=2)
                                                         Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                                         Buffers: shared hit=2325 dirtied=1
                                                         ->  Hash Left Join  (cost=7.13..2347.16 rows=2969 width=357) (actual time=0.198..10.004 rows=2272 loops=2)
                                                               Hash Cond: (category."parentId" = categoryparent.id)
                                                               Buffers: shared hit=2221
                                                               ->  Hash Left Join  (cost=5.39..2337.20 rows=2969 width=308) (actual time=0.160..9.391 rows=2272 loops=2)
                                                                     Hash Cond: ("Mod"."categoryId" = category.id)
                                                                     Buffers: shared hit=2219
                                                                     ->  Hash Left Join  (cost=3.65..2326.66 rows=2969 width=255) (actual time=0.111..8.492 rows=2272 loops=2)
                                                                           Hash Cond: ("Mod".id = ratingsub."modId")
                                                                           Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 14375)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                                                           Rows Removed by Filter: 5326
                                                                           Buffers: shared hit=2217
                                                                           ->  Parallel Seq Scan on "Mod"  (cost=0.00..2299.91 rows=8791 width=239) (actual time=0.006..6.245 rows=7597 loops=2)
                                                                                 Filter: visible
                                                                                 Buffers: shared hit=2212
                                                                           ->  Hash  (cost=3.06..3.06 rows=47 width=20) (actual time=0.084..0.086 rows=49 loops=2)
                                                                                 Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                                                 Buffers: shared hit=2
                                                                                 ->  Subquery Scan on ratingsub  (cost=2.12..3.06 rows=47 width=20) (actual time=0.051..0.067 rows=49 loops=2)
                                                                                       Buffers: shared hit=2
                                                                                       ->  HashAggregate  (cost=2.12..2.59 rows=47 width=20) (actual time=0.051..0.060 rows=49 loops=2)
                                                                                             Group Key: "ModRating_1"."modId"
                                                                                             Batches: 1  Memory Usage: 24kB
                                                                                             Buffers: shared hit=2
                                                                                             Worker 0:  Batches: 1  Memory Usage: 24kB
                                                                                             ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.64 rows=64 width=5) (actual time=0.016..0.021 rows=67 loops=2)
                                                                                                   Buffers: shared hit=2
                                                                     ->  Hash  (cost=1.33..1.33 rows=33 width=57) (actual time=0.031..0.034 rows=41 loops=2)
                                                                           Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                           Buffers: shared hit=2
                                                                           ->  Seq Scan on "Category" category  (cost=0.00..1.33 rows=33 width=57) (actual time=0.009..0.015 rows=41 loops=2)
                                                                                 Buffers: shared hit=2
                                                               ->  Hash  (cost=1.33..1.33 rows=33 width=53) (actual time=0.024..0.024 rows=41 loops=2)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                     Buffers: shared hit=2
                                                                     ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.33 rows=33 width=53) (actual time=0.003..0.009 rows=41 loops=2)
                                                                           Buffers: shared hit=2
                                                         ->  Hash  (cost=93.73..93.73 rows=4173 width=4) (actual time=1.505..1.506 rows=4182 loops=2)
                                                               Buckets: 8192  Batches: 1  Memory Usage: 212kB
                                                               Buffers: shared hit=104 dirtied=1
                                                               ->  Seq Scan on "ModInstaller"  (cost=0.00..93.73 rows=4173 width=4) (actual time=0.014..0.692 rows=4182 loops=2)
                                                                     Buffers: shared hit=104 dirtied=1
                                                   ->  Hash  (cost=310.08..310.08 rows=15308 width=4) (actual time=5.402..5.403 rows=15191 loops=2)
                                                         Buckets: 16384  Batches: 1  Memory Usage: 663kB
                                                         Buffers: shared hit=314
                                                         ->  Seq Scan on "ModSource"  (cost=0.00..310.08 rows=15308 width=4) (actual time=0.014..2.445 rows=15191 loops=2)
                                                               Buffers: shared hit=314
                                 ->  Sort  (cost=1.81..1.81 rows=1 width=67) (actual time=0.027..0.027 rows=0 loops=1)
                                       Sort Key: "ModRating"."modId" DESC
                                       Sort Method: quicksort  Memory: 25kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=67) (actual time=0.017..0.017 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 67
                                             Buffers: shared hit=1
                           ->  Index Scan using "ModDownload_pkey" on "ModDownload"  (cost=0.41..1.03 rows=6 width=137) (actual time=0.003..0.005 rows=4 loops=4545)
                                 Index Cond: ("modId" = "Mod".id)
                                 Buffers: shared hit=18639
         SubPlan 1
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.017..0.017 rows=1 loops=11)
                 Buffers: shared hit=55
                 ->  Unique  (cost=0.43..16.51 rows=1 width=111) (actual time=0.006..0.007 rows=1 loops=11)
                       Buffers: shared hit=55
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=111) (actual time=0.006..0.006 rows=1 loops=11)
                             Buffers: shared hit=55
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.002..0.002 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Index Scan using "Source_pkey" on "Source" modsourcesource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.002..0.002 rows=1 loops=11)
                                   Index Cond: (url = "ModSource_1"."sourceUrl")
                                   Buffers: shared hit=22
         SubPlan 2
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.007..0.007 rows=1 loops=11)
                 Buffers: shared hit=31
                 ->  Unique  (cost=0.43..16.51 rows=1 width=128) (actual time=0.004..0.004 rows=0 loops=11)
                       Buffers: shared hit=31
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.003 rows=0 loops=11)
                             Buffers: shared hit=31
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller" "ModInstaller_1"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.002..0.002 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=25
                             ->  Index Scan using "Source_pkey" on "Source" modinstallersource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.002..0.002 rows=1 loops=3)
                                   Index Cond: (url = "ModInstaller_1"."sourceUrl")
                                   Buffers: shared hit=6
 Planning:
   Buffers: shared hit=130
 Planning Time: 16.765 ms
 Execution Time: 187.352 ms
(118 rows)