 Limit  (cost=4731.98..4732.01 rows=11 width=403) (actual time=370.073..370.088 rows=11 loops=1)
   Buffers: shared hit=2758
   ->  Sort  (cost=4731.98..4746.43 rows=5779 width=403) (actual time=370.072..370.085 rows=11 loops=1)
         Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
         Sort Method: top-N heapsort  Memory: 35kB
         Buffers: shared hit=2758
         ->  GroupAggregate  (cost=4213.05..4603.13 rows=5779 width=403) (actual time=93.504..355.768 rows=16461 loops=1)
               Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
               Buffers: shared hit=2758
               ->  Sort  (cost=4213.05..4227.49 rows=5779 width=605) (actual time=93.348..96.048 rows=16463 loops=1)
                     Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
                     Sort Method: quicksort  Memory: 8225kB
                     Buffers: shared hit=2750
                     ->  Hash Left Join  (cost=3093.84..3851.96 rows=5779 width=605) (actual time=20.954..74.450 rows=16463 loops=1)
                           Hash Cond: ("Mod".id = ratingsub."modId")
                           Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                           Rows Removed by Filter: 52
                           Buffers: shared hit=2750
                           ->  Hash Left Join  (cost=3090.19..3804.63 rows=16628 width=589) (actual time=20.867..67.601 rows=16515 loops=1)
                                 Hash Cond: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=2749
                                 ->  Hash Left Join  (cost=3088.38..3759.16 rows=16628 width=588) (actual time=20.848..62.782 rows=16515 loops=1)
                                       Hash Cond: ("ModInstaller"."sourceUrl" = modinstallersource.url)
                                       Buffers: shared hit=2748
                                       ->  Hash Left Join  (cost=3070.05..3696.69 rows=16628 width=524) (actual time=20.831..57.394 rows=16515 loops=1)
                                             Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                             Buffers: shared hit=2747
                                             ->  Hash Left Join  (cost=2912.94..3432.28 rows=16628 width=456) (actual time=18.974..49.332 rows=16515 loops=1)
                                                   Hash Cond: (category."parentId" = categoryparent.id)
                                                   Buffers: shared hit=2691
                                                   ->  Hash Left Join  (cost=2911.20..3384.50 rows=16628 width=407) (actual time=18.948..45.129 rows=16515 loops=1)
                                                         Hash Cond: ("Mod"."categoryId" = category.id)
                                                         Buffers: shared hit=2690
                                                         ->  Hash Right Join  (cost=2909.45..3333.51 rows=16628 width=354) (actual time=18.913..39.420 rows=16515 loops=1)
                                                               Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                               Buffers: shared hit=2689
                                                               ->  Hash Left Join  (cost=18.32..398.90 rows=16560 width=115) (actual time=0.051..9.796 rows=16506 loops=1)
                                                                     Hash Cond: ("ModSource"."sourceUrl" = modsourcesource.url)
                                                                     Buffers: shared hit=172
                                                                     ->  Seq Scan on "ModSource"  (cost=0.00..336.60 rows=16560 width=51) (actual time=0.016..2.210 rows=16506 loops=1)
                                                                           Buffers: shared hit=171
                                                                     ->  Hash  (cost=13.70..13.70 rows=370 width=96) (actual time=0.013..0.014 rows=9 loops=1)
                                                                           Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                                           Buffers: shared hit=1
                                                                           ->  Seq Scan on "Source" modsourcesource  (cost=0.00..13.70 rows=370 width=96) (actual time=0.007..0.009 rows=9 loops=1)
                                                                                 Buffers: shared hit=1
                                                               ->  Hash  (cost=2683.28..2683.28 rows=16628 width=239) (actual time=18.814..18.814 rows=16509 loops=1)
                                                                     Buckets: 32768  Batches: 1  Memory Usage: 4626kB
                                                                     Buffers: shared hit=2517
                                                                     ->  Seq Scan on "Mod"  (cost=0.00..2683.28 rows=16628 width=239) (actual time=0.014..11.077 rows=16509 loops=1)
                                                                           Filter: visible
                                                                           Buffers: shared hit=2517
                                                         ->  Hash  (cost=1.33..1.33 rows=33 width=57) (actual time=0.028..0.029 rows=41 loops=1)
                                                               Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                               Buffers: shared hit=1
                                                               ->  Seq Scan on "Category" category  (cost=0.00..1.33 rows=33 width=57) (actual time=0.010..0.017 rows=41 loops=1)
                                                                     Buffers: shared hit=1
                                                   ->  Hash  (cost=1.33..1.33 rows=33 width=53) (actual time=0.020..0.020 rows=41 loops=1)
                                                         Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                         Buffers: shared hit=1
                                                         ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.33 rows=33 width=53) (actual time=0.003..0.009 rows=41 loops=1)
                                                               Buffers: shared hit=1
                                             ->  Hash  (cost=100.94..100.94 rows=4494 width=68) (actual time=1.844..1.844 rows=4471 loops=1)
                                                   Buckets: 8192  Batches: 1  Memory Usage: 518kB
                                                   Buffers: shared hit=56
                                                   ->  Seq Scan on "ModInstaller"  (cost=0.00..100.94 rows=4494 width=68) (actual time=0.006..0.820 rows=4471 loops=1)
                                                         Buffers: shared hit=56
                                       ->  Hash  (cost=13.70..13.70 rows=370 width=96) (actual time=0.011..0.011 rows=9 loops=1)
                                             Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "Source" modinstallersource  (cost=0.00..13.70 rows=370 width=96) (actual time=0.005..0.007 rows=9 loops=1)
                                                   Buffers: shared hit=1
                                 ->  Hash  (cost=1.80..1.80 rows=1 width=5) (actual time=0.013..0.014 rows=0 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=5) (actual time=0.013..0.013 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 67
                                             Buffers: shared hit=1
                           ->  Hash  (cost=3.06..3.06 rows=47 width=20) (actual time=0.065..0.067 rows=49 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                 Buffers: shared hit=1
                                 ->  Subquery Scan on ratingsub  (cost=2.12..3.06 rows=47 width=20) (actual time=0.039..0.055 rows=49 loops=1)
                                       Buffers: shared hit=1
                                       ->  HashAggregate  (cost=2.12..2.59 rows=47 width=20) (actual time=0.038..0.047 rows=49 loops=1)
                                             Group Key: "ModRating_1"."modId"
                                             Batches: 1  Memory Usage: 24kB
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.64 rows=64 width=5) (actual time=0.003..0.008 rows=67 loops=1)
                                                   Buffers: shared hit=1
 Planning:
   Buffers: shared hit=84
 Planning Time: 10.094 ms
 Execution Time: 371.169 ms
(94 rows)