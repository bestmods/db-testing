 Limit  (cost=2363.69..2573.65 rows=11 width=412) (actual time=120.651..120.767 rows=11 loops=1)
   Buffers: shared hit=1050, temp read=931 written=933
   ->  Result  (cost=2363.69..122290.45 rows=6283 width=412) (actual time=120.650..120.764 rows=11 loops=1)
         Buffers: shared hit=1050, temp read=931 written=933
         ->  Sort  (cost=2363.69..2379.40 rows=6283 width=348) (actual time=120.573..120.586 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 50kB
               Buffers: shared hit=978, temp read=931 written=933
               ->  GroupAggregate  (cost=1940.86..2223.60 rows=6283 width=348) (actual time=39.795..118.661 rows=4541 loops=1)
                     Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=978, temp read=931 written=933
                     ->  Sort  (cost=1940.86..1956.57 rows=6283 width=631) (actual time=39.642..42.137 rows=18203 loops=1)
                           Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                           Sort Method: external merge  Disk: 7448kB
                           Buffers: shared hit=978, temp read=931 written=933
                           ->  Hash Left Join  (cost=899.89..1544.49 rows=6283 width=631) (actual time=12.489..26.865 rows=18203 loops=1)
                                 Hash Cond: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=978
                                 ->  Hash Right Join  (cost=897.92..1526.02 rows=6283 width=568) (actual time=12.472..23.012 rows=18203 loops=1)
                                       Hash Cond: ("ModDownload"."modId" = "Mod".id)
                                       Buffers: shared hit=977
                                       ->  Seq Scan on "ModDownload"  (cost=0.00..497.00 rows=18200 width=136) (actual time=0.007..4.526 rows=18200 loops=1)
                                             Buffers: shared hit=315
                                       ->  Hash  (cost=877.97..877.97 rows=1596 width=436) (actual time=12.459..12.469 rows=4543 loops=1)
                                             Buckets: 8192 (originally 2048)  Batches: 1 (originally 1)  Memory Usage: 1425kB
                                             Buffers: shared hit=662
                                             ->  Hash Left Join  (cost=731.40..877.97 rows=1596 width=436) (actual time=5.548..11.014 rows=4543 loops=1)
                                                   Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                                   Buffers: shared hit=662
                                                   ->  Hash Left Join  (cost=679.06..814.52 rows=1596 width=436) (actual time=5.161..9.385 rows=4543 loops=1)
                                                         Hash Cond: (category."parentId" = categoryparent.id)
                                                         Buffers: shared hit=643
                                                         ->  Hash Left Join  (cost=677.27..808.04 rows=1596 width=340) (actual time=5.144..8.344 rows=4543 loops=1)
                                                               Hash Cond: ("Mod"."categoryId" = category.id)
                                                               Buffers: shared hit=642
                                                               ->  Hash Right Join  (cost=675.48..801.55 rows=1596 width=240) (actual time=5.123..7.092 rows=4543 loops=1)
                                                                     Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                                     Buffers: shared hit=641
                                                                     ->  Seq Scan on "ModSource"  (cost=0.00..92.96 rows=4596 width=4) (actual time=0.006..0.384 rows=4598 loops=1)
                                                                           Buffers: shared hit=47
                                                                     ->  Hash  (cost=655.53..655.53 rows=1596 width=240) (actual time=5.112..5.115 rows=4541 loops=1)
                                                                           Buckets: 8192 (originally 2048)  Batches: 1 (originally 1)  Memory Usage: 1243kB
                                                                           Buffers: shared hit=594
                                                                           ->  Hash Left Join  (cost=4.15..655.53 rows=1596 width=240) (actual time=0.095..3.508 rows=4541 loops=1)
                                                                                 Hash Cond: ("Mod".id = ratingsub."modId")
                                                                                 Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 14375)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                                                                 Rows Removed by Filter: 58
                                                                                 Buffers: shared hit=594
                                                                                 ->  Seq Scan on "Mod"  (cost=0.00..639.22 rows=4622 width=224) (actual time=0.007..1.171 rows=4599 loops=1)
                                                                                       Filter: visible
                                                                                       Buffers: shared hit=593
                                                                                 ->  Hash  (cost=3.45..3.45 rows=56 width=20) (actual time=0.083..0.084 rows=59 loops=1)
                                                                                       Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                                                       Buffers: shared hit=1
                                                                                       ->  Subquery Scan on ratingsub  (cost=2.33..3.45 rows=56 width=20) (actual time=0.054..0.074 rows=59 loops=1)
                                                                                             Buffers: shared hit=1
                                                                                             ->  HashAggregate  (cost=2.33..2.89 rows=56 width=20) (actual time=0.053..0.065 rows=59 loops=1)
                                                                                                   Group Key: "ModRating_1"."modId"
                                                                                                   Buffers: shared hit=1
                                                                                                   ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.76 rows=76 width=5) (actual time=0.003..0.009 rows=76 loops=1)
                                                                                                         Buffers: shared hit=1
                                                               ->  Hash  (cost=1.35..1.35 rows=35 width=104) (actual time=0.017..0.018 rows=35 loops=1)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                                     Buffers: shared hit=1
                                                                     ->  Seq Scan on "Category" category  (cost=0.00..1.35 rows=35 width=104) (actual time=0.003..0.009 rows=35 loops=1)
                                                                           Buffers: shared hit=1
                                                         ->  Hash  (cost=1.35..1.35 rows=35 width=100) (actual time=0.014..0.014 rows=35 loops=1)
                                                               Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                               Buffers: shared hit=1
                                                               ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.35 rows=35 width=100) (actual time=0.002..0.007 rows=35 loops=1)
                                                                     Buffers: shared hit=1
                                                   ->  Hash  (cost=33.82..33.82 rows=1482 width=4) (actual time=0.383..0.384 rows=1485 loops=1)
                                                         Buckets: 2048  Batches: 1  Memory Usage: 69kB
                                                         Buffers: shared hit=19
                                                         ->  Seq Scan on "ModInstaller"  (cost=0.00..33.82 rows=1482 width=4) (actual time=0.004..0.191 rows=1485 loops=1)
                                                               Buffers: shared hit=19
                                 ->  Hash  (cost=1.95..1.95 rows=1 width=67) (actual time=0.013..0.014 rows=0 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.95 rows=1 width=67) (actual time=0.013..0.013 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 76
                                             Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.011..0.011 rows=1 loops=11)
                 Buffers: shared hit=44
                 ->  Unique  (cost=0.28..9.51 rows=1 width=110) (actual time=0.005..0.005 rows=1 loops=11)
                       Buffers: shared hit=44
                       ->  Nested Loop Left Join  (cost=0.28..9.50 rows=1 width=110) (actual time=0.005..0.005 rows=1 loops=11)
                             Join Filter: ("ModSource_1"."sourceUrl" = modsourcesource.url)
                             Rows Removed by Join Filter: 2
                             Buffers: shared hit=44
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.28..8.30 rows=1 width=46) (actual time=0.003..0.003 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Seq Scan on "Source" modsourcesource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.001..0.001 rows=3 loops=11)
                                   Buffers: shared hit=11
         SubPlan 2
           ->  Aggregate  (cost=9.52..9.53 rows=1 width=32) (actual time=0.004..0.004 rows=1 loops=11)
                 Buffers: shared hit=28
                 ->  Unique  (cost=0.28..9.50 rows=1 width=128) (actual time=0.002..0.002 rows=0 loops=11)
                       Buffers: shared hit=28
                       ->  Nested Loop Left Join  (cost=0.28..9.50 rows=1 width=128) (actual time=0.002..0.002 rows=0 loops=11)
                             Join Filter: ("ModInstaller_1"."sourceUrl" = modinstallersource.url)
                             Rows Removed by Join Filter: 1
                             Buffers: shared hit=28
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller" "ModInstaller_1"  (cost=0.28..8.29 rows=1 width=64) (actual time=0.001..0.001 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=25
                             ->  Seq Scan on "Source" modinstallersource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.000..0.000 rows=3 loops=3)
                                   Buffers: shared hit=3
 Planning Time: 7.359 ms
 Execution Time: 122.073 ms
(113 rows)