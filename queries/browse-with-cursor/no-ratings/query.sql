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
    0 + 1 AS "rating",
    json_agg(DISTINCT "ModDownload".*) AS "ModDownload",
    (
        SELECT json_agg(jsonb_build_object(
            'sourceUrl', "subquery"."sourceUrl",
            'query', "subquery"."query",
            'source', CASE 
                WHEN "subquery"."sourceUrl" IS NOT NULL THEN
                    jsonb_build_object(
                        'name', "subquery"."sourceName",
                        'url', "subquery"."sourceUrl",
                        'icon', "subquery"."sourceIcon"
                    )
                ELSE
                    NULL
            END
        )) AS "ModSource"
        FROM (
            SELECT DISTINCT ON ("ModSource"."sourceUrl")
                "ModSource"."sourceUrl",
                "ModSource"."query",
                "modsourcesource"."name" AS "sourceName",
                "modsourcesource"."icon" AS "sourceIcon"
            FROM "ModSource"
            LEFT JOIN
                "Source" 
                AS 
                    "modsourcesource"
                ON
                    "ModSource"."sourceUrl" = "modsourcesource"."url"
            WHERE
                "Mod"."id" = "ModSource"."modId"
        ) AS "subquery"
    ) AS "ModSource",
    (
        SELECT json_agg(jsonb_build_object(
            'sourceUrl', "subquery"."sourceUrl",
            'url', "subquery"."url",
            'source', CASE 
                WHEN "subquery"."sourceUrl" IS NOT NULL THEN
                    jsonb_build_object(
                        'name', "subquery"."sourceName",
                        'url', "subquery"."sourceUrl",
                        'icon', "subquery"."sourceIcon"
                    )
                ELSE
                    NULL
            END
        )) AS "ModInstaller"
        FROM (
            SELECT DISTINCT ON ("ModInstaller"."sourceUrl")
                "ModInstaller"."sourceUrl",
                "ModInstaller"."url",
                "modinstallersource"."name" AS "sourceName",
                "modinstallersource"."icon" AS "sourceIcon"
            FROM
                "ModInstaller"
            LEFT JOIN
                "Source"
                AS
                    "modinstallersource"
                ON
                    "ModInstaller"."sourceUrl" = "modinstallersource"."url"
            WHERE
                "Mod"."id" = "ModInstaller"."modId"
        ) AS "subquery"
    ) AS "ModInstaller",
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
    json_agg(DISTINCT "ModRating".*) AS "ModRating"
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
    "ModDownload"
ON
    "Mod"."id" = "ModDownload"."modId"
LEFT JOIN
    "ModSource"
ON
    "Mod"."id" = "ModSource"."modId"
LEFT JOIN
    "ModInstaller"
ON 
    "Mod"."id" = "ModInstaller"."modId"
LEFT JOIN
    "ModRating"
    ON
            "Mod"."id" = "ModRating"."modId"
        AND
            "ModRating"."userId" = ''
WHERE "Mod"."visible" = true AND 
        (
            (
                    0 + 1 = 1
                AND
                    "Mod"."id" <= 14375
            )
            OR
            (
                0 + 1 < 1   
            )
        )
GROUP BY
    "Mod"."id",
    "category"."id",
    "categoryparent"."id"
ORDER BY
    "rating" DESC,"Mod"."id" DESC
LIMIT 11;