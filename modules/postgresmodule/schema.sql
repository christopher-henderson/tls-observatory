CREATE TABLE certificates  (
	id                         	serial primary key,
	sha1_fingerprint           	varchar NOT NULL,
	sha256_fingerprint          varchar NOT NULL,
	serial_number              	varchar NULL,
	version                    	integer NULL,
	subject                    	varchar NULL,
	issuer                     	varchar NULL,
	is_ca                      	bool NULL,
	not_valid_before           	timestamp NULL,
	not_valid_after            	timestamp NULL,
	first_seen					timestamp NULL,
	last_seen					timestamp NULL,
	x509_basicConstraints      	varchar NULL,
	x509_crlDistributionPoints 	varchar NULL,
	x509_extendedKeyUsage      	varchar NULL,
	x509_authorityKeyIdentifier	varchar NULL,
	x509_subjectKeyIdentifier  	varchar NULL,
	x509_keyUsage              	varchar NULL,
	x509_certificatePolicies   	varchar NULL,
	x509_authorityInfoAccess   	varchar NULL,
	x509_subjectAltName        	varchar NULL,
	x509_issuerAltName         	varchar NULL,
	signature_algo             	varchar NULL,
	in_openssl_root_store      	bool NULL,
	in_mozilla_root_store      	bool NULL,
	in_windows_root_store      	bool NULL,
	in_apple_root_store        	bool NULL,
	is_revoked                 	bool NULL,
	revoked_at                 	timestamp NULL,
	raw_cert					varchar NOT NULL
);

CREATE TABLE trust (
    id                          serial primary key,
    cert_id                     integer references certificates(id) NOT NULL,
    issuer_id                   integer references certificates(id) NOT NULL,
    timestamp                   timestamp NOT NULL,
	trusted_ubuntu           	bool NULL,
	trusted_mozilla           	bool NULL,
	trusted_microsoft           bool NULL,
	trusted_apple             	bool NULL,
    trusted_android             bool NULL,
    is_current                  bool NOT NULL
);

CREATE TABLE scans  (
	id                         	serial primary key,
	time_stamp	           		timestamp NOT NULL,
	target						varchar NOT NULL,
	replay 				        integer NULL,
	has_tls						bool NOT NULL,
	cert_id		              	integer references certificates(id) NOT NULL,
	is_valid                   	bool NULL,
	completion_perc				integer NULL,
	validation_error           	varchar NULL,
	conn_info                	jsonb NULL
);

CREATE TABLE analysis  (
	id                         	serial primary key,
	scan_id		              	integer references scans(id),
	worker_name	           		varchar NOT NULL,
	output						jsonb NULL
);
