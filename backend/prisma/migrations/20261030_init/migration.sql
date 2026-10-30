CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "timescaledb";

CREATE TYPE "UserRole" AS ENUM ('ADMIN', 'ANALYST', 'AUDITOR');
CREATE TYPE "ThreatSeverity" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');
CREATE TYPE "ActionType" AS ENUM ('BLOCK_IP', 'CREATE_RULE', 'ISOLATE_HOST', 'REMOVE_RULE');
CREATE TYPE "ActionStatus" AS ENUM ('PENDING', 'APPLIED', 'FAILED', 'ROLLED_BACK');
CREATE TYPE "RuleSource" AS ENUM ('MANUAL', 'AI_AUTOMATIC', 'AI_PROPOSED');

CREATE TABLE "users" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "email" VARCHAR(255) NOT NULL UNIQUE,
    "password_hash" VARCHAR(255) NOT NULL,
    "full_name" VARCHAR(100),
    "role" "UserRole" NOT NULL DEFAULT 'ANALYST',
    "is_active" BOOLEAN NOT NULL DEFAULT TRUE,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "stormshield_appliances" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "name" VARCHAR(100) NOT NULL,
    "ip_address" INET NOT NULL,
    "api_port" INT NOT NULL DEFAULT 443,
    "encrypted_api_key" TEXT NOT NULL,
    "is_auto_mitigation_enabled" BOOLEAN NOT NULL DEFAULT FALSE,
    "threat_threshold_auto_block" INT NOT NULL DEFAULT 85,
    "status" VARCHAR(50) NOT NULL DEFAULT 'CONNECTED',
    "last_ping" TIMESTAMPTZ,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "raw_logs" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "timestamp" TIMESTAMPTZ NOT NULL,
    "appliance_id" UUID,
    "log_type" VARCHAR(50) NOT NULL,
    "src_ip" INET,
    "src_port" INT,
    "dst_ip" INET,
    "dst_port" INT,
    "protocol" VARCHAR(20),
    "action_taken" VARCHAR(50),
    "raw_message" TEXT NOT NULL,
    CONSTRAINT "raw_logs_appliance_id_fkey"
        FOREIGN KEY ("appliance_id") REFERENCES "stormshield_appliances"("id") ON DELETE CASCADE
);

SELECT create_hypertable('raw_logs', 'timestamp');

CREATE TABLE "threat_alerts" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "appliance_id" UUID,
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "severity" "ThreatSeverity" NOT NULL,
    "danger_score" INT,
    "attacker_ip" INET,
    "target_ip" INET,
    "raw_logs_count" INT NOT NULL DEFAULT 1,
    "ai_explanation" JSONB,
    "is_resolved" BOOLEAN NOT NULL DEFAULT FALSE,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "threat_alerts_appliance_id_fkey"
        FOREIGN KEY ("appliance_id") REFERENCES "stormshield_appliances"("id") ON DELETE SET NULL
);

CREATE TABLE "alert_logs_mapping" (
    "alert_id" UUID NOT NULL,
    "log_timestamp" TIMESTAMPTZ NOT NULL,
    CONSTRAINT "alert_logs_mapping_pkey" PRIMARY KEY ("alert_id", "log_timestamp"),
    CONSTRAINT "alert_logs_mapping_alert_id_fkey"
        FOREIGN KEY ("alert_id") REFERENCES "threat_alerts"("id") ON DELETE CASCADE
);

CREATE TABLE "firewall_rules" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "appliance_id" UUID,
    "alert_id" UUID,
    "stormshield_rule_id" VARCHAR(100),
    "action" "ActionType" NOT NULL,
    "source_ip" INET,
    "destination_ip" INET,
    "rule_source" "RuleSource" NOT NULL,
    "status" "ActionStatus" NOT NULL DEFAULT 'PENDING',
    "applied_at" TIMESTAMPTZ,
    "expires_at" TIMESTAMPTZ,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "firewall_rules_appliance_id_fkey"
        FOREIGN KEY ("appliance_id") REFERENCES "stormshield_appliances"("id") ON DELETE SET NULL,
    CONSTRAINT "firewall_rules_alert_id_fkey"
        FOREIGN KEY ("alert_id") REFERENCES "threat_alerts"("id") ON DELETE SET NULL
);

CREATE TABLE "action_audit_logs" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "rule_id" UUID,
    "executed_by_user" UUID,
    "action_type" "ActionType" NOT NULL,
    "executed_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "is_automated" BOOLEAN NOT NULL DEFAULT FALSE,
    "status_result" "ActionStatus" NOT NULL,
    "execution_details" JSONB,
    CONSTRAINT "action_audit_logs_rule_id_fkey"
        FOREIGN KEY ("rule_id") REFERENCES "firewall_rules"("id") ON DELETE SET NULL,
    CONSTRAINT "action_audit_logs_executed_by_user_fkey"
        FOREIGN KEY ("executed_by_user") REFERENCES "users"("id") ON DELETE SET NULL
);

CREATE INDEX "idx_raw_logs_src_ip_timestamp"
    ON "raw_logs" ("src_ip", "timestamp" DESC);

CREATE INDEX "idx_raw_logs_timestamp"
    ON "raw_logs" ("timestamp" DESC);

CREATE INDEX "idx_threat_alerts_danger_score"
    ON "threat_alerts" ("danger_score" DESC);

CREATE INDEX "idx_threat_alerts_created_at"
    ON "threat_alerts" ("created_at" DESC);

CREATE INDEX "idx_firewall_rules_status"
    ON "firewall_rules" ("status");
