 Limit  (cost=13672.17..13948.60 rows=11 width=372) (actual time=61.551..64.190 rows=11 loops=1)
   Buffers: shared hit=2517 read=8246
   ->  Result  (cost=13672.17..2196941.44 rows=86879 width=372) (actual time=61.549..64.184 rows=11 loops=1)
         Buffers: shared hit=2517 read=8246
         ->  Sort  (cost=13672.17..13889.37 rows=86879 width=248) (actual time=58.879..58.882 rows=11 loops=1)
               Sort Key: (random()) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 33kB
               Buffers: shared hit=2419 read=8230
               ->  Seq Scan on "Mod"  (cost=0.00..11735.02 rows=86879 width=248) (actual time=0.015..35.044 rows=86874 loops=1)
                     Filter: visible
                     Rows Removed by Filter: 8
                     Buffers: shared hit=2419 read=8230
         SubPlan 1
           ->  Aggregate  (cost=9.66..9.67 rows=1 width=32) (actual time=0.390..0.390 rows=1 loops=11)
                 Buffers: shared hit=42 read=13
                 ->  Unique  (cost=0.42..9.64 rows=1 width=111) (actual time=0.375..0.376 rows=1 loops=11)
                       Buffers: shared hit=42 read=13
                       ->  Nested Loop Left Join  (cost=0.42..9.64 rows=1 width=111) (actual time=0.374..0.375 rows=1 loops=11)
                             Join Filter: ("ModSource"."sourceUrl" = modsourcesource.url)
                             Rows Removed by Join Filter: 2
                             Buffers: shared hit=42 read=13
                             ->  Index Scan using "ModSource_pkey" on "ModSource"  (cost=0.42..8.44 rows=1 width=47) (actual time=0.369..0.369 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=31 read=13
                             ->  Seq Scan on "Source" modsourcesource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.002..0.002 rows=3 loops=11)
                                   Buffers: shared hit=11
         SubPlan 2
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.054..0.054 rows=1 loops=11)
                 Buffers: shared hit=23 read=3
                 ->  Unique  (cost=0.29..9.51 rows=1 width=128) (actual time=0.050..0.051 rows=0 loops=11)
                       Buffers: shared hit=23 read=3
                       ->  Nested Loop Left Join  (cost=0.29..9.51 rows=1 width=128) (actual time=0.050..0.050 rows=0 loops=11)
                             Join Filter: ("ModInstaller"."sourceUrl" = modinstallersource.url)
                             Rows Removed by Join Filter: 0
                             Buffers: shared hit=23 read=3
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller"  (cost=0.29..8.30 rows=1 width=64) (actual time=0.048..0.049 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=21 read=3
                             ->  Seq Scan on "Source" modinstallersource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.002..0.002 rows=3 loops=2)
                                   Buffers: shared hit=2
         SubPlan 3
           ->  Subquery Scan on subquery  (cost=0.00..3.70 rows=1 width=32) (actual time=0.018..0.022 rows=1 loops=11)
                 Buffers: shared hit=22
                 ->  Unique  (cost=0.00..3.69 rows=1 width=128) (actual time=0.013..0.016 rows=1 loops=11)
                       Buffers: shared hit=22
                       ->  Nested Loop Left Join  (cost=0.00..3.69 rows=1 width=128) (actual time=0.012..0.015 rows=1 loops=11)
                             Join Filter: ("Category".id = categoryparent.id)
                             Buffers: shared hit=22
                             ->  Seq Scan on "Category"  (cost=0.00..1.84 rows=1 width=68) (actual time=0.005..0.009 rows=1 loops=11)
                                   Filter: (id = "Mod"."categoryId")
                                   Rows Removed by Filter: 66
                                   Buffers: shared hit=11
                             ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.84 rows=1 width=64) (actual time=0.005..0.005 rows=1 loops=11)
                                   Filter: (id = "Mod"."categoryId")
                                   Rows Removed by Filter: 36
                                   Buffers: shared hit=11
         SubPlan 4
           ->  Aggregate  (cost=2.19..2.20 rows=1 width=32) (actual time=0.011..0.011 rows=1 loops=11)
                 Buffers: shared hit=11
                 ->  Seq Scan on "ModRating"  (cost=0.00..2.19 rows=1 width=1) (actual time=0.010..0.010 rows=0 loops=11)
                       Filter: (("modId" = "Mod".id) AND ("userId" = ''::text))
                       Rows Removed by Filter: 79
                       Buffers: shared hit=11
 Planning Time: 0.517 ms
 Execution Time: 64.286 ms
(65 rows)