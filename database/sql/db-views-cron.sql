SELECT cron.schedule ('0 0 1 * *', $$REFRESH MATERIALIZED VIEW CONCURRENTLY ZAFIRA.TOTAL_VIEW$$);
SELECT cron.schedule ('0 7 * * *', $$REFRESH MATERIALIZED VIEW CONCURRENTLY ZAFIRA.THIRTY_DAYS_VIEW$$);
SELECT cron.schedule ('0 7 * * *', $$REFRESH MATERIALIZED VIEW CONCURRENTLY ZAFIRA.TEST_CASE_HEALTH_VIEW$$);