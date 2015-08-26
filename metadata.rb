name             'err'
maintainer       'Needle Inc.'
maintainer_email 'cookbooks@needle.com'
license          'Apache 2.0'
description      'Installs/Configures err pluggable chat bot'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.5.0'

depends 'git'
depends 'python'
depends 'supervisor'
