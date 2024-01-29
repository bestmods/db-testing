 Limit  (cost=23599.80..23963.97 rows=11 width=427) (actual time=665.122..665.528 rows=11 loops=1)
   Buffers: shared hit=4048, temp read=1197 written=1200
   ->  Result  (cost=23599.80..2140028.43 rows=63928 width=427) (actual time=665.121..665.524 rows=11 loops=1)
         Buffers: shared hit=4048, temp read=1197 written=1200
         ->  Sort  (cost=23599.80..23759.62 rows=63928 width=363) (actual time=664.993..665.107 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 45kB
               Buffers: shared hit=3965, temp read=1197 written=1200
               ->  GroupAggregate  (cost=16458.00..22174.39 rows=63928 width=363) (actual time=97.447..650.086 rows=15718 loops=1)
                     Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=3965, temp read=1197 written=1200
                     ->  Merge Left Join  (cost=16458.00..19457.45 rows=63928 width=553) (actual time=97.396..172.974 rows=65057 loops=1)
                           Merge Cond: ("Mod".id = "ModDownload"."modId")
                           Buffers: shared hit=3965, temp read=1197 written=1200
                           ->  Merge Left Join  (cost=5011.94..6853.12 rows=15808 width=420) (actual time=39.679..61.113 rows=15724 loops=1)
                                 Merge Cond: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=2853
                                 ->  Gather Merge  (cost=5010.13..6811.78 rows=15808 width=357) (actual time=39.650..53.293 rows=15724 loops=1)
                                       Workers Planned: 1
                                       Workers Launched: 1
                                       Buffers: shared hit=2852
                                       ->  Sort  (cost=4010.12..4033.37 rows=9299 width=357) (actual time=35.908..37.620 rows=7862 loops=2)
                                             Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                                             Sort Method: quicksort  Memory: 3231kB
                                             Buffers: shared hit=2852
                                             Worker 0:  Sort Method: quicksort  Memory: 2422kB
                                             ->  Hash Left Join  (cost=672.22..3397.18 rows=9299 width=357) (actual time=8.272..29.004 rows=7862 loops=2)
                                                   Hash Cond: ("Mod".id = ratingsub."modId")
                                                   Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                                   Buffers: shared hit=2804
                                                   ->  Hash Left Join  (cost=670.36..3370.89 rows=9299 width=341) (actual time=8.222..26.066 rows=7862 loops=2)
                                                         Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                                         Buffers: shared hit=2802
                                                         ->  Hash Left Join  (cost=521.67..3162.31 rows=9299 width=341) (actual time=6.589..21.626 rows=7862 loops=2)
                                                               Hash Cond: ("Mod".id = "ModSource"."modId")
                                                               Buffers: shared hit=2696
                                                               ->  Hash Left Join  (cost=3.49..2504.77 rows=9299 width=341) (actual time=0.122..10.914 rows=7859 loops=2)
                                                                     Hash Cond: (category."parentId" = categoryparent.id)
                                                                     Buffers: shared hit=2370
                                                                     ->  Hash Left Join  (cost=1.74..2477.28 rows=9299 width=292) (actual time=0.089..9.106 rows=7859 loops=2)
                                                                           Hash Cond: ("Mod"."categoryId" = category.id)
                                                                           Buffers: shared hit=2368
                                                                           ->  Parallel Seq Scan on "Mod"  (cost=0.00..2447.99 rows=9299 width=239) (actual time=0.007..6.361 rows=7859 loops=2)
                                                                                 Filter: visible
                                                                                 Buffers: shared hit=2355
                                                                           ->  Hash  (cost=1.33..1.33 rows=33 width=57) (actual time=0.051..0.052 rows=41 loops=2)
                                                                                 Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                                 Buffers: shared hit=2
                                                                                 ->  Seq Scan on "Category" category  (cost=0.00..1.33 rows=33 width=57) (actual time=0.018..0.029 rows=41 loops=2)
                                                                                       Buffers: shared hit=2
                                                                     ->  Hash  (cost=1.33..1.33 rows=33 width=53) (actual time=0.023..0.023 rows=41 loops=2)
                                                                           Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                           Buffers: shared hit=2
                                                                           ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.33 rows=33 width=53) (actual time=0.004..0.010 rows=41 loops=2)
                                                                                 Buffers: shared hit=2
                                                               ->  Hash  (cost=320.86..320.86 rows=15786 width=4) (actual time=6.406..6.407 rows=15715 loops=2)
                                                                     Buckets: 16384  Batches: 1  Memory Usage: 681kB
                                                                     Buffers: shared hit=326
                                                                     ->  Seq Scan on "ModSource"  (cost=0.00..320.86 rows=15786 width=4) (actual time=0.014..3.497 rows=15715 loops=2)
                                                                           Buffers: shared hit=326
                                                         ->  Hash  (cost=95.53..95.53 rows=4253 width=4) (actual time=1.595..1.596 rows=4283 loops=2)
                                                               Buckets: 8192  Batches: 1  Memory Usage: 215kB
                                                               Buffers: shared hit=106
                                                               ->  Seq Scan on "ModInstaller"  (cost=0.00..95.53 rows=4253 width=4) (actual time=0.033..0.767 rows=4283 loops=2)
                                                                     Buffers: shared hit=106
                                                   ->  Hash  (cost=1.84..1.84 rows=1 width=20) (actual time=0.032..0.034 rows=0 loops=2)
                                                         Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                                         Buffers: shared hit=2
                                                         ->  Subquery Scan on ratingsub  (cost=1.81..1.84 rows=1 width=20) (actual time=0.032..0.033 rows=0 loops=2)
                                                               Buffers: shared hit=2
                                                               ->  GroupAggregate  (cost=1.81..1.83 rows=1 width=20) (actual time=0.031..0.032 rows=0 loops=2)
                                                                     Group Key: "ModRating_1"."modId"
                                                                     Buffers: shared hit=2
                                                                     ->  Sort  (cost=1.81..1.81 rows=1 width=5) (actual time=0.029..0.030 rows=0 loops=2)
                                                                           Sort Key: "ModRating_1"."modId"
                                                                           Sort Method: quicksort  Memory: 25kB
                                                                           Buffers: shared hit=2
                                                                           Worker 0:  Sort Method: quicksort  Memory: 25kB
                                                                           ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.80 rows=1 width=5) (actual time=0.019..0.019 rows=0 loops=2)
                                                                                 Filter: ("createdAt" > '2024-01-28 11:47:48.889'::timestamp without time zone)
                                                                                 Rows Removed by Filter: 67
                                                                                 Buffers: shared hit=2
                                 ->  Sort  (cost=1.81..1.81 rows=1 width=67) (actual time=0.025..0.025 rows=0 loops=1)
                                       Sort Key: "ModRating"."modId" DESC
                                       Sort Method: quicksort  Memory: 25kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=67) (actual time=0.016..0.017 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 67
                                             Buffers: shared hit=1
                           ->  Materialize  (cost=11446.06..11765.70 rows=63928 width=137) (actual time=57.712..87.541 rows=64775 loops=1)
                                 Buffers: shared hit=1112, temp read=1197 written=1200
                                 ->  Sort  (cost=11446.06..11605.88 rows=63928 width=137) (actual time=57.708..73.611 rows=64762 loops=1)
                                       Sort Key: "ModDownload"."modId" DESC
                                       Sort Method: external merge  Disk: 9576kB
                                       Buffers: shared hit=1112, temp read=1197 written=1200
                                       ->  Seq Scan on "ModDownload"  (cost=0.00..1751.28 rows=63928 width=137) (actual time=0.009..26.157 rows=64762 loops=1)
                                             Buffers: shared hit=1112
         SubPlan 1
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.026..0.026 rows=1 loops=11)
                 Buffers: shared hit=55
                 ->  Unique  (cost=0.43..16.51 rows=1 width=111) (actual time=0.014..0.015 rows=1 loops=11)
                       Buffers: shared hit=55
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=111) (actual time=0.013..0.014 rows=1 loops=11)
                             Buffers: shared hit=55
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.004..0.005 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Index Scan using "Source_pkey" on "Source" modsourcesource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.007..0.007 rows=1 loops=11)
                                   Index Cond: (url = "ModSource_1"."sourceUrl")
                                   Buffers: shared hit=22
         SubPlan 2
           ->  Aggregate  (cost=16.53..16.54 rows=1 width=32) (actual time=0.009..0.009 rows=1 loops=11)
                 Buffers: shared hit=28
                 ->  Unique  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.004 rows=0 loops=11)
                       Buffers: shared hit=28
                       ->  Nested Loop Left Join  (cost=0.43..16.51 rows=1 width=128) (actual time=0.003..0.003 rows=0 loops=11)
                             Buffers: shared hit=28
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller" "ModInstaller_1"  (cost=0.28..8.30 rows=1 width=64) (actual time=0.002..0.002 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=24
                             ->  Index Scan using "Source_pkey" on "Source" modinstallersource  (cost=0.15..8.17 rows=1 width=96) (actual time=0.002..0.002 rows=1 loops=2)
                                   Index Cond: (url = "ModInstaller_1"."sourceUrl")
                                   Buffers: shared hit=4
 Planning:
   Buffers: shared hit=122
 Planning Time: 14.977 ms
 Execution Time: 668.240 ms
(128 rows)