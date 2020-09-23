CREATE TABLE entity_update_notification_records%SUFFIX% (
    id BIGSERIAL PRIMARY KEY,
    aggregate_id varchar(512) NOT NULL,
    message_body bytea
);

CREATE UNIQUE INDEX unique_aggregate_id%SUFFIX% ON entity_update_notification_records%SUFFIX% USING btree (aggregate_id);
