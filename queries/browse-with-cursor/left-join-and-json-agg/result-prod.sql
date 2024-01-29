 Limit  (cost=18353.82..18353.84 rows=11 width=435) (actual time=1512.949..1512.968 rows=11 loops=1)
   Buffers: shared hit=3689, temp read=4704 written=4714
   ->  Sort  (cost=18353.82..18409.36 rows=22216 width=435) (actual time=1512.925..1512.942 rows=11 loops=1)
         Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
         Sort Method: top-N heapsort  Memory: 49kB
         Buffers: shared hit=3689, temp read=4704 written=4714
         ->  GroupAggregate  (cost=16303.34..17858.46 rows=22216 width=435) (actual time=331.101..1495.748 rows=15670 loops=1)
               Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
               Buffers: shared hit=3689, temp read=4704 written=4714
               ->  Sort  (cost=16303.34..16358.88 rows=22216 width=800) (actual time=331.025..359.929 rows=64935 loops=1)
                     Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
                     Sort Method: external merge  Disk: 37632kB
                     Buffers: shared hit=3689, temp read=4704 written=4714
                     ->  Hash Left Join  (cost=3608.66..6876.92 rows=22216 width=800) (actual time=65.285..200.696 rows=64935 loops=1)
                           Hash Cond: ("Mod".id = "ModRating"."modId")
                           Buffers: shared hit=3689
                           ->  Hash Left Join  (cost=3606.85..6816.78 rows=22216 width=737) (actual time=65.258..181.969 rows=64935 loops=1)
                                 Hash Cond: ("Mod".id = ratingsub."modId")
                                 Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                 Rows Removed by Filter: 122
                                 Buffers: shared hit=3688
                                 ->  Hash Left Join  (cost=3603.20..6645.21 rows=63928 width=721) (actual time=65.168..155.990 rows=65057 loops=1)
                                       Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                       Buffers: shared hit=3687
                                       ->  Hash Right Join  (cost=3424.90..6055.19 rows=63928 width=589) (actual time=61.355..127.829 rows=65057 loops=1)
                                             Hash Cond: ("ModDownload"."modId" = "Mod".id)
                                             Buffers: shared hit=3633
                                             ->  Seq Scan on "ModDownload"  (cost=0.00..1751.28 rows=63928 width=137) (actual time=0.029..28.649 rows=64762 loops=1)
                                                   Buffers: shared hit=1112
                                             ->  Hash  (cost=3227.30..3227.30 rows=15808 width=456) (actual time=61.298..61.305 rows=15724 loops=1)
                                                   Buckets: 16384  Batches: 1  Memory Usage: 6620kB
                                                   Buffers: shared hit=2521
                                                   ->  Hash Left Join  (cost=2732.49..3227.30 rows=15808 width=456) (actual time=19.967..50.094 rows=15724 loops=1)
                                                         Hash Cond: (category."parentId" = categoryparent.id)
                                                         Buffers: shared hit=2521
                                                         ->  Hash Left Join  (cost=2730.75..3181.80 rows=15808 width=407) (actual time=19.898..45.614 rows=15724 loops=1)
                                                               Hash Cond: ("Mod"."categoryId" = category.id)
                                                               Buffers: shared hit=2520
                                                               ->  Hash Right Join  (cost=2729.00..3133.23 rows=15808 width=354) (actual time=19.848..40.873 rows=15724 loops=1)
                                                                     Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                                     Buffers: shared hit=2519
                                                                     ->  Hash Left Join  (cost=18.32..381.10 rows=15786 width=115) (actual time=0.064..9.244 rows=15715 loops=1)
                                                                           Hash Cond: ("ModSource"."sourceUrl" = modsourcesource.url)
                                                                           Buffers: shared hit=164
                                                                           ->  Seq Scan on "ModSource"  (cost=0.00..320.86 rows=15786 width=51) (actual time=0.014..1.921 rows=15715 loops=1)
                                                                                 Buffers: shared hit=163
                                                                           ->  Hash  (cost=13.70..13.70 rows=370 width=96) (actual time=0.032..0.033 rows=9 loops=1)
                                                                                 Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                                                 Buffers: shared hit=1
                                                                                 ->  Seq Scan on "Source" modsourcesource  (cost=0.00..13.70 rows=370 width=96) (actual time=0.023..0.026 rows=9 loops=1)
                                                                                       Buffers: shared hit=1
                                                                     ->  Hash  (cost=2513.08..2513.08 rows=15808 width=239) (actual time=19.756..19.757 rows=15718 loops=1)
                                                                           Buckets: 16384  Batches: 1  Memory Usage: 4286kB
                                                                           Buffers: shared hit=2355
                                                                           ->  Seq Scan on "Mod"  (cost=0.00..2513.08 rows=15808 width=239) (actual time=0.012..12.975 rows=15718 loops=1)
                                                                                 Filter: visible
                                                                                 Buffers: shared hit=2355
                                                               ->  Hash  (cost=1.33..1.33 rows=33 width=57) (actual time=0.040..0.041 rows=41 loops=1)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                     Buffers: shared hit=1
                                                                     ->  Seq Scan on "Category" category  (cost=0.00..1.33 rows=33 width=57) (actual time=0.008..0.028 rows=41 loops=1)
                                                                           Buffers: shared hit=1
                                                         ->  Hash  (cost=1.33..1.33 rows=33 width=53) (actual time=0.034..0.034 rows=41 loops=1)
                                                               Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                               Buffers: shared hit=1
                                                               ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.33 rows=33 width=53) (actual time=0.005..0.021 rows=41 loops=1)
                                                                     Buffers: shared hit=1
                                       ->  Hash  (cost=125.14..125.14 rows=4253 width=132) (actual time=3.787..3.789 rows=4283 loops=1)
                                             Buckets: 8192  Batches: 1  Memory Usage: 688kB
                                             Buffers: shared hit=54
                                             ->  Hash Left Join  (cost=18.32..125.14 rows=4253 width=132) (actual time=0.036..2.137 rows=4283 loops=1)
                                                   Hash Cond: ("ModInstaller"."sourceUrl" = modinstallersource.url)
                                                   Buffers: shared hit=54
                                                   ->  Seq Scan on "ModInstaller"  (cost=0.00..95.53 rows=4253 width=68) (actual time=0.009..0.440 rows=4283 loops=1)
                                                         Buffers: shared hit=53
                                                   ->  Hash  (cost=13.70..13.70 rows=370 width=96) (actual time=0.015..0.016 rows=9 loops=1)
                                                         Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                         Buffers: shared hit=1
                                                         ->  Seq Scan on "Source" modinstallersource  (cost=0.00..13.70 rows=370 width=96) (actual time=0.007..0.010 rows=9 loops=1)
                                                               Buffers: shared hit=1
                                 ->  Hash  (cost=3.06..3.06 rows=47 width=20) (actual time=0.078..0.080 rows=49 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                       Buffers: shared hit=1
                                       ->  Subquery Scan on ratingsub  (cost=2.12..3.06 rows=47 width=20) (actual time=0.048..0.064 rows=49 loops=1)
                                             Buffers: shared hit=1
                                             ->  HashAggregate  (cost=2.12..2.59 rows=47 width=20) (actual time=0.047..0.056 rows=49 loops=1)
                                                   Group Key: "ModRating_1"."modId"
                                                   Batches: 1  Memory Usage: 24kB
                                                   Buffers: shared hit=1
                                                   ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.64 rows=64 width=5) (actual time=0.009..0.014 rows=67 loops=1)
                                                         Buffers: shared hit=1
                           ->  Hash  (cost=1.80..1.80 rows=1 width=67) (actual time=0.010..0.011 rows=0 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                 Buffers: shared hit=1
                                 ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=67) (actual time=0.010..0.010 rows=0 loops=1)
                                       Filter: ("userId" = ''::text)
                                       Rows Removed by Filter: 67
                                       Buffers: shared hit=1
 Planning:
   Buffers: shared hit=120
 Planning Time: 11.728 ms
 Execution Time: 1520.885 ms
(102 rows)