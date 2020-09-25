CREATE TABLE external_verified_family_match_records%SUFFIX% (
    id BIGSERIAL PRIMARY KEY,
    aggregate_id varchar(512) NOT NULL,
    entity_update_notification_record_aggregate_id varchar(512) NOT NULL,
    version bigint NOT NULL,
    status varchar(512) NOT NULL
);

CREATE INDEX eunr_aggregate_id%SUFFIX% ON external_verified_family_match_records%SUFFIX% USING btree (aggregate_id);
CREATE INDEX eunr_parent_aggregate_id%SUFFIX% ON external_verified_family_match_records%SUFFIX% USING btree (entity_update_notification_record_aggregate_id);
