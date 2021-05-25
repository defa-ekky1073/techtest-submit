name 'techtest'
maintainer 'Ekky Defa Rizkyan'
maintainer_email 'defa.ekky1073@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures techtest'
version '0.1.8'
chef_version '>= 15.0'

depends 'docker', '~> 7.7.0'
depends 'jenkins', '~> 8.2.3'
depends 'java', '~> 8.6.0'
depends 'firewall', '~> 2.7.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/techtest/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/techtest'
