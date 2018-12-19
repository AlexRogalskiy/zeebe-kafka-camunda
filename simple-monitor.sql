CREATE TABLE IF NOT EXISTS WORKFLOW
(
  ID_ VARCHAR(255) PRIMARY KEY,
  KEY_ BIGINT,
  BPMN_PROCESS_ID_ VARCHAR(255),
  VERSION_ INT,
  RESOURCE_ TEXT,
  TIMESTAMP_ BIGINT,
  INDEX WORKFLOW_ID_INDEX (ID_),
  INDEX WORKFLOW_KEY_INDEX (KEY_)
);

CREATE TABLE IF NOT EXISTS WORKFLOW_INSTANCE
(
	ID_ VARCHAR(255) PRIMARY KEY,
	PARTITION_ID_ INT,
	KEY_ BIGINT,
  BPMN_PROCESS_ID_ VARCHAR(255),
  VERSION_ INT,
	WORKFLOW_KEY_ BIGINT,
	STATE_ VARCHAR(255),
  START_ BIGINT,
  END_ BIGINT,
  INDEX WORKFLOW_INSTANCE_ID_INDEX (ID_),
  INDEX WORKFLOW_INSTANCE_WORKFLOW_KEY_INDEX (WORKFLOW_KEY_)
);

CREATE TABLE IF NOT EXISTS ACTIVITY_INSTANCE
(
	ID_ VARCHAR(255) PRIMARY KEY,
	PARTITION_ID_ INT,
	KEY_ BIGINT,
	INTENT_ VARCHAR(255),
	WORKFLOW_INSTANCE_KEY_ BIGINT,
	ACTIVITY_ID_ VARCHAR(255),
	SCOPE_INSTANCE_KEY_ BIGINT,
	PAYLOAD_ TEXT,
	WORKFLOW_KEY_ BIGINT,
  TIMESTAMP_ BIGINT,
    INDEX ACTIVITY_INSTANCE_ID_INDEX (ID_),
    INDEX ACTIVITY_INSTANCE_WORKFLOW_INSTANCE_KEY_INDEX (WORKFLOW_INSTANCE_KEY_)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS INCIDENT
(
	ID_ VARCHAR(255) PRIMARY KEY,
	KEY_ BIGINT,
	WORKFLOW_INSTANCE_KEY_ BIGINT,
	ACTIVITY_INSTANCE_KEY_ BIGINT,
	JOB_KEY_ BIGINT,
	ERROR_TYPE_ VARCHAR(255),
	ERROR_MSG_ VARCHAR(2048),
    CREATED_ BIGINT,
    RESOLVED_ BIGINT,
  INDEX INCIDENT_ID_INDEX (ID_),
  INDEX INCIDENT_WORKFLOW_INSTANCE_KEY_INDEX (WORKFLOW_INSTANCE_KEY_)
);

CREATE TABLE IF NOT EXISTS JOB
(
	ID_ VARCHAR(255) PRIMARY KEY,
	KEY_ BIGINT,
	JOB_TYPE_ VARCHAR(255),
	WORKFLOW_INSTANCE_KEY_ BIGINT,
	ACTIVITY_INSTANCE_KEY_ BIGINT,
	STATE_ VARCHAR(255),
	RETRIES_ INT,
	WORKER_ VARCHAR(255),
	TIMESTAMP_ BIGINT,
	INDEX JOB_ID_INDEX (ID_),
	INDEX JOB_WORKFLOW_INSTANCE_KEY_INDEX (WORKFLOW_INSTANCE_KEY_)
);

CREATE TABLE IF NOT EXISTS MESSAGE
(
	ID_ VARCHAR(255) PRIMARY KEY,
	KEY_ BIGINT,
	NAME_ VARCHAR(255),
	CORRELATION_KEY_ VARCHAR(255),
	MESSAGE_ID_ VARCHAR(255),
	PAYLOAD_ TEXT,
	STATE_ VARCHAR(255),
	TIMESTAMP_ BIGINT,
	INDEX MESSAGE_SUBSCRIPTION_ID_INDEX (ID_)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS MESSAGE_SUBSCRIPTION
(
	ID_ VARCHAR(255) PRIMARY KEY,
	KEY_ BIGINT,
	WORKFLOW_INSTANCE_KEY_ BIGINT,
	ACTIVITY_INSTANCE_KEY_ BIGINT,
	MESSAGE_NAME_ VARCHAR(255),
	CORRELATION_KEY_ VARCHAR(255),
	STATE_ VARCHAR(255),
	TIMESTAMP_ BIGINT,
	INDEX MESSAGE_SUBSCRIPTION_ID_INDEX (ID_),
	INDEX MSG_SUB_WORKFLOW_INSTANCE_KEY_INDEX (WORKFLOW_INSTANCE_KEY_)
);

CREATE TABLE IF NOT EXISTS TIMER
(
	ID_ VARCHAR(255) PRIMARY KEY,
	KEY_ BIGINT,
	ACTIVITY_INSTANCE_KEY_ BIGINT,
	HANDLER_NODE_ID_ VARCHAR(255),
	DUE_DATE_ BIGINT,
	STATE_ VARCHAR(255),
	TIMESTAMP_ BIGINT,
	INDEX TIMER_ID_INDEX (ID_),
	INDEX TIMER_ACTIVITY_INSTANCE_KEY_INDEX (ACTIVITY_INSTANCE_KEY_)
);