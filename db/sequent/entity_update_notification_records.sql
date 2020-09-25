CREATE TABLE entity_update_notification_records%SUFFIX% (
    id BIGSERIAL PRIMARY KEY,
    aggregate_id varchar(512) NOT NULL,
    status varchar(512) NOT NULL,
    version bigint NOT NULL,
    entity_name varchar(512),
    error_messages bytea,
    message_body bytea
);

CREATE INDEX aggregate_id%SUFFIX% ON entity_update_notification_records%SUFFIX% USING btree (aggregate_id);
