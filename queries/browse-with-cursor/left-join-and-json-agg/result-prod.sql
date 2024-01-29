 Limit  (cost=4630.43..4630.46 rows=11 width=403) (actual time=335.918..335.933 rows=11 loops=1)
   Buffers: shared hit=2702
   ->  Sort  (cost=4630.43..4644.65 rows=5688 width=403) (actual time=335.916..335.930 rows=11 loops=1)
         Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
         Sort Method: top-N heapsort  Memory: 36kB
         Buffers: shared hit=2702
         ->  GroupAggregate  (cost=4133.89..4503.61 rows=5688 width=403) (actual time=93.177..323.777 rows=16246 loops=1)
               Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
               Buffers: shared hit=2702
               ->  Sort  (cost=4133.89..4148.11 rows=5688 width=667) (actual time=93.066..95.041 rows=16248 loops=1)
                     Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
                     Sort Method: quicksort  Memory: 7742kB
                     Buffers: shared hit=2694
                     ->  Hash Left Join  (cost=3031.20..3779.13 rows=5688 width=667) (actual time=19.889..77.124 rows=16248 loops=1)
                           Hash Cond: ("Mod".id = ratingsub."modId")
                           Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                           Rows Removed by Filter: 52
                           Buffers: shared hit=2694
                           ->  Hash Left Join  (cost=3027.55..3732.49 rows=16367 width=651) (actual time=19.794..69.942 rows=16300 loops=1)
                                 Hash Cond: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=2693
                                 ->  Hash Left Join  (cost=3025.74..3687.71 rows=16367 width=588) (actual time=19.776..64.769 rows=16300 loops=1)
                                       Hash Cond: ("ModInstaller"."sourceUrl" = modinstallersource.url)
                                       Buffers: shared hit=2692
                                       ->  Hash Left Join  (cost=3007.41..3625.93 rows=16367 width=524) (actual time=19.761..59.488 rows=16300 loops=1)
                                             Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                             Buffers: shared hit=2691
                                             ->  Hash Left Join  (cost=2853.10..3365.98 rows=16367 width=456) (actual time=17.999..51.202 rows=16300 loops=1)
                                                   Hash Cond: ("ModSource"."sourceUrl" = modsourcesource.url)
                                                   Buffers: shared hit=2636
                                                   ->  Hash Left Join  (cost=2834.77..3304.20 rows=16367 width=392) (actual time=17.979..43.672 rows=16300 loops=1)
                                                         Hash Cond: (category."parentId" = categoryparent.id)
                                                         Buffers: shared hit=2635
                                                         ->  Hash Left Join  (cost=2833.03..3257.16 rows=16367 width=343) (actual time=17.950..39.039 rows=16300 loops=1)
                                                               Hash Cond: ("Mod"."categoryId" = category.id)
                                                               Buffers: shared hit=2634
                                                               ->  Hash Right Join  (cost=2831.29..3206.93 rows=16367 width=290) (actual time=17.912..33.103 rows=16300 loops=1)
                                                                     Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                                     Buffers: shared hit=2633
                                                                     ->  Seq Scan on "ModSource"  (cost=0.00..332.67 rows=16367 width=51) (actual time=0.011..2.205 rows=16291 loops=1)
                                                                           Buffers: shared hit=169
                                                                     ->  Hash  (cost=2627.24..2627.24 rows=16324 width=239) (actual time=17.874..17.874 rows=16294 loops=1)
                                                                           Buckets: 16384  Batches: 1  Memory Usage: 4440kB
                                                                           Buffers: shared hit=2464
                                                                           ->  Seq Scan on "Mod"  (cost=0.00..2627.24 rows=16324 width=239) (actual time=0.008..10.976 rows=16294 loops=1)
                                                                                 Filter: visible
                                                                                 Buffers: shared hit=2464
                                                               ->  Hash  (cost=1.33..1.33 rows=33 width=57) (actual time=0.027..0.027 rows=41 loops=1)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                     Buffers: shared hit=1
                                                                     ->  Seq Scan on "Category" category  (cost=0.00..1.33 rows=33 width=57) (actual time=0.007..0.015 rows=41 loops=1)
                                                                           Buffers: shared hit=1
                                                         ->  Hash  (cost=1.33..1.33 rows=33 width=53) (actual time=0.024..0.024 rows=41 loops=1)
                                                               Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                               Buffers: shared hit=1
                                                               ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.33 rows=33 width=53) (actual time=0.003..0.013 rows=41 loops=1)
                                                                     Buffers: shared hit=1
                                                   ->  Hash  (cost=13.70..13.70 rows=370 width=96) (actual time=0.011..0.012 rows=9 loops=1)
                                                         Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                         Buffers: shared hit=1
                                                         ->  Seq Scan on "Source" modsourcesource  (cost=0.00..13.70 rows=370 width=96) (actual time=0.006..0.008 rows=9 loops=1)
                                                               Buffers: shared hit=1
                                             ->  Hash  (cost=99.14..99.14 rows=4414 width=68) (actual time=1.748..1.748 rows=4421 loops=1)
                                                   Buckets: 8192  Batches: 1  Memory Usage: 513kB
                                                   Buffers: shared hit=55
                                                   ->  Seq Scan on "ModInstaller"  (cost=0.00..99.14 rows=4414 width=68) (actual time=0.006..0.754 rows=4421 loops=1)
                                                         Buffers: shared hit=55
                                       ->  Hash  (cost=13.70..13.70 rows=370 width=96) (actual time=0.009..0.010 rows=9 loops=1)
                                             Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "Source" modinstallersource  (cost=0.00..13.70 rows=370 width=96) (actual time=0.003..0.006 rows=9 loops=1)
                                                   Buffers: shared hit=1
                                 ->  Hash  (cost=1.80..1.80 rows=1 width=67) (actual time=0.013..0.013 rows=0 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=67) (actual time=0.012..0.012 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 67
                                             Buffers: shared hit=1
                           ->  Hash  (cost=3.06..3.06 rows=47 width=20) (actual time=0.074..0.076 rows=49 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                 Buffers: shared hit=1
                                 ->  Subquery Scan on ratingsub  (cost=2.12..3.06 rows=47 width=20) (actual time=0.048..0.065 rows=49 loops=1)
                                       Buffers: shared hit=1
                                       ->  HashAggregate  (cost=2.12..2.59 rows=47 width=20) (actual time=0.047..0.056 rows=49 loops=1)
                                             Group Key: "ModRating_1"."modId"
                                             Batches: 1  Memory Usage: 24kB
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.64 rows=64 width=5) (actual time=0.003..0.008 rows=67 loops=1)
                                                   Buffers: shared hit=1
 Planning:
   Buffers: shared hit=84
 Planning Time: 10.419 ms
 Execution Time: 336.169 ms
(94 rows)