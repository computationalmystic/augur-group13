# Sprint 1 Design Document Group 13

## Deployment Environment

[Group 13 Amazon EC2 Instance](ec2-3-17-191-219.us-east-2.compute.amazonaws.com)

## Functional Requirements

1. User Requirements
	- A user will be able to enter github repo url's
	- A user will be able to view license-related risk evaluation metrics in a tabular form
	- A user will be able to sort and toggle risk metrics by various criteria (license type, file name, etc.)
2. Back-End Requirements
	- The back-end will be able to parse files in a github repo for licensing data
	- The back-end will be able to evaluate risk associated with various licenses
	- The back-end will be able to send collected risk metrics to front-end
3. Front-End Requirements
	- The front-end will have an address bar for entering github repo url's
	- The front-end will be able to collect data sent from back-end and display it in a tabular fashion

## Database Design

### ERD

![ERD](./images/erd.png)

### DDL

```Python
# Copyright (C) 2015 University of Nebraska at Omaha
#
# This file is part of dosocs2.
#
# dosocs2 is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# dosocs2 is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with dosocs2.  If not, see <http://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: GPL-2.0+

from sqlalchemy import MetaData, Table, create_engine, Column
from sqlalchemy import Integer, String, Text, Boolean, DateTime
from sqlalchemy import ForeignKeyConstraint, CheckConstraint, UniqueConstraint
from sqlalchemy import func

meta = MetaData()

licenses = Table('licenses', meta,
    Column('license_id', Integer, primary_key=True),
    Column('name', String(255)),
    Column('short_name', String(255), nullable=False),
    Column('cross_reference', Text, nullable=False),
    Column('comment', Text, nullable=False),
    Column('is_spdx_official', Boolean, nullable=False),
    UniqueConstraint('short_name', name='uc_license_short_name')
    )

file_types = Table('file_types', meta,
    Column('file_type_id', Integer, primary_key=True),
    Column('name', String(255), nullable=False),
    UniqueConstraint('name', name='uc_file_type_name')
    )

projects = Table('projects', meta,
    Column('project_id', Integer, primary_key=True),
    Column('name', Text, nullable=False),
    Column('homepage', Text, nullable=False),
    Column('uri', Text, nullable=False)
    )

files = Table('files', meta,
    Column('file_id', Integer, primary_key=True),
    Column('file_type_id', Integer, nullable=False),
    Column('sha256', String(64), nullable=False),
    Column('copyright_text', Text),
    Column('project_id', Integer),
    Column('comment', Text, nullable=False),
    Column('notice', Text, nullable=False),
    UniqueConstraint('sha256', name='uc_file_sha256'),
    ForeignKeyConstraint(['project_id'], ['projects.project_id']),
    ForeignKeyConstraint(['file_type_id'], ['file_types.file_type_id'])
    )

files_licenses = Table('files_licenses', meta,
    Column('file_license_id', Integer, primary_key=True),
    Column('file_id', Integer, nullable=False),
    Column('license_id', Integer, nullable=False),
    Column('extracted_text', Text, nullable=False),
    UniqueConstraint('file_id', 'license_id', name='uc_file_license'),
    ForeignKeyConstraint(['file_id'], ['files.file_id']),
    ForeignKeyConstraint(['license_id'], ['licenses.license_id'])
    )

creator_types = Table('creator_types', meta,
    Column('creator_type_id', Integer, primary_key=True),
    Column('name', String(255), nullable=False),
    )

creators = Table('creators', meta,
    Column('creator_id', Integer, primary_key=True),
    Column('creator_type_id', Integer, nullable=False),
    Column('name', String(255), nullable=False),
    Column('email', String(255), nullable=False),
    ForeignKeyConstraint(['creator_type_id'], ['creator_types.creator_type_id'])
    )

packages = Table('packages', meta,
    Column('package_id', Integer, primary_key=True),
    Column('name', String(255), nullable=False),
    Column('version', String(255), nullable=False),
    Column('file_name', Text, nullable=False),
    Column('supplier_id', Integer),
    Column('originator_id', Integer),
    Column('download_location', Text),
    Column('verification_code', String(64), nullable=False),
    Column('ver_code_excluded_file_id', Integer),
    Column('sha256', String(64)),
    Column('home_page', Text),
    Column('source_info', Text, nullable=False),
    Column('concluded_license_id', Integer),
    Column('declared_license_id', Integer),
    Column('license_comment', Text, nullable=False),
    Column('copyright_text', Text),
    Column('summary', Text, nullable=False),
    Column('description', Text, nullable=False),
    Column('comment', Text, nullable=False),
    Column('dosocs2_dir_code', String(64)),
    UniqueConstraint('sha256', name='uc_package_sha256'),
    UniqueConstraint('verification_code', 'dosocs2_dir_code', name='uc_dir_code_ver_code'),
    CheckConstraint('''
    (cast(sha256 is not null as int) +
     cast(dosocs2_dir_code is not null as int)
     ) = 1
    ''', name='uc_sha256_ds2_dir_code_exactly_one'),
    ForeignKeyConstraint(['supplier_id'], ['creators.creator_id']),
    ForeignKeyConstraint(['originator_id'], ['creators.creator_id']),
    ForeignKeyConstraint(['concluded_license_id'], ['licenses.license_id']),
    ForeignKeyConstraint(['declared_license_id'], ['licenses.license_id']),
    # This fk creates a circular dependency -- the name is mandatory so
    # SQLAlchemy can gracefully resolve it
    ForeignKeyConstraint(['ver_code_excluded_file_id'],
                         ['packages_files.package_file_id'],
                         name='fk_package_packages_files',
                         use_alter=True
                         )
    )

packages_files = Table('packages_files', meta,
    Column('package_file_id', Integer, primary_key=True),
    Column('package_id', Integer, nullable=False),
    Column('file_id', Integer, nullable=False),
    Column('concluded_license_id', Integer),
    Column('license_comment', Text, nullable=False),
    Column('file_name', Text, nullable=False),
    UniqueConstraint('package_id', 'file_name', name='uc_package_id_file_name'),
    ForeignKeyConstraint(['package_id'], ['packages.package_id'],
                         use_alter=True, name='fk_package_files_packages'
                         ),
    ForeignKeyConstraint(['file_id'], ['files.file_id']),
    ForeignKeyConstraint(['concluded_license_id'], ['licenses.license_id'])
    )

document_namespaces = Table('document_namespaces', meta,
    Column('document_namespace_id', Integer, primary_key=True),
    Column('uri', String(500), nullable=False),
    UniqueConstraint('uri', name='uc_document_namespace_uri')
    )

documents = Table('documents', meta,
    Column('document_id', Integer, primary_key=True),
    Column('document_namespace_id', Integer, nullable=False),
    Column('data_license_id', Integer, nullable=False),
    Column('spdx_version', String(255), nullable=False),
    Column('name', String(255), nullable=False),
    Column('license_list_version', String(255), nullable=False),
    Column('created_ts', DateTime(timezone=True), nullable=False, default=func.current_timestamp()),
    Column('creator_comment', Text, nullable=False),
    Column('document_comment', Text, nullable=False),
    Column('package_id', Integer, nullable=False),
    UniqueConstraint('document_namespace_id', name='uc_document_document_namespace_id'),
    ForeignKeyConstraint(['document_namespace_id'], ['document_namespaces.document_namespace_id']),
    ForeignKeyConstraint(['data_license_id'], ['licenses.license_id']),
    ForeignKeyConstraint(['package_id'], ['packages.package_id']),
    )

external_refs = Table('external_refs', meta,
    Column('external_ref_id', Integer, primary_key=True),
    Column('document_id', Integer, nullable=False),
    Column('document_namespace_id', Integer, nullable=False),
    Column('id_string', String(255), nullable=False),
    Column('sha256', String(64), nullable=False),
    UniqueConstraint('document_id', 'id_string', name='uc_external_ref_document_id_string'),
    ForeignKeyConstraint(['document_namespace_id'], ['document_namespaces.document_namespace_id']),
    ForeignKeyConstraint(['document_id'], ['documents.document_id'])
    )

documents_creators = Table('documents_creators', meta,
    Column('document_creator_id', Integer, primary_key=True),
    Column('document_id', Integer, nullable=False),
    Column('creator_id', Integer, nullable=False),
    ForeignKeyConstraint(['document_id'], ['documents.document_id']),
    ForeignKeyConstraint(['creator_id'], ['creators.creator_id'])
    )

file_contributors = Table('file_contributors', meta,
    Column('file_contributor_id', Integer, primary_key=True),
    Column('file_id', Integer, nullable=False),
    Column('contributor', Text, nullable=False),
    ForeignKeyConstraint(['file_id'], ['files.file_id'])
    )

identifiers = Table('identifiers', meta,
    Column('identifier_id', Integer, primary_key=True),
    Column('document_namespace_id', Integer, nullable=False),
    Column('id_string', String(255), nullable=False),
    Column('document_id', Integer),
    Column('package_id', Integer),
    Column('package_file_id', Integer),
    UniqueConstraint('document_namespace_id', 'id_string', name='uc_identifier_document_namespace_id'),
    CheckConstraint('''
    (cast(document_id is not null as int) +
     cast(package_id is not null as int) +
     cast(package_file_id is not null as int)
     ) = 1
    ''', name='ck_identifier_exactly_one'),
    UniqueConstraint('document_namespace_id', 'document_id', name='uc_identifier_namespace_document_id'),
    UniqueConstraint('document_namespace_id', 'package_id', name='uc_identifier_namespace_package_id'),
    UniqueConstraint('document_namespace_id', 'package_file_id', name='uc_identifier_namespace_package_file_id'),
    UniqueConstraint('document_namespace_id', 'id_string', name='uc_identifier_namespace_id_string'),
    ForeignKeyConstraint(['document_namespace_id'], ['document_namespaces.document_namespace_id']),
    ForeignKeyConstraint(['document_id'], ['documents.document_id']),
    ForeignKeyConstraint(['package_id'], ['packages.package_id']),
    ForeignKeyConstraint(['package_file_id'], ['packages_files.package_file_id'])
    )

relationship_types = Table('relationship_types', meta,
    Column('relationship_type_id', Integer, primary_key=True),
    Column('name', String(255), nullable=False),
    UniqueConstraint('name', name='uc_relationship_type_name')
    )

relationships = Table('relationships', meta,
    Column('relationship_id', Integer, primary_key=True),
    Column('left_identifier_id', Integer, nullable=False),
    Column('right_identifier_id', Integer, nullable=False),
    Column('relationship_type_id', Integer, nullable=False),
    Column('relationship_comment', Text, nullable=False),
    ForeignKeyConstraint(['left_identifier_id'], ['identifiers.identifier_id']),
    ForeignKeyConstraint(['right_identifier_id'], ['identifiers.identifier_id']),
    ForeignKeyConstraint(['relationship_type_id'], ['relationship_types.relationship_type_id']),
    UniqueConstraint('left_identifier_id', 'right_identifier_id', 'relationship_type_id', name='uc_left_right_relationship_type')
    )

annotation_types = Table('annotation_types', meta,
    Column('annotation_type_id', Integer, primary_key=True),
    Column('name', String(255), nullable=False),
    UniqueConstraint('name', name='uc_annotation_type_name')
    )

annotations = Table('annotations', meta,
    Column('annotation_id', Integer, primary_key=True),
    Column('document_id', Integer, nullable=False),
    Column('annotation_type_id', Integer, nullable=False),
    Column('identifier_id', Integer, nullable=False),
    Column('creator_id', Integer, nullable=False),
    Column('created_ts', DateTime(timezone=True), default=func.utc_timestamp()),
    Column('comment', Text, nullable=False),
    ForeignKeyConstraint(['document_id'], ['documents.document_id']),
    ForeignKeyConstraint(['annotation_type_id'], ['annotation_types.annotation_type_id']),
    ForeignKeyConstraint(['identifier_id'], ['identifiers.identifier_id']),
    ForeignKeyConstraint(['creator_id'], ['creators.creator_id']),
    )

scanners = Table('scanners', meta,
    Column('scanner_id', Integer, primary_key=True),
    Column('name', String(255), nullable=False),
    UniqueConstraint('name', name='uc_scanner_name')
    )

packages_scans = Table('packages_scans', meta,
    Column('package_scan_id', Integer, primary_key=True),
    Column('package_id', Integer, nullable=False),
    Column('scanner_id', Integer, nullable=False),
    ForeignKeyConstraint(['package_id'], ['packages.package_id']),
    ForeignKeyConstraint(['scanner_id'], ['scanners.scanner_id']),
    UniqueConstraint('package_id', 'scanner_id', name='uc_package_scanner_id')
    )

files_scans = Table('files_scans', meta,
    Column('file_scan_id', Integer, primary_key=True),
    Column('file_id', Integer, nullable=False),
    Column('scanner_id', Integer, nullable=False),
    ForeignKeyConstraint(['file_id'], ['files.file_id']),
    ForeignKeyConstraint(['scanner_id'], ['scanners.scanner_id']),
    UniqueConstraint('file_id', 'scanner_id', name='uc_file_scanner_id')
    )


def create_connection(connection_string, echo):
    # because 'echo=False' is for some reason not allowed...
    if echo is True:
        return create_engine(connection_string, echo=True)
    else:
return create_engine(connection_string)
```

## Files that are stubbed out in your repository, with comments about the use cases they are connected to. These sections may not all exist for the Zephyr project teams. Simply explain them as best you can.

### User Interface Files

1. sprint1/View.py
	- Handles all of the user related use cases mentioned above in addition to several trivial aspects of the display (such as redirecting to a different page).


### Model Files (Database Access)

1. sprint1/Model.py
    - Handles all of the SQL queries and parses them into python objects.


### Controller Files (API or other)

1. sprint1/Controller.py
    - Handles all augur/dosocs2 requests

## Describe languages you need to use, and any gaps in skills on your team.

1. Python (+Flask)
    - Wrap dosocs2 in a flask server
		- Creating an Augur plugin
		- Working with the Augur API
		- [Flask tutorial with most of the Python we'll need](https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-i-hello-world)
		- [General Python tutorial](https://www.learnpython.org/en/Variables_and_Types)
2. PostgreSQL
    - Storing licensing information about various repositories
		- [Tutorial](http://www.postgresqltutorial.com/)
3. JavaScript
 		- Front-end development
		- [Tutorial](https://www.w3schools.com/js/DEFAULT.asp)
4. Who is doing what:
		- Luke: Wrapping dosocs in a Flask server / Augur plugin
		- Carter: PostgreSQL / Server
		- Paul: API / Augur plugin
