CREATE TABLE entity_update_notifications%SUFFIX% (
    id BIGSERIAL PRIMARY KEY,
    aggregate_id uuid NOT NULL,
    message_body bytea
);

CREATE UNIQUE INDEX unique_aggregate_id%SUFFIX% ON entity_update_notifications%SUFFIX% USING btree (aggregate_id);
