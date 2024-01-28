 Limit  (cost=16599.01..16963.19 rows=11 width=427) (actual time=170.834..171.183 rows=11 loops=1)
   Buffers: shared hit=21637
   ->  Result  (cost=16599.01..1175092.74 rows=34993 width=427) (actual time=170.833..171.179 rows=11 loops=1)
         Buffers: shared hit=21637
         ->  Sort  (cost=16599.01..16686.50 rows=34993 width=363) (actual time=170.751..170.927 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 41kB
               Buffers: shared hit=21551
               ->  GroupAggregate  (cost=4404.15..15818.77 rows=34993 width=363) (actual time=23.628..166.567 rows=4589 loops=1)
                     Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=21551
                     ->  Nested Loop Left Join  (cost=4404.15..14331.57 rows=34993 width=553) (actual time=23.574..55.138 rows=18303 loops=1)
                           Buffers: shared hit=21551
                           ->  Merge Left Join  (cost=4403.73..5364.40 rows=8248 width=420) (actual time=23.550..28.305 rows=4595 loops=1)
                                 Merge Cond: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=2696
                                 ->  Gather Merge  (cost=4401.92..5341.95 rows=8248 width=357) (actual time=23.513..26.028 rows=4595 loops=1)
                                       Workers Planned: 1
                                       Workers Launched: 1
                                       Buffers: shared hit=2695
                                       ->  Sort  (cost=3401.91..3414.04 rows=4852 width=357) (actual time=19.968..20.461 rows=2298 loops=2)
                                             Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                                             Sort Method: quicksort  Memory: 1170kB
                                             Buffers: shared hit=2695
                                             Worker 0:  Sort Method: quicksort  Memory: 398kB
                                             ->  Hash Left Join  (cost=652.66..3104.86 rows=4852 width=357) (actual time=7.173..17.960 rows=2298 loops=2)
                                                   Hash Cond: ("Mod".id = "ModSource"."modId")
                                                   Buffers: shared hit=2647
                                                   ->  Hash Left Join  (cost=151.23..2532.37 rows=4736 width=357) (actual time=1.793..11.456 rows=2294 loops=2)
                                                         Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                                         Buffers: shared hit=2333
                                                         ->  Hash Left Join  (cost=5.34..2355.50 rows=4736 width=357) (actual time=0.163..8.986 rows=2294 loops=2)
                                                               Hash Cond: (category."parentId" = categoryparent.id)
                                                               Buffers: shared hit=2229
                                                               ->  Hash Left Join  (cost=3.60..2340.65 rows=4736 width=308) (actual time=0.128..8.424 rows=2294 loops=2)
                                                                     Hash Cond: ("Mod"."categoryId" = category.id)
                                                                     Buffers: shared hit=2227
                                                                     ->  Hash Left Join  (cost=1.85..2324.87 rows=4736 width=255) (actual time=0.071..7.560 rows=2294 loops=2)
                                                                           Hash Cond: ("Mod".id = ratingsub."modId")
                                                                           Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 14375)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                                                           Rows Removed by Filter: 5302
                                                                           Buffers: shared hit=2225
                                                                           ->  Parallel Seq Scan on "Mod"  (cost=0.00..2299.91 rows=8791 width=239) (actual time=0.012..5.477 rows=7597 loops=2)
                                                                                 Filter: visible
                                                                                 Buffers: shared hit=2212
                                                                           ->  Hash  (cost=1.84..1.84 rows=1 width=20) (actual time=0.032..0.035 rows=0 loops=2)
                                                                                 Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                                                                 Buffers: shared hit=2
                                                                                 ->  Subquery Scan on ratingsub  (cost=1.81..1.84 rows=1 width=20) (actual time=0.032..0.034 rows=0 loops=2)
                                                                                       Buffers: shared hit=2
                                                                                       ->  GroupAggregate  (cost=1.81..1.83 rows=1 width=20) (actual time=0.031..0.033 rows=0 loops=2)
                                                                                             Group Key: "ModRating_1"."modId"
                                                                                             Buffers: shared hit=2
                                                                                             ->  Sort  (cost=1.81..1.81 rows=1 width=5) (actual time=0.031..0.032 rows=0 loops=2)
                                                                                                   Sort Key: "ModRating_1"."modId"
                                                                                                   Sort Method: quicksort  Memory: 25kB
                                                                                                   Buffers: shared hit=2
                                                                                                   Worker 0:  Sort Method: quicksort  Memory: 25kB
                                                                                                   ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.80 rows=1 width=5) (actual time=0.021..0.022 rows=0 loops=2)
                                                                                                         Filter: ("createdAt" > '2024-01-28 11:47:48.889'::timestamp without time zone)
                                                                                                         Rows Removed by Filter: 67
                                                                                                         Buffers: shared hit=2
                                                                     ->  Hash  (cost=1.33..1.33 rows=33 width=57) (actual time=0.043..0.043 rows=41 loops=2)
                                                                           Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                           Buffers: shared hit=2
                                                                           ->  Seq Scan on "Category" category  (cost=0.00..1.33 rows=33 width=57) (actual time=0.010..0.021 rows=41 loops=2)
                                                                                 Buffers: shared hit=2
                                                               ->  Hash  (cost=1.33..1.33 rows=33 width=53) (actual time=0.023..0.023 rows=41 loops=2)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                     Buffers: shared hit=2
                                                                     ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.33 rows=33 width=53) (actual time=0.003..0.010 rows=41 loops=2)
                                                                           Buffers: shared hit=2
                                                         ->  Hash  (cost=93.73..93.73 rows=4173 width=4) (actual time=1.596..1.597 rows=4182 loops=2)
                                                               Buckets: 8192  Batches: 1  Memory Usage: 212kB
                                                               Buffers: shared hit=104
                                                               ->  Seq Scan on "ModInstaller"  (cost=0.00..93.73 rows=4173 width=4) (actual time=0.015..0.760 rows=4182 loops=2)
                                                                     Buffers: shared hit=104
                                                   ->  Hash  (cost=310.08..310.08 rows=15308 width=4) (actual time=5.284..5.284 rows=15191 loops=2)
                                                         Buckets: 16384  Batches: 1  Memory Usage: 663kB
                                                         Buffers: shared hit=314
                                                         ->  Seq Scan on "ModSource"  (cost=0.00..310.08 rows=15308 width=4) (actual time=0.024..2.544 rows=15191 loops=2)
                                                               Buffers: shared hit=314
                                 ->  Sort  (cost=1.81..1.81 rows=1 width=67) (actual time=0.033..0.034 rows=0 loops=1)
                                       Sort Key: "ModRating"."modId" DESC
                                       Sort Method: quicksort  Memory: 25kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=67) (actual time=0.017..0.017 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 67
                                             Buffers: shared hit=1
                           ->  Index Scan using "ModDownload_pkey" on "ModDownload"  (cost=0.41..1.03 rows=6 width=137) (actual time=0.003..0.005 rows=4 loops=4595)
                                 Index Cond: ("modId" = "Mod".id)
                                 Buffers: shared hit=18855
         SubPlan 1
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.014..0.015 rows=1 loops=11)
                 Buffers: shared hit=55
                 ->  Unique  (cost=0.43..16.51 rows=1 width=111) (actual time=0.006..0.007 rows=1 loops=11)
                       Buffers: shared hit=55
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=111) (actual time=0.006..0.006 rows=1 loops=11)
                             Buffers: shared hit=55
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.002..0.002 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Index Scan using "Source_pkey" on "Source" modsourcesource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.003..0.003 rows=1 loops=11)
                                   Index Cond: (url = "ModSource_1"."sourceUrl")
                                   Buffers: shared hit=22
         SubPlan 2
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.006..0.006 rows=1 loops=11)
                 Buffers: shared hit=31
                 ->  Unique  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.003 rows=0 loops=11)
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
   Buffers: shared hit=114
 Planning Time: 14.613 ms
 Execution Time: 171.414 ms
(123 rows)
