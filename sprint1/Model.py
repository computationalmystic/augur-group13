class License:
    def __init__(self, license_id, name, short_name, cross_reference, comment, is_spdx_official):
        self.license_id = license_id
        self.name = name
        self.short_name = short_name
        self.cross_reference = cross_reference
        self.comment = comment
        self.is_spdx_official = is_spdx_official


class FileType:
    def __init__(self, file_type_id, name):
        self.file_type_id = file_type_id
        self.name = name


class Project:
    def __init__(self, project_id, name, homepage, uri):
        self.project_id = project_id
        self.name = name
        self.homepage = homepage
        self.uri = uri


class File:
    def __init__(self, file_id, file_type_id, sha256, copyright_text, project_id, comment, notice):
        self.file_id = file_id
        self.file_type_id = file_type_id
        self.sha256 = sha256
        self.copyright_text = copyright_text
        self.project_id = project_id
        self.comment = comment
        self.notice = notice


class FileLicense:
    def __init__(self, file_license_id, file_id, license_id, extracted_text):
        self.file_license_id = file_license_id
        self.file_id = file_id
        self.license_id = license_id
        self.extracted_text = extracted_text


class CreatorType:
    def __init__(self, creator_type_id, name):
        self.creator_type_id = creator_type_id
        self.name = name


class Creator:
    def __init__(self, creator_id, creator_type_id, name, email):
        self.creator_id = creator_id
        self.creator_type_id = creator_type_id
        self.name = name
        self.email = email


class Package:
    def __init__(self,
                 package_id,
                 name,
                 version,
                 file_name,
                 supplier_id,
                 originator_id,
                 download_location,
                 verification_code,
                 ver_code_excluded_file_id,
                 sha256,
                 home_page,
                 source_info,
                 concluded_license_id,
                 declared_license_id,
                 license_comment,
                 copyright_text,
                 summary,
                 description,
                 comment,
                 dosocs2_dir_code):
        self.package_id = package_id
        self.name = name
        self.version = version
        self.file_name = file_name
        self.supplier_id = supplier_id
        self.originator_id = originator_id
        self.download_location = download_location
        self.verification_code = verification_code
        self.ver_code_excluded_file_id = ver_code_excluded_file_id
        self.sha256 = sha256
        self.home_page = home_page
        self.source_info = source_info
        self.concluded_license_id = concluded_license_id
        self.declared_license_id = declared_license_id
        self.license_comment = license_comment
        self.copyright_text = copyright_text
        self.summary = summary
        self.description = description
        self.comment = comment
        self.dosocs2_dir_code = dosocs2_dir_code


class PackageFile:
    def __init__(self, package_file_id, package_id, file_id, concluded_license_id, license_comment, file_name):
        self.package_file_id = package_file_id
        self.package_id = package_id
        self.file_id = file_id
        self.concluded_license_id = concluded_license_id
        self.license_comment = license_comment
        self.file_name = file_name


class DocumentNamespace:
    def __init__(self, document_namespace_id, uri):
        self.document_namespace_id = document_namespace_id
        self.uri = uri


class Document:
    def __init__(self,
                 document_id,
                 document_namespace_id,
                 data_license_id,
                 spdx_version,
                 name,
                 license_list_version,
                 created_ts,
                 creator_comment,
                 document_comment,
                 package_id):
        self.document_id = document_id
        self.document_namespace_id = document_namespace_id
        self.data_license_id = data_license_id
        self.spdx_version = spdx_version
        self.name = name
        self.license_list_version = license_list_version
        self.created_ts = created_ts
        self.creator_comment = creator_comment
        self.document_comment = document_comment
        self.package_id = package_id


class ExternalRef:
    def __init__(self, external_ref_id, document_id, document_namespace_id, id_string, sha256):
        self.external_ref_id = external_ref_id
        self.document_id = document_id
        self.document_namespace_id = document_namespace_id
        self.id_string = id_string
        self.sha256 = sha256


class DocumentCreator:
    def __init__(self, document_creator_id, document_id, creator_id):
        self.document_creator_id = document_creator_id
        self.document_id = document_id
        self.creator_id = creator_id


class FileContributor:
    def __init__(self, file_contributor_id, file_id, contributor):
        self.file_contributor_id = file_contributor_id
        self.file_id = file_id
        self.contributor = contributor


class Identifier:
    def __init__(self, identifier_id, document_namespace_id, id_string, document_id, package_id, package_file_id):
        self.identifier_id = identifier_id
        self.document_namespace_id = document_namespace_id
        self.id_string = id_string
        self.document_id = document_id
        self.package_id = package_id
        self.package_file_id = package_file_id


class RelationshipType:
    def __init__(self, relationship_type_id, name):
        self.relationship_type_id = relationship_type_id
        self.name = name


class Relationship:
    def __init__(self,
                 relationship_id,
                 left_identifier_id,
                 right_identifier_id,
                 relationship_type_id,
                 relationship_comment):
        self.relationship_id = relationship_id
        self.left_identifier_id = left_identifier_id
        self.right_identifier_id = right_identifier_id
        self.relationship_type_id = relationship_type_id
        self.relationship_comment = relationship_comment


class AnnotationType:
    def __init__(self, annotation_type_id, name):
        self.annotation_type_id = annotation_type_id,
        self.name = name


class Annotation:
    def __init__(self, annotation_id, document_id, annotation_type_id, identifier_id, creator_id, created_ts, comment):
        self.annotation_id = annotation_id
        self.document_id = document_id
        self.annotation_type_id = annotation_type_id
        self.identifier_id = identifier_id
        self.creator_id = creator_id
        self.created_ts = created_ts
        self.comment = comment


class Scanner:
    def __init__(self, scanner_id, name):
        self.scanner_id = scanner_id
        self.name = name


class PackageScan:
    def __init__(self, package_scan_id, package_id, scanner_id):
        self.package_scan_id = package_scan_id
        self.package_id = package_id
        self.scanner_id = scanner_id


class FileScan:
    def __init__(self, file_scan_id, file_id, scanner_id):
        self.file_scan_id = file_scan_id
        self.file_id = file_id
        self.scanner_id = scanner_id


class Queries:
    def __init__(self, host, port, username, password):
        # TODO starts database connection
        return

    def get_license(self, projectId):
        # TODO gets license/licenses from the projectId
        return

    def get_creators(self, projectId):
        # TODO gets the creators of the project
        return

    def get_files(self, projectId):
        # TODO gets files of a project
        return

    def close(self):
        # TODO closes database connection
        return
