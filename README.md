mi-owncloud
===========

Owncloud Private Storage Server. Setup with Postgres, Nginx, opcache and tuned for Owncloud

* Nginx
* PostgreSQL 9.3
* Memcached
* Opcache
* Recommended Ram: 512MB

Note: Remember to disable the appstore in your owncloud config.php as leaving it enabled will slow down your app screen to a crawl. The command below is provided for your convenience if you have not already run it.

    sed -i "5i 'appstoreenabled' => false," /opt/local/www/owncloud/config/config.php

### Bookmarks Tag filtering fix
There is a bug with the Owncloud bookmark app used with PostgreSQL. The bug reults in tagged bookmarks not filtering when clicked. A simple fix is to patch 3 lines of code in:

[Commit / Fix](https://github.com/owncloud/bookmarks/commit/793733479a4669bdc49b7ba57a605551f03d7929 "Tag Filtering Fix")
