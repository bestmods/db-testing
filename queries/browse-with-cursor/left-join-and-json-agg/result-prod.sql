 Limit  (cost=18012.53..18012.55 rows=11 width=435) (actual time=553.737..553.762 rows=11 loops=1)
   Buffers: shared hit=3522 dirtied=6, temp read=1300 written=1302
   ->  Sort  (cost=18012.53..18067.36 rows=21933 width=435) (actual time=553.735..553.757 rows=11 loops=1)
         Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
         Sort Method: top-N heapsort  Memory: 46kB
         Buffers: shared hit=3522 dirtied=6, temp read=1300 written=1302
         ->  GroupAggregate  (cost=15988.17..17523.48 rows=21933 width=435) (actual time=231.247..549.132 rows=4543 loops=1)
               Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
               Buffers: shared hit=3522 dirtied=6, temp read=1300 written=1302
               ->  Sort  (cost=15988.17..16043.01 rows=21933 width=800) (actual time=231.083..238.614 rows=18184 loops=1)
                     Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count, "ModSource"."modId", "ModInstaller"."modId"
                     Sort Method: external merge  Disk: 10400kB
                     Buffers: shared hit=3514 dirtied=6, temp read=1300 written=1302
                     ->  Hash Left Join  (cost=3420.81..6682.21 rows=21933 width=800) (actual time=74.444..192.850 rows=18184 loops=1)
                           Hash Cond: ("Mod".id = "ModRating"."modId")
                           Buffers: shared hit=3514 dirtied=6
                           ->  Hash Left Join  (cost=3419.00..6622.82 rows=21933 width=737) (actual time=74.420..187.568 rows=18184 loops=1)
                                 Hash Cond: ("Mod".id = ratingsub."modId")
                                 Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 14375)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                 Rows Removed by Filter: 44985
                                 Buffers: shared hit=3513 dirtied=6
                                 ->  Hash Left Join  (cost=3415.35..6448.57 rows=64947 width=721) (actual time=74.288..167.116 rows=63169 loops=1)
                                       Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                       Buffers: shared hit=3512 dirtied=6
                                       ->  Hash Right Join  (cost=3240.06..5848.37 rows=64947 width=589) (actual time=70.556..139.067 rows=63169 loops=1)
                                             Hash Cond: ("ModDownload"."modId" = "Mod".id)
                                             Buffers: shared hit=3459 dirtied=6
                                             ->  Seq Scan on "ModDownload"  (cost=0.00..1721.07 rows=63407 width=137) (actual time=0.016..30.656 rows=62875 loops=1)
                                                   Buffers: shared hit=1087 dirtied=6
                                             ->  Hash  (cost=3048.71..3048.71 rows=15308 width=456) (actual time=70.514..70.523 rows=15200 loops=1)
                                                   Buckets: 16384  Batches: 1  Memory Usage: 6399kB
                                                   Buffers: shared hit=2372
                                                   ->  Hash Left Join  (cost=2570.07..3048.71 rows=15308 width=456) (actual time=17.583..52.415 rows=15200 loops=1)
                                                         Hash Cond: ("ModSource"."sourceUrl" = modsourcesource.url)
                                                         Buffers: shared hit=2372
                                                         ->  Hash Left Join  (cost=2551.75..2989.74 rows=15308 width=392) (actual time=17.532..44.552 rows=15200 loops=1)
                                                               Hash Cond: (category."parentId" = categoryparent.id)
                                                               Buffers: shared hit=2371
                                                               ->  Hash Left Join  (cost=2550.00..2945.63 rows=15308 width=343) (actual time=17.493..40.063 rows=15200 loops=1)
                                                                     Hash Cond: ("Mod"."categoryId" = category.id)
                                                                     Buffers: shared hit=2370
                                                                     ->  Hash Right Join  (cost=2548.26..2898.54 rows=15308 width=290) (actual time=17.449..33.536 rows=15200 loops=1)
                                                                           Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                                           Buffers: shared hit=2369
                                                                           ->  Seq Scan on "ModSource"  (cost=0.00..310.08 rows=15308 width=51) (actual time=0.010..2.359 rows=15191 loops=1)
                                                                                 Buffers: shared hit=157
                                                                           ->  Hash  (cost=2361.45..2361.45 rows=14945 width=239) (actual time=17.412..17.413 rows=15194 loops=1)
                                                                                 Buckets: 16384  Batches: 1  Memory Usage: 4147kB
                                                                                 Buffers: shared hit=2212
                                                                                 ->  Seq Scan on "Mod"  (cost=0.00..2361.45 rows=14945 width=239) (actual time=0.009..10.089 rows=15194 loops=1)
                                                                                       Filter: visible
                                                                                       Buffers: shared hit=2212
                                                                     ->  Hash  (cost=1.33..1.33 rows=33 width=57) (actual time=0.028..0.030 rows=41 loops=1)
                                                                           Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                           Buffers: shared hit=1
                                                                           ->  Seq Scan on "Category" category  (cost=0.00..1.33 rows=33 width=57) (actual time=0.007..0.013 rows=41 loops=1)
                                                                                 Buffers: shared hit=1
                                                               ->  Hash  (cost=1.33..1.33 rows=33 width=53) (actual time=0.023..0.024 rows=41 loops=1)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                                     Buffers: shared hit=1
                                                                     ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.33 rows=33 width=53) (actual time=0.003..0.009 rows=41 loops=1)
                                                                           Buffers: shared hit=1
                                                         ->  Hash  (cost=13.70..13.70 rows=370 width=96) (actual time=0.013..0.014 rows=9 loops=1)
                                                               Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                               Buffers: shared hit=1
                                                               ->  Seq Scan on "Source" modsourcesource  (cost=0.00..13.70 rows=370 width=96) (actual time=0.006..0.007 rows=9 loops=1)
                                                                     Buffers: shared hit=1
                                       ->  Hash  (cost=123.13..123.13 rows=4173 width=132) (actual time=3.680..3.683 rows=4182 loops=1)
                                             Buckets: 8192  Batches: 1  Memory Usage: 673kB
                                             Buffers: shared hit=53
                                             ->  Hash Left Join  (cost=18.32..123.13 rows=4173 width=132) (actual time=0.036..2.021 rows=4182 loops=1)
                                                   Hash Cond: ("ModInstaller"."sourceUrl" = modinstallersource.url)
                                                   Buffers: shared hit=53
                                                   ->  Seq Scan on "ModInstaller"  (cost=0.00..93.73 rows=4173 width=68) (actual time=0.006..0.417 rows=4182 loops=1)
                                                         Buffers: shared hit=52
                                                   ->  Hash  (cost=13.70..13.70 rows=370 width=96) (actual time=0.015..0.016 rows=9 loops=1)
                                                         Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                         Buffers: shared hit=1
                                                         ->  Seq Scan on "Source" modinstallersource  (cost=0.00..13.70 rows=370 width=96) (actual time=0.005..0.007 rows=9 loops=1)
                                                               Buffers: shared hit=1
                                 ->  Hash  (cost=3.06..3.06 rows=47 width=20) (actual time=0.116..0.118 rows=49 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                       Buffers: shared hit=1
                                       ->  Subquery Scan on ratingsub  (cost=2.12..3.06 rows=47 width=20) (actual time=0.070..0.096 rows=49 loops=1)
                                             Buffers: shared hit=1
                                             ->  HashAggregate  (cost=2.12..2.59 rows=47 width=20) (actual time=0.067..0.082 rows=49 loops=1)
                                                   Group Key: "ModRating_1"."modId"
                                                   Batches: 1  Memory Usage: 24kB
                                                   Buffers: shared hit=1
                                                   ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.64 rows=64 width=5) (actual time=0.006..0.012 rows=67 loops=1)
                                                         Buffers: shared hit=1
                           ->  Hash  (cost=1.80..1.80 rows=1 width=67) (actual time=0.011..0.012 rows=0 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                 Buffers: shared hit=1
                                 ->  Seq Scan on "ModRating"  (cost=0.00..1.80 rows=1 width=67) (actual time=0.011..0.011 rows=0 loops=1)
                                       Filter: ("userId" = ''::text)
                                       Rows Removed by Filter: 67
                                       Buffers: shared hit=1
 Planning:
   Buffers: shared hit=112
 Planning Time: 12.290 ms
 Execution Time: 557.090 ms
(102 rows)