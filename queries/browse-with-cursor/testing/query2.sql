EXPLAIN (ANALYZE, BUFFERS) SELECT
    "Mod"."id",
    "Mod"."url",
    "Mod"."name",
    "Mod"."ownerName",
    "Mod"."banner",
    "Mod"."descriptionShort",
    "Mod"."totalDownloads",
    "Mod"."totalViews",
    "Mod"."nsfw",
    (COALESCE("ratingsub"."pos_count", 0) - COALESCE("ratingsub"."neg_count", 0)) + 1 AS "rating",
    COALESCE(json_agg(DISTINCT jsonb_build_object(
        'sourceUrl', "ModSource"."sourceUrl",
        'query', "ModSource"."query",
        'source', jsonb_build_object(
            'name', "modsourcesource"."name",
            'url', "ModSource"."sourceUrl",
            'icon', "modsourcesource"."icon"
        )
    )) FILTER (WHERE "ModSource"."modId" IS NOT NULL), '[]') AS "ModSource",
    COALESCE(json_agg(DISTINCT jsonb_build_object(
        'sourceUrl', "ModInstaller"."sourceUrl",
        'url', "ModInstaller"."url",
        'source', jsonb_build_object(
            'name', "modinstallersource"."name",
            'url', "ModInstaller"."sourceUrl",
            'icon', "modinstallersource"."icon"
        )
    )) FILTER (WHERE "ModInstaller"."modId" IS NOT NULL), '[]') AS "ModInstaller",
    json_build_object(
        'parent', 
        CASE 
            WHEN "categoryparent"."id" IS NOT NULL THEN 
                json_build_object(
                    'name', "categoryparent"."name",
                    'url', "categoryparent"."url",
                    'icon', "categoryparent"."icon"
                )
            ELSE
                NULL
        END,
        'name', "category"."name",
        'url', "category"."url",
        'icon', "category"."icon"
    ) AS "category",
    COALESCE(json_agg(DISTINCT jsonb_build_object(
        'positive', "ModRating"."positive"
    )))
FROM 
    "Mod"
LEFT JOIN 
    "Category"
    AS
        "category"
    ON
        "Mod"."categoryId" = "category"."id"
LEFT JOIN
    "Category"
    AS
        "categoryparent"
    ON
        "category"."parentId" = "categoryparent"."id"
LEFT JOIN
    "ModSource"
ON
    "Mod"."id" = "ModSource"."modId"
LEFT JOIN
    "Source" AS "modsourcesource"
ON
    "ModSource"."sourceUrl" = "modsourcesource"."url"
LEFT JOIN
    "ModInstaller"
ON 
    "Mod"."id" = "ModInstaller"."modId"
LEFT JOIN
    "Source" as "modinstallersource"
ON
    "ModInstaller"."sourceUrl" = "modinstallersource"."url"
LEFT JOIN
    "ModRating"
    ON
            "Mod"."id" = "ModRating"."modId"
        AND
            "ModRating"."userId" = ''
LEFT JOIN (
    SELECT
        "modId",
        COUNT(*) FILTER (WHERE "positive" = true) AS "pos_count",
        COUNT(*) FILTER (WHERE "positive" = false) AS "neg_count"
    FROM
        "ModRating"
    GROUP BY
        "modId"
) AS "ratingsub" ON "Mod"."id" = "ratingsub"."modId"
WHERE "Mod"."visible" = true AND 
        (
            (
                    (COALESCE("ratingsub"."pos_count", 0) - COALESCE("ratingsub"."neg_count", 0)) + 1 = 1
                AND
                    "Mod"."id" <= 1000000
            )
            OR
            (
                (COALESCE("ratingsub"."pos_count", 0) - COALESCE("ratingsub"."neg_count", 0)) + 1 < 1   
            )
        )
GROUP BY
    "Mod"."id",
    "category"."id",
    "categoryparent"."id",
    "ratingsub"."pos_count",
    "ratingsub"."neg_count",
    "ModSource"."modId",
    "ModInstaller"."modId"
ORDER BY
    "rating" DESC,"Mod"."id" DESC
LIMIT 11;