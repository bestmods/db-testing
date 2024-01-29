 Limit  (cost=38572.37..38782.41 rows=11 width=427) (actual time=477.742..477.884 rows=11 loops=1)
   Buffers: shared hit=3421, temp read=4311 written=4321
   ->  Result  (cost=38572.37..1276138.41 rows=64811 width=427) (actual time=477.740..477.881 rows=11 loops=1)
         Buffers: shared hit=3421, temp read=4311 written=4321
         ->  Sort  (cost=38572.37..38734.39 rows=64811 width=363) (actual time=477.663..477.677 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 42kB
               Buffers: shared hit=3347, temp read=4311 written=4321
               ->  GroupAggregate  (cost=34210.77..37127.26 rows=64811 width=363) (actual time=172.093..470.793 rows=15728 loops=1)
                     Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=3347, temp read=4311 written=4321
                     ->  Sort  (cost=34210.77..34372.80 rows=64811 width=647) (actual time=172.007..183.997 rows=65106 loops=1)
                           Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                           Sort Method: external merge  Disk: 27808kB
                           Buffers: shared hit=3347, temp read=4311 written=4321
                           ->  Hash Left Join  (cost=3872.48..10421.59 rows=64811 width=647) (actual time=23.002..127.799 rows=65106 loops=1)
                                 Hash Cond: ("Mod".id = ratingsub."modId")
                                 Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                 Buffers: shared hit=3347, temp read=835 written=835
                                 ->  Hash Left Join  (cost=3870.58..10249.45 rows=64811 width=631) (actual time=22.971..110.128 rows=65106 loops=1)
                                       Hash Cond: ("Mod".id = "ModRating"."modId")
                                       Buffers: shared hit=3346, temp read=835 written=835
                                       ->  Hash Left Join  (cost=3868.73..10077.43 rows=64811 width=568) (actual time=22.957..96.772 rows=65106 loops=1)
                                             Hash Cond: (category."parentId" = categoryparent.id)
                                             Buffers: shared hit=3345, temp read=835 written=835
                                             ->  Hash Left Join  (cost=3866.81..9887.79 rows=64811 width=472) (actual time=22.937..83.866 rows=65106 loops=1)
                                                   Hash Cond: ("Mod"."categoryId" = category.id)
                                                   Buffers: shared hit=3344, temp read=835 written=835
                                                   ->  Hash Right Join  (cost=3864.89..9698.15 rows=64811 width=372) (actual time=22.897..69.284 rows=65106 loops=1)
                                                         Hash Cond: ("ModDownload"."modId" = "Mod".id)
                                                         Buffers: shared hit=3343, temp read=835 written=835
                                                         ->  Seq Scan on "ModDownload"  (cost=0.00..1775.11 rows=64811 width=137) (actual time=0.012..16.428 rows=64811 loops=1)
                                                               Buffers: shared hit=1127
                                                         ->  Hash  (cost=3161.29..3161.29 rows=15728 width=239) (actual time=22.819..22.823 rows=15734 loops=1)
                                                               Buckets: 16384  Batches: 2  Memory Usage: 2242kB
                                                               Buffers: shared hit=2216, temp written=245
                                                               ->  Hash Left Join  (cost=665.27..3161.29 rows=15728 width=239) (actual time=5.177..17.848 rows=15734 loops=1)
                                                                     Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                                                     Buffers: shared hit=2216
                                                                     ->  Hash Left Join  (cost=515.81..2909.98 rows=15728 width=239) (actual time=4.413..14.205 rows=15734 loops=1)
                                                                           Hash Cond: ("Mod".id = "ModSource"."modId")
                                                                           Buffers: shared hit=2163
                                                                           ->  Seq Scan on "Mod"  (cost=0.00..2158.28 rows=15728 width=239) (actual time=0.010..3.644 rows=15728 loops=1)
                                                                                 Filter: visible
                                                                                 Buffers: shared hit=2001
                                                                           ->  Hash  (cost=319.25..319.25 rows=15725 width=4) (actual time=4.385..4.386 rows=15725 loops=1)
                                                                                 Buckets: 16384  Batches: 1  Memory Usage: 681kB
                                                                                 Buffers: shared hit=162
                                                                                 ->  Seq Scan on "ModSource"  (cost=0.00..319.25 rows=15725 width=4) (actual time=0.004..2.054 rows=15725 loops=1)
                                                                                       Buffers: shared hit=162
                                                                     ->  Hash  (cost=95.87..95.87 rows=4287 width=4) (actual time=0.756..0.757 rows=4287 loops=1)
                                                                           Buckets: 8192  Batches: 1  Memory Usage: 215kB
                                                                           Buffers: shared hit=53
                                                                           ->  Seq Scan on "ModInstaller"  (cost=0.00..95.87 rows=4287 width=4) (actual time=0.004..0.386 rows=4287 loops=1)
                                                                                 Buffers: shared hit=53
                                                   ->  Hash  (cost=1.41..1.41 rows=41 width=104) (actual time=0.018..0.018 rows=41 loops=1)
                                                         Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                         Buffers: shared hit=1
                                                         ->  Seq Scan on "Category" category  (cost=0.00..1.41 rows=41 width=104) (actual time=0.005..0.010 rows=41 loops=1)
                                                               Buffers: shared hit=1
                                             ->  Hash  (cost=1.41..1.41 rows=41 width=100) (actual time=0.013..0.014 rows=41 loops=1)
                                                   Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                   Buffers: shared hit=1
                                                   ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.41 rows=41 width=100) (actual time=0.002..0.006 rows=41 loops=1)
                                                         Buffers: shared hit=1
                                       ->  Hash  (cost=1.84..1.84 rows=1 width=67) (actual time=0.008..0.009 rows=0 loops=1)
                                             Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "ModRating"  (cost=0.00..1.84 rows=1 width=67) (actual time=0.008..0.008 rows=0 loops=1)
                                                   Filter: ("userId" = ''::text)
                                                   Rows Removed by Filter: 67
                                                   Buffers: shared hit=1
                                 ->  Hash  (cost=1.88..1.88 rows=1 width=20) (actual time=0.015..0.017 rows=0 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                       Buffers: shared hit=1
                                       ->  Subquery Scan on ratingsub  (cost=1.85..1.88 rows=1 width=20) (actual time=0.014..0.016 rows=0 loops=1)
                                             Buffers: shared hit=1
                                             ->  GroupAggregate  (cost=1.85..1.87 rows=1 width=20) (actual time=0.013..0.015 rows=0 loops=1)
                                                   Group Key: "ModRating_1"."modId"
                                                   Buffers: shared hit=1
                                                   ->  Sort  (cost=1.85..1.85 rows=1 width=5) (actual time=0.012..0.012 rows=0 loops=1)
                                                         Sort Key: "ModRating_1"."modId"
                                                         Sort Method: quicksort  Memory: 25kB
                                                         Buffers: shared hit=1
                                                         ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.84 rows=1 width=5) (actual time=0.005..0.006 rows=0 loops=1)
                                                               Filter: ("createdAt" > '2024-01-28 11:47:48.889'::timestamp without time zone)
                                                               Rows Removed by Filter: 67
                                                               Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.012..0.012 rows=1 loops=11)
                 Buffers: shared hit=44
                 ->  Unique  (cost=0.29..9.51 rows=1 width=111) (actual time=0.005..0.006 rows=1 loops=11)
                       Buffers: shared hit=44
                       ->  Nested Loop Left Join  (cost=0.29..9.51 rows=1 width=111) (actual time=0.005..0.005 rows=1 loops=11)
                             Join Filter: ("ModSource_1"."sourceUrl" = modsourcesource.url)
                             Rows Removed by Join Filter: 3
                             Buffers: shared hit=44
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.29..8.30 rows=1 width=47) (actual time=0.003..0.003 rows=1 loops=11)
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
 Planning Time: 7.918 ms
 Execution Time: 480.923 ms
(118 rows)