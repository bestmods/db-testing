 Limit  (cost=3619.44..3829.48 rows=11 width=395) (actual time=103.617..103.740 rows=11 loops=1)
   Buffers: shared hit=2294
   ->  Result  (cost=3619.44..107820.85 rows=5457 width=395) (actual time=103.616..103.737 rows=11 loops=1)
         Buffers: shared hit=2294
         ->  Sort  (cost=3619.44..3633.08 rows=5457 width=331) (actual time=103.542..103.552 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 31kB
               Buffers: shared hit=2220
               ->  GroupAggregate  (cost=3279.48..3497.76 rows=5457 width=331) (actual time=46.131..98.279 rows=15680 loops=1)
                     Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=2220
                     ->  Sort  (cost=3279.48..3293.13 rows=5457 width=514) (actual time=46.101..48.518 rows=15682 loops=1)
                           Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                           Sort Method: quicksort  Memory: 7494kB
                           Buffers: shared hit=2220
                           ->  Hash Left Join  (cost=2426.72..2940.77 rows=5457 width=514) (actual time=18.935..40.363 rows=15682 loops=1)
                                 Hash Cond: ("Mod".id = "ModRating"."modId")
                                 Buffers: shared hit=2220
                                 ->  Hash Left Join  (cost=2424.87..2924.60 rows=5457 width=451) (actual time=18.922..36.943 rows=15682 loops=1)
                                       Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                       Buffers: shared hit=2219
                                       ->  Hash Left Join  (cost=2275.42..2739.80 rows=5457 width=451) (actual time=18.141..32.271 rows=15682 loops=1)
                                             Hash Cond: (category."parentId" = categoryparent.id)
                                             Buffers: shared hit=2166
                                             ->  Hash Left Join  (cost=2273.49..2722.08 rows=5457 width=355) (actual time=18.125..29.305 rows=15682 loops=1)
                                                   Hash Cond: ("Mod"."categoryId" = category.id)
                                                   Buffers: shared hit=2165
                                                   ->  Hash Right Join  (cost=2271.57..2704.35 rows=5457 width=255) (actual time=18.098..25.590 rows=15682 loops=1)
                                                         Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                         Buffers: shared hit=2164
                                                         ->  Seq Scan on "ModSource"  (cost=0.00..319.25 rows=15725 width=4) (actual time=0.009..1.190 rows=15725 loops=1)
                                                               Buffers: shared hit=162
                                                         ->  Hash  (cost=2203.36..2203.36 rows=5457 width=255) (actual time=18.078..18.081 rows=15680 loops=1)
                                                               Buckets: 16384 (originally 8192)  Batches: 1 (originally 1)  Memory Usage: 4375kB
                                                               Buffers: shared hit=2002
                                                               ->  Hash Left Join  (cost=3.76..2203.36 rows=5457 width=255) (actual time=0.069..11.528 rows=15680 loops=1)
                                                                     Hash Cond: ("Mod".id = ratingsub."modId")
                                                                     Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 1000000)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                                                     Rows Removed by Filter: 48
                                                                     Buffers: shared hit=2002
                                                                     ->  Seq Scan on "Mod"  (cost=0.00..2158.28 rows=15728 width=239) (actual time=0.007..4.095 rows=15728 loops=1)
                                                                           Filter: visible
                                                                           Buffers: shared hit=2001
                                                                     ->  Hash  (cost=3.15..3.15 rows=49 width=20) (actual time=0.055..0.057 rows=49 loops=1)
                                                                           Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                                           Buffers: shared hit=1
                                                                           ->  Subquery Scan on ratingsub  (cost=2.17..3.15 rows=49 width=20) (actual time=0.032..0.048 rows=49 loops=1)
                                                                                 Buffers: shared hit=1
                                                                                 ->  HashAggregate  (cost=2.17..2.66 rows=49 width=20) (actual time=0.032..0.041 rows=49 loops=1)
                                                                                       Group Key: "ModRating_1"."modId"
                                                                                       Buffers: shared hit=1
                                                                                       ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.67 rows=67 width=5) (actual time=0.002..0.007 rows=67 loops=1)
                                                                                             Buffers: shared hit=1
                                                   ->  Hash  (cost=1.41..1.41 rows=41 width=104) (actual time=0.015..0.016 rows=41 loops=1)
                                                         Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                         Buffers: shared hit=1
                                                         ->  Seq Scan on "Category" category  (cost=0.00..1.41 rows=41 width=104) (actual time=0.004..0.009 rows=41 loops=1)
                                                               Buffers: shared hit=1
                                             ->  Hash  (cost=1.41..1.41 rows=41 width=100) (actual time=0.011..0.012 rows=41 loops=1)
                                                   Buckets: 1024  Batches: 1  Memory Usage: 12kB
                                                   Buffers: shared hit=1
                                                   ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.41 rows=41 width=100) (actual time=0.002..0.006 rows=41 loops=1)
                                                         Buffers: shared hit=1
                                       ->  Hash  (cost=95.87..95.87 rows=4287 width=4) (actual time=0.774..0.775 rows=4287 loops=1)
                                             Buckets: 8192  Batches: 1  Memory Usage: 215kB
                                             Buffers: shared hit=53
                                             ->  Seq Scan on "ModInstaller"  (cost=0.00..95.87 rows=4287 width=4) (actual time=0.003..0.391 rows=4287 loops=1)
                                                   Buffers: shared hit=53
                                 ->  Hash  (cost=1.84..1.84 rows=1 width=67) (actual time=0.009..0.009 rows=0 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                       Buffers: shared hit=1
                                       ->  Seq Scan on "ModRating"  (cost=0.00..1.84 rows=1 width=67) (actual time=0.008..0.008 rows=0 loops=1)
                                             Filter: ("userId" = ''::text)
                                             Rows Removed by Filter: 67
                                             Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.011..0.011 rows=1 loops=11)
                 Buffers: shared hit=44
                 ->  Unique  (cost=0.29..9.51 rows=1 width=111) (actual time=0.005..0.005 rows=1 loops=11)
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
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.004..0.005 rows=1 loops=11)
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
 Planning Time: 2.920 ms
 Execution Time: 103.906 ms
(105 rows)