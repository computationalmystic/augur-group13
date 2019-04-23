ALTER TABLE "annotations" DROP CONSTRAINT "annotations_document_id_fkey";
ALTER TABLE "annotations" DROP CONSTRAINT "annotations_annotation_type_id_fkey";
ALTER TABLE "annotations" DROP CONSTRAINT "annotations_identifier_id_fkey";
ALTER TABLE "annotations" DROP CONSTRAINT "annotations_creator_id_fkey";
ALTER TABLE "creators" DROP CONSTRAINT "creators_creator_type_id_fkey";
ALTER TABLE "documents" DROP CONSTRAINT "documents_document_namespace_id_fkey";
ALTER TABLE "documents" DROP CONSTRAINT "documents_data_license_id_fkey";
ALTER TABLE "documents" DROP CONSTRAINT "documents_package_id_fkey";
ALTER TABLE "documents_creators" DROP CONSTRAINT "documents_creators_document_id_fkey";
ALTER TABLE "documents_creators" DROP CONSTRAINT "documents_creators_creator_id_fkey";
ALTER TABLE "external_refs" DROP CONSTRAINT "external_refs_document_namespace_id_fkey";
ALTER TABLE "external_refs" DROP CONSTRAINT "external_refs_document_id_fkey";
ALTER TABLE "file_contributors" DROP CONSTRAINT "file_contributors_file_id_fkey";
ALTER TABLE "files" DROP CONSTRAINT "files_project_id_fkey";
ALTER TABLE "files" DROP CONSTRAINT "files_file_type_id_fkey";
ALTER TABLE "files_licenses" DROP CONSTRAINT "files_licenses_file_id_fkey";
ALTER TABLE "files_licenses" DROP CONSTRAINT "files_licenses_license_id_fkey";
ALTER TABLE "files_scans" DROP CONSTRAINT "files_scans_file_id_fkey";
ALTER TABLE "files_scans" DROP CONSTRAINT "files_scans_scanner_id_fkey";
ALTER TABLE "identifiers" DROP CONSTRAINT "identifiers_document_namespace_id_fkey";
ALTER TABLE "identifiers" DROP CONSTRAINT "identifiers_document_id_fkey";
ALTER TABLE "identifiers" DROP CONSTRAINT "identifiers_package_id_fkey";
ALTER TABLE "identifiers" DROP CONSTRAINT "identifiers_package_file_id_fkey";
ALTER TABLE "packages" DROP CONSTRAINT "packages_supplier_id_fkey";
ALTER TABLE "packages" DROP CONSTRAINT "packages_originator_id_fkey";
ALTER TABLE "packages" DROP CONSTRAINT "packages_concluded_license_id_fkey";
ALTER TABLE "packages" DROP CONSTRAINT "packages_declared_license_id_fkey";
ALTER TABLE "packages" DROP CONSTRAINT "fk_package_packages_files";
ALTER TABLE "packages_files" DROP CONSTRAINT "packages_files_file_id_fkey";
ALTER TABLE "packages_files" DROP CONSTRAINT "packages_files_concluded_license_id_fkey";
ALTER TABLE "packages_files" DROP CONSTRAINT "fk_package_files_packages";
ALTER TABLE "packages_scans" DROP CONSTRAINT "packages_scans_package_id_fkey";
ALTER TABLE "packages_scans" DROP CONSTRAINT "packages_scans_scanner_id_fkey";
ALTER TABLE "relationships" DROP CONSTRAINT "relationships_left_identifier_id_fkey";
ALTER TABLE "relationships" DROP CONSTRAINT "relationships_right_identifier_id_fkey";
ALTER TABLE "relationships" DROP CONSTRAINT "relationships_relationship_type_id_fkey";

ALTER TABLE "annotation_types" DROP CONSTRAINT "uc_annotation_type_name";
ALTER TABLE "annotation_types" DROP CONSTRAINT "annotation_types_pkey";
ALTER TABLE "annotations" DROP CONSTRAINT "annotations_pkey";
ALTER TABLE "creator_types" DROP CONSTRAINT "creator_types_pkey";
ALTER TABLE "creators" DROP CONSTRAINT "creators_pkey";
ALTER TABLE "document_namespaces" DROP CONSTRAINT "uc_document_namespace_uri";
ALTER TABLE "document_namespaces" DROP CONSTRAINT "document_namespaces_pkey";
ALTER TABLE "documents" DROP CONSTRAINT "uc_document_document_namespace_id";
ALTER TABLE "documents" DROP CONSTRAINT "documents_pkey";
ALTER TABLE "documents_creators" DROP CONSTRAINT "documents_creators_pkey";
ALTER TABLE "external_refs" DROP CONSTRAINT "uc_external_ref_document_id_string";
ALTER TABLE "external_refs" DROP CONSTRAINT "external_refs_pkey";
ALTER TABLE "file_contributors" DROP CONSTRAINT "file_contributors_pkey";
ALTER TABLE "file_types" DROP CONSTRAINT "uc_file_type_name";
ALTER TABLE "file_types" DROP CONSTRAINT "file_types_pkey";
ALTER TABLE "files" DROP CONSTRAINT "uc_file_sha256";
ALTER TABLE "files" DROP CONSTRAINT "files_pkey";
ALTER TABLE "files_licenses" DROP CONSTRAINT "uc_file_license";
ALTER TABLE "files_licenses" DROP CONSTRAINT "files_licenses_pkey";
ALTER TABLE "files_scans" DROP CONSTRAINT "uc_file_scanner_id";
ALTER TABLE "files_scans" DROP CONSTRAINT "files_scans_pkey";
ALTER TABLE "identifiers" DROP CONSTRAINT "uc_identifier_document_namespace_id";
ALTER TABLE "identifiers" DROP CONSTRAINT "uc_identifier_namespace_document_id";
ALTER TABLE "identifiers" DROP CONSTRAINT "uc_identifier_namespace_package_id";
ALTER TABLE "identifiers" DROP CONSTRAINT "uc_identifier_namespace_package_file_id";
ALTER TABLE "identifiers" DROP CONSTRAINT "ck_identifier_exactly_one";
ALTER TABLE "identifiers" DROP CONSTRAINT "identifiers_pkey";
ALTER TABLE "licenses" DROP CONSTRAINT "uc_license_short_name";
ALTER TABLE "licenses" DROP CONSTRAINT "licenses_pkey";
ALTER TABLE "packages" DROP CONSTRAINT "uc_package_sha256";
ALTER TABLE "packages" DROP CONSTRAINT "uc_dir_code_ver_code";
ALTER TABLE "packages" DROP CONSTRAINT "uc_sha256_ds2_dir_code_exactly_one";
ALTER TABLE "packages" DROP CONSTRAINT "packages_pkey";
ALTER TABLE "packages_files" DROP CONSTRAINT "uc_package_id_file_name";
ALTER TABLE "packages_files" DROP CONSTRAINT "packages_files_pkey";
ALTER TABLE "packages_scans" DROP CONSTRAINT "uc_package_scanner_id";
ALTER TABLE "packages_scans" DROP CONSTRAINT "packages_scans_pkey";
ALTER TABLE "projects" DROP CONSTRAINT "projects_pkey";
ALTER TABLE "relationship_types" DROP CONSTRAINT "uc_relationship_type_name";
ALTER TABLE "relationship_types" DROP CONSTRAINT "relationship_types_pkey";
ALTER TABLE "relationships" DROP CONSTRAINT "uc_left_right_relationship_type";
ALTER TABLE "relationships" DROP CONSTRAINT "relationships_pkey";
ALTER TABLE "scanners" DROP CONSTRAINT "uc_scanner_name";
ALTER TABLE "scanners" DROP CONSTRAINT "scanners_pkey";

DROP TABLE "annotation_types";
DROP TABLE "annotations";
DROP TABLE "creator_types";
DROP TABLE "creators";
DROP TABLE "document_namespaces";
DROP TABLE "documents";
DROP TABLE "documents_creators";
DROP TABLE "external_refs";
DROP TABLE "file_contributors";
DROP TABLE "file_types";
DROP TABLE "files";
DROP TABLE "files_licenses";
DROP TABLE "files_scans";
DROP TABLE "identifiers";
DROP TABLE "licenses";
DROP TABLE "packages";
DROP TABLE "packages_files";
DROP TABLE "packages_scans";
DROP TABLE "projects";
DROP TABLE "relationship_types";
DROP TABLE "relationships";
DROP TABLE "scanners";

CREATE TABLE "annotation_types" (
"annotation_type_id" int4 NOT NULL DEFAULT nextval('annotation_types_annotation_type_id_seq'::regclass),
"name" varchar(255) COLLATE "default" NOT NULL,
CONSTRAINT "annotation_types_pkey" PRIMARY KEY ("annotation_type_id") ,
CONSTRAINT "uc_annotation_type_name" UNIQUE ("name")
)
WITHOUT OIDS;
ALTER TABLE "annotation_types" OWNER TO "spdx";

CREATE TABLE "annotations" (
"annotation_id" int4 NOT NULL DEFAULT nextval('annotations_annotation_id_seq'::regclass),
"document_id" int4 NOT NULL,
"annotation_type_id" int4 NOT NULL,
"identifier_id" int4 NOT NULL,
"creator_id" int4 NOT NULL,
"created_ts" timestamptz(6),
"comment" text COLLATE "default" NOT NULL,
CONSTRAINT "annotations_pkey" PRIMARY KEY ("annotation_id") 
)
WITHOUT OIDS;
ALTER TABLE "annotations" OWNER TO "spdx";

CREATE TABLE "creator_types" (
"creator_type_id" int4 NOT NULL DEFAULT nextval('creator_types_creator_type_id_seq'::regclass),
"name" varchar(255) COLLATE "default" NOT NULL,
CONSTRAINT "creator_types_pkey" PRIMARY KEY ("creator_type_id") 
)
WITHOUT OIDS;
ALTER TABLE "creator_types" OWNER TO "spdx";

CREATE TABLE "creators" (
"creator_id" int4 NOT NULL DEFAULT nextval('creators_creator_id_seq'::regclass),
"creator_type_id" int4 NOT NULL,
"name" varchar(255) COLLATE "default" NOT NULL,
"email" varchar(255) COLLATE "default" NOT NULL,
CONSTRAINT "creators_pkey" PRIMARY KEY ("creator_id") 
)
WITHOUT OIDS;
ALTER TABLE "creators" OWNER TO "spdx";

CREATE TABLE "document_namespaces" (
"document_namespace_id" int4 NOT NULL DEFAULT nextval('document_namespaces_document_namespace_id_seq'::regclass),
"uri" varchar(500) COLLATE "default" NOT NULL,
CONSTRAINT "document_namespaces_pkey" PRIMARY KEY ("document_namespace_id") ,
CONSTRAINT "uc_document_namespace_uri" UNIQUE ("uri")
)
WITHOUT OIDS;
ALTER TABLE "document_namespaces" OWNER TO "spdx";

CREATE TABLE "documents" (
"document_id" int4 NOT NULL DEFAULT nextval('documents_document_id_seq'::regclass),
"document_namespace_id" int4 NOT NULL,
"data_license_id" int4 NOT NULL,
"spdx_version" varchar(255) COLLATE "default" NOT NULL,
"name" varchar(255) COLLATE "default" NOT NULL,
"license_list_version" varchar(255) COLLATE "default" NOT NULL,
"created_ts" timestamptz(6) NOT NULL,
"creator_comment" text COLLATE "default" NOT NULL,
"document_comment" text COLLATE "default" NOT NULL,
"package_id" int4 NOT NULL,
CONSTRAINT "documents_pkey" PRIMARY KEY ("document_id") ,
CONSTRAINT "uc_document_document_namespace_id" UNIQUE ("document_namespace_id")
)
WITHOUT OIDS;
ALTER TABLE "documents" OWNER TO "spdx";

CREATE TABLE "documents_creators" (
"document_creator_id" int4 NOT NULL DEFAULT nextval('documents_creators_document_creator_id_seq'::regclass),
"document_id" int4 NOT NULL,
"creator_id" int4 NOT NULL,
CONSTRAINT "documents_creators_pkey" PRIMARY KEY ("document_creator_id") 
)
WITHOUT OIDS;
ALTER TABLE "documents_creators" OWNER TO "spdx";

CREATE TABLE "external_refs" (
"external_ref_id" int4 NOT NULL DEFAULT nextval('external_refs_external_ref_id_seq'::regclass),
"document_id" int4 NOT NULL,
"document_namespace_id" int4 NOT NULL,
"id_string" varchar(255) COLLATE "default" NOT NULL,
"sha256" varchar(64) COLLATE "default" NOT NULL,
CONSTRAINT "external_refs_pkey" PRIMARY KEY ("external_ref_id") ,
CONSTRAINT "uc_external_ref_document_id_string" UNIQUE ("document_id", "id_string")
)
WITHOUT OIDS;
ALTER TABLE "external_refs" OWNER TO "spdx";

CREATE TABLE "file_contributors" (
"file_contributor_id" int4 NOT NULL DEFAULT nextval('file_contributors_file_contributor_id_seq'::regclass),
"file_id" int4 NOT NULL,
"contributor" text COLLATE "default" NOT NULL,
CONSTRAINT "file_contributors_pkey" PRIMARY KEY ("file_contributor_id") 
)
WITHOUT OIDS;
ALTER TABLE "file_contributors" OWNER TO "spdx";

CREATE TABLE "file_types" (
"file_type_id" int4 NOT NULL DEFAULT nextval('file_types_file_type_id_seq'::regclass),
"name" varchar(255) COLLATE "default" NOT NULL,
CONSTRAINT "file_types_pkey" PRIMARY KEY ("file_type_id") ,
CONSTRAINT "uc_file_type_name" UNIQUE ("name")
)
WITHOUT OIDS;
ALTER TABLE "file_types" OWNER TO "spdx";

CREATE TABLE "files" (
"file_id" int4 NOT NULL DEFAULT nextval('files_file_id_seq'::regclass),
"file_type_id" int4 NOT NULL,
"sha256" varchar(64) COLLATE "default" NOT NULL,
"copyright_text" text COLLATE "default",
"project_id" int4,
"comment" text COLLATE "default" NOT NULL,
"notice" text COLLATE "default" NOT NULL,
CONSTRAINT "files_pkey" PRIMARY KEY ("file_id") ,
CONSTRAINT "uc_file_sha256" UNIQUE ("sha256")
)
WITHOUT OIDS;
ALTER TABLE "files" OWNER TO "spdx";

CREATE TABLE "files_licenses" (
"file_license_id" int4 NOT NULL DEFAULT nextval('files_licenses_file_license_id_seq'::regclass),
"file_id" int4 NOT NULL,
"license_id" int4 NOT NULL,
"extracted_text" text COLLATE "default" NOT NULL,
CONSTRAINT "files_licenses_pkey" PRIMARY KEY ("file_license_id") ,
CONSTRAINT "uc_file_license" UNIQUE ("file_id", "license_id")
)
WITHOUT OIDS;
ALTER TABLE "files_licenses" OWNER TO "spdx";

CREATE TABLE "files_scans" (
"file_scan_id" int4 NOT NULL DEFAULT nextval('files_scans_file_scan_id_seq'::regclass),
"file_id" int4 NOT NULL,
"scanner_id" int4 NOT NULL,
CONSTRAINT "files_scans_pkey" PRIMARY KEY ("file_scan_id") ,
CONSTRAINT "uc_file_scanner_id" UNIQUE ("file_id", "scanner_id")
)
WITHOUT OIDS;
ALTER TABLE "files_scans" OWNER TO "spdx";

CREATE TABLE "identifiers" (
"identifier_id" int4 NOT NULL DEFAULT nextval('identifiers_identifier_id_seq'::regclass),
"document_namespace_id" int4 NOT NULL,
"id_string" varchar(255) COLLATE "default" NOT NULL,
"document_id" int4,
"package_id" int4,
"package_file_id" int4,
CONSTRAINT "identifiers_pkey" PRIMARY KEY ("identifier_id") ,
CONSTRAINT "uc_identifier_document_namespace_id" UNIQUE ("document_namespace_id", "id_string"),
CONSTRAINT "uc_identifier_namespace_document_id" UNIQUE ("document_namespace_id", "document_id"),
CONSTRAINT "uc_identifier_namespace_package_id" UNIQUE ("document_namespace_id", "package_id"),
CONSTRAINT "uc_identifier_namespace_package_file_id" UNIQUE ("document_namespace_id", "package_file_id"),
CONSTRAINT "ck_identifier_exactly_one" CHECK ((((((document_id IS NOT NULL))::integer + ((package_id IS NOT NULL))::integer) + ((package_file_id IS NOT NULL))::integer) = 1))
)
WITHOUT OIDS;
ALTER TABLE "identifiers" OWNER TO "spdx";

CREATE TABLE "licenses" (
"license_id" int4 NOT NULL DEFAULT nextval('licenses_license_id_seq'::regclass),
"name" varchar(255) COLLATE "default",
"short_name" varchar(255) COLLATE "default" NOT NULL,
"cross_reference" text COLLATE "default" NOT NULL,
"comment" text COLLATE "default" NOT NULL,
"is_spdx_official" bool NOT NULL,
CONSTRAINT "licenses_pkey" PRIMARY KEY ("license_id") ,
CONSTRAINT "uc_license_short_name" UNIQUE ("short_name")
)
WITHOUT OIDS;
ALTER TABLE "licenses" OWNER TO "spdx";

CREATE TABLE "packages" (
"package_id" int4 NOT NULL DEFAULT nextval('packages_package_id_seq'::regclass),
"name" varchar(255) COLLATE "default" NOT NULL,
"version" varchar(255) COLLATE "default" NOT NULL,
"file_name" text COLLATE "default" NOT NULL,
"supplier_id" int4,
"originator_id" int4,
"download_location" text COLLATE "default",
"verification_code" varchar(64) COLLATE "default" NOT NULL,
"ver_code_excluded_file_id" int4,
"sha256" varchar(64) COLLATE "default",
"home_page" text COLLATE "default",
"source_info" text COLLATE "default" NOT NULL,
"concluded_license_id" int4,
"declared_license_id" int4,
"license_comment" text COLLATE "default" NOT NULL,
"copyright_text" text COLLATE "default",
"summary" text COLLATE "default" NOT NULL,
"description" text COLLATE "default" NOT NULL,
"comment" text COLLATE "default" NOT NULL,
"dosocs2_dir_code" varchar(64) COLLATE "default",
CONSTRAINT "packages_pkey" PRIMARY KEY ("package_id") ,
CONSTRAINT "uc_package_sha256" UNIQUE ("sha256"),
CONSTRAINT "uc_dir_code_ver_code" UNIQUE ("verification_code", "dosocs2_dir_code"),
CONSTRAINT "uc_sha256_ds2_dir_code_exactly_one" CHECK (((((sha256 IS NOT NULL))::integer + ((dosocs2_dir_code IS NOT NULL))::integer) = 1))
)
WITHOUT OIDS;
ALTER TABLE "packages" OWNER TO "spdx";

CREATE TABLE "packages_files" (
"package_file_id" int4 NOT NULL DEFAULT nextval('packages_files_package_file_id_seq'::regclass),
"package_id" int4 NOT NULL,
"file_id" int4 NOT NULL,
"concluded_license_id" int4,
"license_comment" text COLLATE "default" NOT NULL,
"file_name" text COLLATE "default" NOT NULL,
CONSTRAINT "packages_files_pkey" PRIMARY KEY ("package_file_id") ,
CONSTRAINT "uc_package_id_file_name" UNIQUE ("package_id", "file_name")
)
WITHOUT OIDS;
ALTER TABLE "packages_files" OWNER TO "spdx";

CREATE TABLE "packages_scans" (
"package_scan_id" int4 NOT NULL DEFAULT nextval('packages_scans_package_scan_id_seq'::regclass),
"package_id" int4 NOT NULL,
"scanner_id" int4 NOT NULL,
CONSTRAINT "packages_scans_pkey" PRIMARY KEY ("package_scan_id") ,
CONSTRAINT "uc_package_scanner_id" UNIQUE ("package_id", "scanner_id")
)
WITHOUT OIDS;
ALTER TABLE "packages_scans" OWNER TO "spdx";

CREATE TABLE "projects" (
"project_id" int4 NOT NULL DEFAULT nextval('projects_project_id_seq'::regclass),
"name" text COLLATE "default" NOT NULL,
"homepage" text COLLATE "default" NOT NULL,
"uri" text COLLATE "default" NOT NULL,
CONSTRAINT "projects_pkey" PRIMARY KEY ("project_id") 
)
WITHOUT OIDS;
ALTER TABLE "projects" OWNER TO "spdx";

CREATE TABLE "relationship_types" (
"relationship_type_id" int4 NOT NULL DEFAULT nextval('relationship_types_relationship_type_id_seq'::regclass),
"name" varchar(255) COLLATE "default" NOT NULL,
CONSTRAINT "relationship_types_pkey" PRIMARY KEY ("relationship_type_id") ,
CONSTRAINT "uc_relationship_type_name" UNIQUE ("name")
)
WITHOUT OIDS;
ALTER TABLE "relationship_types" OWNER TO "spdx";

CREATE TABLE "relationships" (
"relationship_id" int4 NOT NULL DEFAULT nextval('relationships_relationship_id_seq'::regclass),
"left_identifier_id" int4 NOT NULL,
"right_identifier_id" int4 NOT NULL,
"relationship_type_id" int4 NOT NULL,
"relationship_comment" text COLLATE "default" NOT NULL,
CONSTRAINT "relationships_pkey" PRIMARY KEY ("relationship_id") ,
CONSTRAINT "uc_left_right_relationship_type" UNIQUE ("left_identifier_id", "right_identifier_id", "relationship_type_id")
)
WITHOUT OIDS;
ALTER TABLE "relationships" OWNER TO "spdx";

CREATE TABLE "scanners" (
"scanner_id" int4 NOT NULL DEFAULT nextval('scanners_scanner_id_seq'::regclass),
"name" varchar(255) COLLATE "default" NOT NULL,
CONSTRAINT "scanners_pkey" PRIMARY KEY ("scanner_id") ,
CONSTRAINT "uc_scanner_name" UNIQUE ("name")
)
WITHOUT OIDS;
ALTER TABLE "scanners" OWNER TO "spdx";


ALTER TABLE "annotations" ADD CONSTRAINT "annotations_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "documents" ("document_id") ON UPDATE NO ACTION;
ALTER TABLE "annotations" ADD CONSTRAINT "annotations_annotation_type_id_fkey" FOREIGN KEY ("annotation_type_id") REFERENCES "annotation_types" ("annotation_type_id") ON UPDATE NO ACTION;
ALTER TABLE "annotations" ADD CONSTRAINT "annotations_identifier_id_fkey" FOREIGN KEY ("identifier_id") REFERENCES "identifiers" ("identifier_id") ON UPDATE NO ACTION;
ALTER TABLE "annotations" ADD CONSTRAINT "annotations_creator_id_fkey" FOREIGN KEY ("creator_id") REFERENCES "creators" ("creator_id") ON UPDATE NO ACTION;
ALTER TABLE "creators" ADD CONSTRAINT "creators_creator_type_id_fkey" FOREIGN KEY ("creator_type_id") REFERENCES "creator_types" ("creator_type_id") ON UPDATE NO ACTION;
ALTER TABLE "documents" ADD CONSTRAINT "documents_document_namespace_id_fkey" FOREIGN KEY ("document_namespace_id") REFERENCES "document_namespaces" ("document_namespace_id") ON UPDATE NO ACTION;
ALTER TABLE "documents" ADD CONSTRAINT "documents_data_license_id_fkey" FOREIGN KEY ("data_license_id") REFERENCES "licenses" ("license_id") ON UPDATE NO ACTION;
ALTER TABLE "documents" ADD CONSTRAINT "documents_package_id_fkey" FOREIGN KEY ("package_id") REFERENCES "packages" ("package_id") ON UPDATE NO ACTION;
ALTER TABLE "documents_creators" ADD CONSTRAINT "documents_creators_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "documents" ("document_id") ON UPDATE NO ACTION;
ALTER TABLE "documents_creators" ADD CONSTRAINT "documents_creators_creator_id_fkey" FOREIGN KEY ("creator_id") REFERENCES "creators" ("creator_id") ON UPDATE NO ACTION;
ALTER TABLE "external_refs" ADD CONSTRAINT "external_refs_document_namespace_id_fkey" FOREIGN KEY ("document_namespace_id") REFERENCES "document_namespaces" ("document_namespace_id") ON UPDATE NO ACTION;
ALTER TABLE "external_refs" ADD CONSTRAINT "external_refs_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "documents" ("document_id") ON UPDATE NO ACTION;
ALTER TABLE "file_contributors" ADD CONSTRAINT "file_contributors_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files" ("file_id") ON UPDATE NO ACTION;
ALTER TABLE "files" ADD CONSTRAINT "files_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "projects" ("project_id") ON UPDATE NO ACTION;
ALTER TABLE "files" ADD CONSTRAINT "files_file_type_id_fkey" FOREIGN KEY ("file_type_id") REFERENCES "file_types" ("file_type_id") ON UPDATE NO ACTION;
ALTER TABLE "files_licenses" ADD CONSTRAINT "files_licenses_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files" ("file_id") ON UPDATE NO ACTION;
ALTER TABLE "files_licenses" ADD CONSTRAINT "files_licenses_license_id_fkey" FOREIGN KEY ("license_id") REFERENCES "licenses" ("license_id") ON UPDATE NO ACTION;
ALTER TABLE "files_scans" ADD CONSTRAINT "files_scans_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files" ("file_id") ON UPDATE NO ACTION;
ALTER TABLE "files_scans" ADD CONSTRAINT "files_scans_scanner_id_fkey" FOREIGN KEY ("scanner_id") REFERENCES "scanners" ("scanner_id") ON UPDATE NO ACTION;
ALTER TABLE "identifiers" ADD CONSTRAINT "identifiers_document_namespace_id_fkey" FOREIGN KEY ("document_namespace_id") REFERENCES "document_namespaces" ("document_namespace_id") ON UPDATE NO ACTION;
ALTER TABLE "identifiers" ADD CONSTRAINT "identifiers_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "documents" ("document_id") ON UPDATE NO ACTION;
ALTER TABLE "identifiers" ADD CONSTRAINT "identifiers_package_id_fkey" FOREIGN KEY ("package_id") REFERENCES "packages" ("package_id") ON UPDATE NO ACTION;
ALTER TABLE "identifiers" ADD CONSTRAINT "identifiers_package_file_id_fkey" FOREIGN KEY ("package_file_id") REFERENCES "packages_files" ("package_file_id") ON UPDATE NO ACTION;
ALTER TABLE "packages" ADD CONSTRAINT "packages_supplier_id_fkey" FOREIGN KEY ("supplier_id") REFERENCES "creators" ("creator_id") ON UPDATE NO ACTION;
ALTER TABLE "packages" ADD CONSTRAINT "packages_originator_id_fkey" FOREIGN KEY ("originator_id") REFERENCES "creators" ("creator_id") ON UPDATE NO ACTION;
ALTER TABLE "packages" ADD CONSTRAINT "packages_concluded_license_id_fkey" FOREIGN KEY ("concluded_license_id") REFERENCES "licenses" ("license_id") ON UPDATE NO ACTION;
ALTER TABLE "packages" ADD CONSTRAINT "packages_declared_license_id_fkey" FOREIGN KEY ("declared_license_id") REFERENCES "licenses" ("license_id") ON UPDATE NO ACTION;
ALTER TABLE "packages" ADD CONSTRAINT "fk_package_packages_files" FOREIGN KEY ("ver_code_excluded_file_id") REFERENCES "packages_files" ("package_file_id") ON UPDATE NO ACTION;
ALTER TABLE "packages_files" ADD CONSTRAINT "packages_files_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files" ("file_id") ON UPDATE NO ACTION;
ALTER TABLE "packages_files" ADD CONSTRAINT "packages_files_concluded_license_id_fkey" FOREIGN KEY ("concluded_license_id") REFERENCES "licenses" ("license_id") ON UPDATE NO ACTION;
ALTER TABLE "packages_files" ADD CONSTRAINT "fk_package_files_packages" FOREIGN KEY ("package_id") REFERENCES "packages" ("package_id") ON UPDATE NO ACTION;
ALTER TABLE "packages_scans" ADD CONSTRAINT "packages_scans_package_id_fkey" FOREIGN KEY ("package_id") REFERENCES "packages" ("package_id") ON UPDATE NO ACTION;
ALTER TABLE "packages_scans" ADD CONSTRAINT "packages_scans_scanner_id_fkey" FOREIGN KEY ("scanner_id") REFERENCES "scanners" ("scanner_id") ON UPDATE NO ACTION;
ALTER TABLE "relationships" ADD CONSTRAINT "relationships_left_identifier_id_fkey" FOREIGN KEY ("left_identifier_id") REFERENCES "identifiers" ("identifier_id") ON UPDATE NO ACTION;
ALTER TABLE "relationships" ADD CONSTRAINT "relationships_right_identifier_id_fkey" FOREIGN KEY ("right_identifier_id") REFERENCES "identifiers" ("identifier_id") ON UPDATE NO ACTION;
ALTER TABLE "relationships" ADD CONSTRAINT "relationships_relationship_type_id_fkey" FOREIGN KEY ("relationship_type_id") REFERENCES "relationship_types" ("relationship_type_id") ON UPDATE NO ACTION;

