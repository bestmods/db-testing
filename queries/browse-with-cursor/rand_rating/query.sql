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
    random() AS "rating",
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
    (
        SELECT jsonb_build_object(
            'name', "subquery"."name",
            'url', "subquery"."url",
            'icon', "subquery"."icon",
            'parent', CASE 
                WHEN "subquery"."parentId" IS NOT NULL THEN
                    jsonb_build_object(
                        'name', "subquery"."parentName",
                        'url', "subquery"."parentUrl",
                        'icon', "subquery"."parentIcon"
                    )
                ELSE
                    NULL
            END
        ) AS "Category"
        FROM (
            SELECT DISTINCT ON ("Category"."id")
                "Category"."name",
                "Category"."url",
                "Category"."icon",
                "Category"."parentId",
                "categoryparent"."name" AS "parentName",
                "categoryparent"."url" AS "parentUrl",
                "categoryparent"."icon" AS "parentIcon"
            FROM
                "Category"
            LEFT JOIN
                "Category"
                AS
                    "categoryparent"
                ON
                    "Category"."id" = "categoryparent"."id"
            WHERE
                "Category"."id" = "Mod"."categoryId"
        ) AS "subquery"
    ) AS "category",
    (
        SELECT json_agg(jsonb_build_object(
            'positive', "subquery"."positive"
        )) AS "ModRating"
        FROM (
            SELECT
                "ModRating"."positive"
            FROM
                "ModRating"
            WHERE
                    "ModRating"."modId" = "Mod"."id"
                AND
                    "ModRating"."userId" = ''
        ) AS "subquery"
    ) AS "ModRating"
FROM 
    "Mod"
WHERE "Mod"."visible" = true
GROUP BY
    "Mod"."id"
ORDER BY
    "rating" DESC, "Mod"."id" DESC
LIMIT 11;