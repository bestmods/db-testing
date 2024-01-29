 Limit  (cost=23266.61..23266.64 rows=11 width=435) (actual time=939.978..939.998 rows=11 loops=1)
   Buffers: shared hit=3357, temp read=6154 written=6169
   ->  Sort  (cost=23266.61..23322.83 rows=22485 width=435) (actual time=939.977..939.994 rows=11 loops=1)
         Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
         Sort Method: top-N heapsort  Memory: 50kB
         Buffers: shared hit=3357, temp read=6154 written=6169
         ->  GroupAggregate  (cost=21191.31..22765.26 rows=22485 width=435) (actual time=246.635..932.021 rows=15680 loops=1)
               Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
               Buffers: shared hit=3357, temp read=6154 written=6169
               ->  Sort  (cost=21191.31..21247.52 rows=22485 width=894) (actual time=246.403..261.837 rows=64984 loops=1)
                     Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
                     Sort Method: external merge  Disk: 37704kB
                     Buffers: shared hit=3349, temp read=6154 written=6169
                     ->  Hash Left Join  (cost=3616.28..10725.02 rows=22485 width=894) (actual time=22.483..183.850 rows=64984 loops=1)
                           Hash Cond: ("Mod".id = "ModRating"."modId")
                           Buffers: shared hit=3349, temp read=835 written=835
                           ->  Hash Left Join  (cost=3614.43..10664.14 rows=22485 width=831) (actual time=22.470..166.036 rows=64984 loops=1)
                                 Hash Cond: ("Mod".id = ratingsub."modId")
                                 Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                 Rows Removed by Filter: 122
                                 Buffers: shared hit=3348, temp read=835 written=835
                                 ->  Hash Left Join  (cost=3610.66..10490.13 rows=64811 width=815) (actual time=22.406..144.768 rows=65106 loops=1)
                                       Hash Cond: (category."parentId" = categoryparent.id)
                                       Buffers: shared hit=3347, temp read=835 written=835
                                       ->  Hash Left Join  (cost=3608.74..10300.49 rows=64811 width=719) (actual time=22.384..129.043 rows=65106 loops=1)
                                             Hash Cond: ("Mod"."categoryId" = category.id)
                                             Buffers: shared hit=3346, temp read=835 written=835
                                             ->  Hash Left Join  (cost=3606.82..10110.85 rows=64811 width=619) (actual time=22.359..110.080 rows=65106 loops=1)
                                                   Hash Cond: ("Mod".id = "ModSource"."modId")
                                                   Buffers: shared hit=3345, temp read=835 written=835
                                                   ->  Hash Left Join  (cost=3029.09..8561.07 rows=64811 width=504) (actual time=15.104..81.301 rows=65093 loops=1)
                                                         Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                                         Buffers: shared hit=3182, temp read=835 written=835
                                                         ->  Hash Right Join  (cost=2861.88..7974.16 rows=64811 width=372) (actual time=13.199..62.552 rows=65093 loops=1)
                                                               Hash Cond: ("ModDownload"."modId" = "Mod".id)
                                                               Buffers: shared hit=3128, temp read=835 written=835
                                                               ->  Seq Scan on "ModDownload"  (cost=0.00..1775.11 rows=64811 width=137) (actual time=0.010..18.253 rows=64811 loops=1)
                                                                     Buffers: shared hit=1127
                                                               ->  Hash  (cost=2158.28..2158.28 rows=15728 width=239) (actual time=13.121..13.122 rows=15728 loops=1)
                                                                     Buckets: 16384  Batches: 2  Memory Usage: 2241kB
                                                                     Buffers: shared hit=2001, temp written=245
                                                                     ->  Seq Scan on "Mod"  (cost=0.00..2158.28 rows=15728 width=239) (actual time=0.010..7.165 rows=15728 loops=1)
                                                                           Filter: visible
                                                                           Buffers: shared hit=2001
                                                         ->  Hash  (cost=113.62..113.62 rows=4287 width=132) (actual time=1.894..1.896 rows=4287 loops=1)
                                                               Buckets: 8192  Batches: 1  Memory Usage: 688kB
                                                               Buffers: shared hit=54
                                                               ->  Hash Left Join  (cost=1.20..113.62 rows=4287 width=132) (actual time=0.019..1.297 rows=4287 loops=1)
                                                                     Hash Cond: ("ModInstaller"."sourceUrl" = modinstallersource.url)
                                                                     Buffers: shared hit=54
                                                                     ->  Seq Scan on "ModInstaller"  (cost=0.00..95.87 rows=4287 width=68) (actual time=0.004..0.323 rows=4287 loops=1)
                                                                           Buffers: shared hit=53
                                                                     ->  Hash  (cost=1.09..1.09 rows=9 width=96) (actual time=0.007..0.008 rows=9 loops=1)
                                                                           Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                                           Buffers: shared hit=1
                                                                           ->  Seq Scan on "Source" modinstallersource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.003..0.004 rows=9 loops=1)
                                                                                 Buffers: shared hit=1
                                                   ->  Hash  (cost=381.17..381.17 rows=15725 width=115) (actual time=7.239..7.242 rows=15725 loops=1)
                                                         Buckets: 16384  Batches: 1  Memory Usage: 2089kB
                                                         Buffers: shared hit=163
                                                         ->  Hash Left Join  (cost=1.20..381.17 rows=15725 width=115) (actual time=0.019..4.619 rows=15725 loops=1)
                                                               Hash Cond: ("ModSource"."sourceUrl" = modsourcesource.url)
                                                               Buffers: shared hit=163
                                                               ->  Seq Scan on "ModSource"  (cost=0.00..319.25 rows=15725 width=51) (actual time=0.005..1.033 rows=15725 loops=1)
                                                                     Buffers: shared hit=162
                                                               ->  Hash  (cost=1.09..1.09 rows=9 width=96) (actual time=0.005..0.005 rows=9 loops=1)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                                     Buffers: shared hit=1
                                                                     ->  Seq Scan on "Source" modsourcesource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.001..0.002 rows=9 loops=1)
                                                                           Buffers: shared hit=1
                                             ->  Hash  (cost=1.41..1.41 rows=41 width=104) (actual time=0.019..0.019 rows=41 loops=1)
                                                   Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                   Buffers: shared hit=1
                                                   ->  Seq Scan on "Category" category  (cost=0.00..1.41 rows=41 width=104) (actual time=0.005..0.010 rows=41 loops=1)
                                                         Buffers: shared hit=1
                                       ->  Hash  (cost=1.41..1.41 rows=41 width=100) (actual time=0.013..0.014 rows=41 loops=1)
                                             Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                             Buffers: shared hit=1
                                             ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.41 rows=41 width=100) (actual time=0.002..0.006 rows=41 loops=1)
                                                   Buffers: shared hit=1
                                 ->  Hash  (cost=3.15..3.15 rows=49 width=20) (actual time=0.047..0.049 rows=49 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                       Buffers: shared hit=1
                                       ->  Subquery Scan on ratingsub  (cost=2.17..3.15 rows=49 width=20) (actual time=0.031..0.042 rows=49 loops=1)
                                             Buffers: shared hit=1
                                             ->  HashAggregate  (cost=2.17..2.66 rows=49 width=20) (actual time=0.030..0.037 rows=49 loops=1)
                                                   Group Key: "ModRating_1"."modId"
                                                   Buffers: shared hit=1
                                                   ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.67 rows=67 width=5) (actual time=0.003..0.007 rows=67 loops=1)
                                                         Buffers: shared hit=1
                           ->  Hash  (cost=1.84..1.84 rows=1 width=67) (actual time=0.006..0.006 rows=0 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                 Buffers: shared hit=1
                                 ->  Seq Scan on "ModRating"  (cost=0.00..1.84 rows=1 width=67) (actual time=0.005..0.005 rows=0 loops=1)
                                       Filter: ("userId" = ''::text)
                                       Rows Removed by Filter: 67
                                       Buffers: shared hit=1
 Planning Time: 4.957 ms
 Execution Time: 944.329 ms
(99 rows)