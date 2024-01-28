 Limit  (cost=5223.99..5224.02 rows=11 width=420) (actual time=248.711..248.729 rows=11 loops=1)
   Buffers: shared hit=988, temp read=1302 written=1306
   ->  Sort  (cost=5223.99..5239.70 rows=6283 width=420) (actual time=248.709..248.726 rows=11 loops=1)
         Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
         Sort Method: top-N heapsort  Memory: 56kB
         Buffers: shared hit=988, temp read=1302 written=1306
         ->  GroupAggregate  (cost=4644.09..5083.90 rows=6283 width=420) (actual time=52.772..246.480 rows=4541 loops=1)
               Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
               Buffers: shared hit=988, temp read=1302 written=1306
               ->  Sort  (cost=4644.09..4659.79 rows=6283 width=877) (actual time=52.493..56.772 rows=18203 loops=1)
                     Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
                     Sort Method: external merge  Disk: 10416kB
                     Buffers: shared hit=980, temp read=1302 written=1306
                     ->  Hash Left Join  (cost=1007.07..1818.72 rows=6283 width=877) (actual time=11.739..34.601 rows=18203 loops=1)
                           Hash Cond: ("Mod".id = "ModRating"."modId")
                           Buffers: shared hit=980
                           ->  Hash Left Join  (cost=1005.11..1800.25 rows=6283 width=814) (actual time=11.725..29.925 rows=18203 loops=1)
                                 Hash Cond: ("Mod".id = ratingsub."modId")
                                 Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 14375)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                 Rows Removed by Filter: 148
                                 Buffers: shared hit=979
                                 ->  Hash Right Join  (cost=1000.96..1748.21 rows=18200 width=798) (actual time=11.662..24.021 rows=18351 loops=1)
                                       Hash Cond: ("ModDownload"."modId" = "Mod".id)
                                       Buffers: shared hit=978
                                       ->  Seq Scan on "ModDownload"  (cost=0.00..497.00 rows=18200 width=136) (actual time=0.011..4.671 rows=18200 loops=1)
                                             Buffers: shared hit=315
                                       ->  Hash  (cost=943.19..943.19 rows=4622 width=666) (actual time=11.641..11.652 rows=4613 loops=1)
                                             Buckets: 8192  Batches: 1  Memory Usage: 2043kB
                                             Buffers: shared hit=663
                                             ->  Hash Left Join  (cost=761.05..943.19 rows=4622 width=666) (actual time=3.564..9.932 rows=4613 loops=1)
                                                   Hash Cond: (category."parentId" = categoryparent.id)
                                                   Buffers: shared hit=663
                                                   ->  Hash Left Join  (cost=759.26..927.80 rows=4622 width=570) (actual time=3.549..8.856 rows=4613 loops=1)
                                                         Hash Cond: ("Mod"."categoryId" = category.id)
                                                         Buffers: shared hit=662
                                                         ->  Hash Left Join  (cost=757.47..912.41 rows=4622 width=470) (actual time=3.533..7.518 rows=4613 loops=1)
                                                               Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                                               Buffers: shared hit=661
                                                               ->  Hash Right Join  (cost=698.20..820.98 rows=4622 width=338) (actual time=2.874..5.772 rows=4607 loops=1)
                                                                     Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                                     Buffers: shared hit=641
                                                                     ->  Hash Left Join  (cost=1.20..111.91 rows=4596 width=114) (actual time=0.015..1.457 rows=4598 loops=1)
                                                                           Hash Cond: ("ModSource"."sourceUrl" = modsourcesource.url)
                                                                           Buffers: shared hit=48
                                                                           ->  Seq Scan on "ModSource"  (cost=0.00..92.96 rows=4596 width=50) (actual time=0.003..0.363 rows=4598 loops=1)
                                                                                 Buffers: shared hit=47
                                                                           ->  Hash  (cost=1.09..1.09 rows=9 width=96) (actual time=0.007..0.008 rows=9 loops=1)
                                                                                 Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                                                 Buffers: shared hit=1
                                                                                 ->  Seq Scan on "Source" modsourcesource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.003..0.004 rows=9 loops=1)
                                                                                       Buffers: shared hit=1
                                                                     ->  Hash  (cost=639.22..639.22 rows=4622 width=224) (actual time=2.851..2.852 rows=4599 loops=1)
                                                                           Buckets: 8192  Batches: 1  Memory Usage: 1228kB
                                                                           Buffers: shared hit=593
                                                                           ->  Seq Scan on "Mod"  (cost=0.00..639.22 rows=4622 width=224) (actual time=0.006..1.824 rows=4599 loops=1)
                                                                                 Filter: visible
                                                                                 Buffers: shared hit=593
                                                               ->  Hash  (cost=40.75..40.75 rows=1482 width=132) (actual time=0.655..0.657 rows=1485 loops=1)
                                                                     Buckets: 2048  Batches: 1  Memory Usage: 232kB
                                                                     Buffers: shared hit=20
                                                                     ->  Hash Left Join  (cost=1.20..40.75 rows=1482 width=132) (actual time=0.010..0.456 rows=1485 loops=1)
                                                                           Hash Cond: ("ModInstaller"."sourceUrl" = modinstallersource.url)
                                                                           Buffers: shared hit=20
                                                                           ->  Seq Scan on "ModInstaller"  (cost=0.00..33.82 rows=1482 width=68) (actual time=0.004..0.113 rows=1485 loops=1)
                                                                                 Buffers: shared hit=19
                                                                           ->  Hash  (cost=1.09..1.09 rows=9 width=96) (actual time=0.004..0.004 rows=9 loops=1)
                                                                                 Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                                                 Buffers: shared hit=1
                                                                                 ->  Seq Scan on "Source" modinstallersource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.001..0.002 rows=9 loops=1)
                                                                                       Buffers: shared hit=1
                                                         ->  Hash  (cost=1.35..1.35 rows=35 width=104) (actual time=0.013..0.014 rows=35 loops=1)
                                                               Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                               Buffers: shared hit=1
                                                               ->  Seq Scan on "Category" category  (cost=0.00..1.35 rows=35 width=104) (actual time=0.002..0.007 rows=35 loops=1)
                                                                     Buffers: shared hit=1
                                                   ->  Hash  (cost=1.35..1.35 rows=35 width=100) (actual time=0.012..0.012 rows=35 loops=1)
                                                         Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                         Buffers: shared hit=1
                                                         ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.35 rows=35 width=100) (actual time=0.002..0.006 rows=35 loops=1)
                                                               Buffers: shared hit=1
                                 ->  Hash  (cost=3.45..3.45 rows=56 width=20) (actual time=0.054..0.055 rows=59 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                       Buffers: shared hit=1
                                       ->  Subquery Scan on ratingsub  (cost=2.33..3.45 rows=56 width=20) (actual time=0.032..0.045 rows=59 loops=1)
                                             Buffers: shared hit=1
                                             ->  HashAggregate  (cost=2.33..2.89 rows=56 width=20) (actual time=0.031..0.039 rows=59 loops=1)
                                                   Group Key: "ModRating_1"."modId"
                                                   Buffers: shared hit=1
                                                   ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.76 rows=76 width=5) (actual time=0.004..0.008 rows=76 loops=1)
                                                         Buffers: shared hit=1
                           ->  Hash  (cost=1.95..1.95 rows=1 width=67) (actual time=0.006..0.007 rows=0 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                 Buffers: shared hit=1
                                 ->  Seq Scan on "ModRating"  (cost=0.00..1.95 rows=1 width=67) (actual time=0.006..0.006 rows=0 loops=1)
                                       Filter: ("userId" = ''::text)
                                       Rows Removed by Filter: 76
                                       Buffers: shared hit=1
 Planning Time: 3.002 ms
 Execution Time: 250.065 ms
(99 rows)