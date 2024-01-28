 Limit  (cost=7998.47..8208.57 rows=11 width=392) (actual time=36.870..37.139 rows=11 loops=1)
   Buffers: shared hit=1049, temp read=507 written=937
   ->  GroupAggregate  (cost=7998.47..354873.57 rows=18161 width=392) (actual time=36.868..37.136 rows=11 loops=1)
         Group Key: "Mod".id, category.id, categoryparent.id
         Buffers: shared hit=1049, temp read=507 written=937
         ->  Sort  (cost=7998.47..8043.87 rows=18161 width=615) (actual time=36.753..36.767 rows=36 loops=1)
               Sort Key: "Mod".id DESC, category.id, categoryparent.id
               Sort Method: external merge  Disk: 7480kB
               Buffers: shared hit=977, temp read=507 written=937
               ->  Hash Right Join  (cost=1000.35..1747.21 rows=18161 width=615) (actual time=13.859..24.158 rows=18301 loops=1)
                     Hash Cond: ("ModDownload"."modId" = "Mod".id)
                     Buffers: shared hit=977
                     ->  Seq Scan on "ModDownload"  (cost=0.00..497.00 rows=18200 width=136) (actual time=0.013..4.635 rows=18200 loops=1)
                           Buffers: shared hit=315
                     ->  Hash  (cost=942.70..942.70 rows=4612 width=483) (actual time=13.835..13.843 rows=4595 loops=1)
                           Buckets: 8192  Batches: 1  Memory Usage: 1439kB
                           Buffers: shared hit=662
                           ->  Hash Left Join  (cost=766.31..942.70 rows=4612 width=483) (actual time=5.401..12.282 rows=4595 loops=1)
                                 Hash Cond: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=662
                                 ->  Hash Left Join  (cost=764.35..928.62 rows=4612 width=420) (actual time=5.382..11.130 rows=4595 loops=1)
                                       Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                       Buffers: shared hit=661
                                       ->  Hash Left Join  (cost=712.00..844.19 rows=4612 width=420) (actual time=4.890..9.359 rows=4595 loops=1)
                                             Hash Cond: (category."parentId" = categoryparent.id)
                                             Buffers: shared hit=642
                                             ->  Hash Left Join  (cost=710.21..828.82 rows=4612 width=324) (actual time=4.866..8.338 rows=4595 loops=1)
                                                   Hash Cond: ("Mod"."categoryId" = category.id)
                                                   Buffers: shared hit=641
                                                   ->  Hash Right Join  (cost=708.42..813.46 rows=4612 width=224) (actual time=4.835..7.036 rows=4595 loops=1)
                                                         Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                         Buffers: shared hit=640
                                                         ->  Seq Scan on "ModSource"  (cost=0.00..92.96 rows=4596 width=4) (actual time=0.006..0.465 rows=4598 loops=1)
                                                               Buffers: shared hit=47
                                                         ->  Hash  (cost=650.77..650.77 rows=4612 width=224) (actual time=4.817..4.818 rows=4589 loops=1)
                                                               Buckets: 8192  Batches: 1  Memory Usage: 1225kB
                                                               Buffers: shared hit=593
                                                               ->  Seq Scan on "Mod"  (cost=0.00..650.77 rows=4612 width=224) (actual time=0.010..2.947 rows=4589 loops=1)
                                                                     Filter: (visible AND (id <= 14375))
                                                                     Rows Removed by Filter: 10
                                                                     Buffers: shared hit=593
                                                   ->  Hash  (cost=1.35..1.35 rows=35 width=104) (actual time=0.023..0.024 rows=35 loops=1)
                                                         Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                         Buffers: shared hit=1
                                                         ->  Seq Scan on "Category" category  (cost=0.00..1.35 rows=35 width=104) (actual time=0.005..0.012 rows=35 loops=1)
                                                               Buffers: shared hit=1
                                             ->  Hash  (cost=1.35..1.35 rows=35 width=100) (actual time=0.019..0.020 rows=35 loops=1)
                                                   Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                   Buffers: shared hit=1
                                                   ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.35 rows=35 width=100) (actual time=0.003..0.010 rows=35 loops=1)
                                                         Buffers: shared hit=1
                                       ->  Hash  (cost=33.82..33.82 rows=1482 width=4) (actual time=0.486..0.487 rows=1485 loops=1)
                                             Buckets: 2048  Batches: 1  Memory Usage: 69kB
                                             Buffers: shared hit=19
                                             ->  Seq Scan on "ModInstaller"  (cost=0.00..33.82 rows=1482 width=4) (actual time=0.004..0.243 rows=1485 loops=1)
                                                   Buffers: shared hit=19
                                 ->  Hash  (cost=1.95..1.95 rows=1 width=67) (actual time=0.015..0.015 rows=0 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.95 rows=1 width=67) (actual time=0.014..0.014 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 76
                                             Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.011..0.011 rows=1 loops=11)
                 Buffers: shared hit=44
                 ->  Unique  (cost=0.28..9.51 rows=1 width=110) (actual time=0.005..0.005 rows=1 loops=11)
                       Buffers: shared hit=44
                       ->  Nested Loop Left Join  (cost=0.28..9.50 rows=1 width=110) (actual time=0.004..0.005 rows=1 loops=11)
                             Join Filter: ("ModSource_1"."sourceUrl" = modsourcesource.url)
                             Rows Removed by Join Filter: 2
                             Buffers: shared hit=44
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.28..8.30 rows=1 width=46) (actual time=0.002..0.003 rows=1 loops=11)
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
                             ->  Seq Scan on "Source" modinstallersource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.000..0.001 rows=3 loops=3)
                                   Buffers: shared hit=3
 Planning Time: 3.824 ms
 Execution Time: 38.291 ms
(93 rows)