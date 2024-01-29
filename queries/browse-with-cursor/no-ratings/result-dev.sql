 Limit  (cost=33633.45..33843.64 rows=11 width=407) (actual time=154.744..155.044 rows=11 loops=1)
   Buffers: shared hit=3420, temp read=1330 written=4321
   ->  GroupAggregate  (cost=33633.45..1272009.64 rows=64811 width=407) (actual time=154.742..155.041 rows=11 loops=1)
         Group Key: "Mod".id, category.id, categoryparent.id
         Buffers: shared hit=3420, temp read=1330 written=4321
         ->  Sort  (cost=33633.45..33795.48 rows=64811 width=631) (actual time=154.582..154.595 rows=51 loops=1)
               Sort Key: "Mod".id DESC, category.id, categoryparent.id
               Sort Method: external merge  Disk: 27808kB
               Buffers: shared hit=3346, temp read=1330 written=4321
               ->  Hash Left Join  (cost=3909.90..10288.77 rows=64811 width=631) (actual time=25.594..110.788 rows=65106 loops=1)
                     Hash Cond: ("Mod".id = "ModRating"."modId")
                     Buffers: shared hit=3346, temp read=835 written=835
                     ->  Hash Left Join  (cost=3908.05..10116.75 rows=64811 width=568) (actual time=25.580..98.416 rows=65106 loops=1)
                           Hash Cond: (category."parentId" = categoryparent.id)
                           Buffers: shared hit=3345, temp read=835 written=835
                           ->  Hash Left Join  (cost=3906.13..9927.11 rows=64811 width=472) (actual time=25.562..86.136 rows=65106 loops=1)
                                 Hash Cond: ("Mod"."categoryId" = category.id)
                                 Buffers: shared hit=3344, temp read=835 written=835
                                 ->  Hash Right Join  (cost=3904.21..9737.47 rows=64811 width=372) (actual time=25.526..71.769 rows=65106 loops=1)
                                       Hash Cond: ("ModDownload"."modId" = "Mod".id)
                                       Buffers: shared hit=3343, temp read=835 written=835
                                       ->  Seq Scan on "ModDownload"  (cost=0.00..1775.11 rows=64811 width=137) (actual time=0.017..16.501 rows=64811 loops=1)
                                             Buffers: shared hit=1127
                                       ->  Hash  (cost=3200.61..3200.61 rows=15728 width=239) (actual time=25.402..25.405 rows=15734 loops=1)
                                             Buckets: 16384  Batches: 2  Memory Usage: 2242kB
                                             Buffers: shared hit=2216, temp written=245
                                             ->  Hash Left Join  (cost=665.27..3200.61 rows=15728 width=239) (actual time=6.137..20.097 rows=15734 loops=1)
                                                   Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                                   Buffers: shared hit=2216
                                                   ->  Hash Left Join  (cost=515.81..2949.30 rows=15728 width=239) (actual time=5.347..16.107 rows=15734 loops=1)
                                                         Hash Cond: ("Mod".id = "ModSource"."modId")
                                                         Buffers: shared hit=2163
                                                         ->  Seq Scan on "Mod"  (cost=0.00..2197.60 rows=15728 width=239) (actual time=0.014..3.850 rows=15728 loops=1)
                                                               Filter: (visible AND (id <= 1000000))
                                                               Buffers: shared hit=2001
                                                         ->  Hash  (cost=319.25..319.25 rows=15725 width=4) (actual time=5.313..5.314 rows=15725 loops=1)
                                                               Buckets: 16384  Batches: 1  Memory Usage: 681kB
                                                               Buffers: shared hit=162
                                                               ->  Seq Scan on "ModSource"  (cost=0.00..319.25 rows=15725 width=4) (actual time=0.005..2.557 rows=15725 loops=1)
                                                                     Buffers: shared hit=162
                                                   ->  Hash  (cost=95.87..95.87 rows=4287 width=4) (actual time=0.772..0.772 rows=4287 loops=1)
                                                         Buckets: 8192  Batches: 1  Memory Usage: 215kB
                                                         Buffers: shared hit=53
                                                         ->  Seq Scan on "ModInstaller"  (cost=0.00..95.87 rows=4287 width=4) (actual time=0.010..0.401 rows=4287 loops=1)
                                                               Buffers: shared hit=53
                                 ->  Hash  (cost=1.41..1.41 rows=41 width=104) (actual time=0.022..0.023 rows=41 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "Category" category  (cost=0.00..1.41 rows=41 width=104) (actual time=0.007..0.013 rows=41 loops=1)
                                             Buffers: shared hit=1
                           ->  Hash  (cost=1.41..1.41 rows=41 width=100) (actual time=0.014..0.014 rows=41 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                 Buffers: shared hit=1
                                 ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.41 rows=41 width=100) (actual time=0.003..0.007 rows=41 loops=1)
                                       Buffers: shared hit=1
                     ->  Hash  (cost=1.84..1.84 rows=1 width=67) (actual time=0.008..0.009 rows=0 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 8kB
                           Buffers: shared hit=1
                           ->  Seq Scan on "ModRating"  (cost=0.00..1.84 rows=1 width=67) (actual time=0.008..0.008 rows=0 loops=1)
                                 Filter: ("userId" = ''::text)
                                 Rows Removed by Filter: 67
                                 Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.012..0.012 rows=1 loops=11)
                 Buffers: shared hit=44
                 ->  Unique  (cost=0.29..9.51 rows=1 width=111) (actual time=0.006..0.006 rows=1 loops=11)
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
 Planning Time: 3.916 ms
 Execution Time: 157.971 ms
(92 rows)