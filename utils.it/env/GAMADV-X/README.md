GAMADV-X
========
GAMADV-X is a free, open source command line tool for Google G Suite Administrators to manage domain and user settings quickly and easily.

GAMADV-X is a rewrite/extension of Jay Lee's [GAM](https://github.com/jay0lee/GAM), without his efforts, this version wouldn't exist.

Documentation
-------------
General GAM documentation is hosted in the [GitHub Wiki]. Documentation specifically for GAMADV-X is hosted in the [GitHub GAMADV-X Wiki] and in Gam*.txt files.

Downloads
---------
You can download the current GAMADV-X release from the [GitHub Releases] page. Choose one of the following:

* Single Executable, Linux/Mac OS - `gamadv-x-4.wx.yz-linux-x86_64.xz, gamadv-x-4.wx.yz-macos.tar.xz`
  - Download the archive, extract the contents into some directory.
  - Start a terminal session and cd to the install directory.

* Single Executable Archive, Windows - `gamadv-x-4.wx.yz-windows-x64.zip, gamadv-x-4.wx.yz-windows.zip`
  - Download the archive, extract the contents into some directory.
  - Start a terminal session and cd to the install directory.

* Single Executable Installer, Windows - `gamadv-x-4.wx.yz-windows-x64.msi`
  - Download the installer and run it.
  - Start a Command Prompt/PowerShell session and cd to the install directory.

* Source, all platforms - Source code(zip), Source code(tar.gz)
  - Download the archive, extract the contents into some directory.
  - Start a terminal/Command Prompt/PowerShell session and cd to the install directory.

Installation - New Users
------------------------
Read GamConfig.txt.

Enter the following gam commands and follow instructions to create the necessary authorizations.
- Build gam.cfg: ```gam config verify```
- Build GAM Project for authorization: ```gam create project```
- Authorize Gam Client: ```gam oauth create```
- Authorize Service Account: ```gam user <email address> check serviceaccount```

Installation - Upgrading from a GAM version other than a prior version of GAMADV-X
----------------------------------------------------------------------------------
Read GamConfig.txt.

## Linux/Mac OS

This example assumes that GAMADV-X has beem installed in /usr/local/gamadv-x.
Set environment variable OLDGAMPATH to point to the existing Gam directory; /usr/local/gam will be used in this example.
```
admin@server:/usr/local/gamadv-x$ export OLDGAMPATH=/usr/local/gam
```
Verify that OLDGAMPATH points to the correct location.
```
admin@server:/usr/local/gamadv-x$ ls -l $OLDGAMPATH/*.json
-rw-r-----@ 1 admin  staff   553 Feb 26 10:39 /usr/local/gam/client_secrets.json
-rw-r-----@ 1 admin  staff  2377 Feb 26 10:39 /usr/local/gam/oauth2service.json
admin@server:/usr/local/gamadv-x$ 
```
Initialize GAMADV-X; this should be the first GAMADV-X command executed.
```
admin@server:/usr/local/gamadv-x$ ./gam config verify
Created: /Users/admin/.gam
Created: /Users/admin/.gam/gamcache
Copied: /usr/local/gam/oauth2service.json, To: /Users/admin/.gam/oauth2service.json
Copied: /usr/local/gam/oauth2.txt, To: /Users/admin/.gam/oauth2.txt
Copied: /usr/local/gam/client_secrets.json, To: /Users/admin/.gam/client_secrets.json
Config File: /Users/admin/.gam/gam.cfg, Initialized
Section: DEFAULT
  activity_max_results = 100
  auto_batch_min = 0
  batch_size = 50
  cache_dir = /Users/admin/.gam/gamcache
  cache_discovery_only = true
  charset = utf-8
  classroom_max_results = 0
  client_secrets_json = client_secrets.json ; /Users/admin/.gam/client_secrets.json
  config_dir = /Users/admin/.gam
  contact_max_results = 100
  csv_input_column_delimiter = ,
  csv_output_column_delimiter = ,
  csv_output_convert_cr_nl = false
  csv_output_field_delimiter = ' '
  customer_id = my_customer
  debug_level = 0
  device_max_results = 500
  domain = ''
  drive_dir = /Users/admin/Downloads
  drive_max_results = 1000
  email_batch_size = 100
  extra_args = ''
  member_max_results = 200
  message_batch_size = 1000
  message_max_results = 1000
  no_browser = false
  no_cache = false
  no_update_check = false
  no_verify_ssl = false
  num_threads = 25
  oauth2_txt = oauth2.txt ; /Users/admin/.gam/oauth2.txt
  oauth2service_json = oauth2service.json ; /Users/admin/.gam/oauth2service.json
  section = ''
  show_convert_cr_nl = false
  show_counts_min = 1
  show_gettings = true
  show_multiprocess_info = false
  timezone = utc
  todrive_conversion = true
  todrive_parent = root
  todrive_timestamp = false
  todrive_user = ''
  user_max_results = 500
admin@server:/usr/local/gamadv-x$ 
```
Verify initialization, this was a successful installation.
```
admin@server:/usr/local/gamadv-x$ ls -l ~/.gam
total 48
-rw-r-----+ 1 admin  staff   553 Mar  3 09:23 client_secrets.json
-rw-r-----+ 1 admin  staff  1069 Mar  3 09:23 gam.cfg
drwxr-x---+ 2 admin  staff    68 Mar  3 09:23 gamcache
-rw-r-----+ 1 admin  staff    10 Mar  3 09:23 lastupdatecheck.txt
-rw-r-----+ 1 admin  staff  5104 Mar  3 09:23 oauth2.txt
-rw-rw-rw-+ 1 admin  staff     0 Mar  3 09:23 oauth2.txt.lock
-rw-r-----+ 1 admin  staff  2377 Mar  3 09:23 oauth2service.json
admin@server:/usr/local/gamadv-x$ 
```
If the verification looks like this, then you'll have to copy client_secrets.json and oauth2service.json manually.
```
admin@server:/usr/local/gamadv-x$ ls -l ~/.gam
total 40
-rw-r-----+  1 admin  admin  1427 Nov  1 11:38 gam.cfg
drwxr-x---+ 16 admin  admin   544 Nov  2 07:25 gamcache
-rw-r--r--+  1 admin  admin    10 Nov  2 15:31 lastupdatecheck.txt
-rw-rw-rw-+  1 admin  admin     0 Sep 19 17:28 oauth2.txt.lock

admin@server:/usr/local/gamadv-x$ cp -p $OLDGAMPATH/client_secrets.json ~/.gam/
admin@server:/usr/local/gamadv-x$ cp -p $OLDGAMPATH/oauth2service.json ~/.gam/
admin@server:/usr/local/gamadv-x$ ls -l ~/.gam
total 40
-rw-r-----+ 1 admin  staff   553 Mar  3 09:23 client_secrets.json
-rw-r-----+ 1 admin  staff  1069 Mar  3 09:23 gam.cfg
drwxr-x---+ 2 admin  staff    68 Mar  3 09:23 gamcache
-rw-r-----+ 1 admin  staff    10 Mar  3 09:23 lastupdatecheck.txt
-rw-r-----+ 1 admin  staff  5104 Mar  3 09:23 oauth2.txt
-rw-rw-rw-+ 1 admin  staff     0 Mar  3 09:23 oauth2.txt.lock
-rw-r-----+ 1 admin  staff  2377 Mar  3 09:23 oauth2service.json
```
Enable GAMADV-X client access, create oauth2.txt; it must be deleted and recreated because it is in a different format than in basic Gam.
```
admin@server:/usr/local/gamadv-x$ rm -f ~/.gam/oauth2.txt
admin@server:/usr/local/gamadv-x$ ./gam version
WARNING: Config File: /Users/admin/.gam/gam.cfg, Section: DEFAULT, Item: oauth2_txt, Value: /Users/admin/.gam/oauth2.txt, Not Found
GAM 4.44.02 - https://github.com/taers232c/GAMADV-X
Ross Scroggs <ross.scroggs@gmail.com>
Python 2.7.13 64-bit final
google-api-python-client 1.6.1
Darwin-15.6.0-x86_64-i386-64bit x86_64
Path: /usr/local/gamadv-x

admin@server:/usr/local/gamadv-x$ ./gam oauth create

What is your G Suite admin email address?admin@domain.com

Select the authorized scopes by entering a number.
Append an 'r' to grant read-only access or an 'a' to grant action-only access.

[*]  0)  Admin Settings API
[*]  1)  Admin User - Email upload report document notifications
[*]  2)  Admin User - Manage report documents in Google Drive
[*]  3)  Calendar Data API (supports readonly)
[*]  4)  Classroom API - Courses (supports readonly)
[*]  5)  Classroom API - Student Guardians (supports readonly)
[*]  6)  Classroom API - Profile Emails
[*]  7)  Classroom API - Profile Photos
[*]  8)  Classroom API - Rosters (supports readonly)
[*]  9)  Cloudprint API
[*] 10)  Contacts API - Domain Shared and Users and GAL
[*] 11)  Data Transfer API (supports readonly)
[*] 12)  Directory API - Chrome OS Devices (supports readonly)
[*] 13)  Directory API - Customers (supports readonly)
[*] 14)  Directory API - Domains (supports readonly)
[*] 15)  Directory API - Groups (supports readonly)
[*] 16)  Directory API - Mobile Devices Directory (supports readonly and action)
[*] 17)  Directory API - Notifications
[*] 18)  Directory API - Organizational Units (supports readonly)
[*] 19)  Directory API - Resource Calendars (supports readonly)
[*] 20)  Directory API - Roles (supports readonly)
[*] 21)  Directory API - User Schemas (supports readonly)
[*] 22)  Directory API - User Security
[*] 23)  Directory API - Users (supports readonly)
[*] 24)  Email Audit API
[*] 25)  Email Settings API - Users
[*] 26)  Groups Migration API
[*] 27)  Groups Settings API
[*] 28)  License Manager API
[*] 29)  Reports API - Audit Reports
[*] 30)  Reports API - Usage Reports
[ ] 31)  Reseller API
[*] 32)  Site Verification API
[*] 33)  Sites API

     s)  Select all scopes
     u)  Unselect all scopes
     e)  Exit without changes
     c)  Continue to authorization
Please enter 0-33[a|r] or s|u|e|c: c

Your browser has been opened to visit:

    https://goo.gl/01234

If your browser is on a different machine then press CTRL+C,
set no_browser = true in gam.cfg and re-run this command.

Authentication successful.

Your browser has been opened to visit:

    https://goo.gl/56789

If your browser is on a different machine then press CTRL+C,
set no_browser = true in gam.cfg and re-run this command.

Authentication successful.
Client OAuth2 File: /Users/admin/.gam/oauth2.txt, Created
```
Gam service account access must be enabled.
```
admin@server:/usr/local/gamadv-x$ ./gam user testuser1@domain.com check serviceaccount
User: testuser1@domain.com, Check 12 Scopes
  Scope: https://mail.google.com/                                    , Checked: PASS (1/12)
  Scope: https://sites.google.com/feeds                              , Checked: FAIL (2/12)
  Scope: https://www.google.com/m8/feeds                             , Checked: FAIL (3/12)
  Scope: https://www.googleapis.com/auth/activity                    , Checked: PASS (4/12)
  Scope: https://www.googleapis.com/auth/calendar                    , Checked: PASS (5/12)
  Scope: https://www.googleapis.com/auth/drive                       , Checked: PASS (6/12)
  Scope: https://www.googleapis.com/auth/gmail.settings.basic        , Checked: PASS (7/12)
  Scope: https://www.googleapis.com/auth/gmail.settings.sharing      , Checked: FAIL (8/12)
  Scope: https://www.googleapis.com/auth/plus.login                  , Checked: PASS (9/12)
  Scope: https://www.googleapis.com/auth/plus.me                     , Checked: PASS (10/12)
  Scope: https://www.googleapis.com/auth/userinfo.email              , Checked: PASS (11/12)
  Scope: https://www.googleapis.com/auth/userinfo.profile            , Checked: PASS (12/12)

ERROR: Some scopes failed! Please go to:

https://admin.google.com/domain.com/AdminHome?#OGX:ManageOauthClients

and grant Service Account Client name:

SVCACCTID

Access to scopes:

https://mail.google.com/,
https://sites.google.com/feeds,
https://www.google.com/m8/feeds,
https://www.googleapis.com/auth/activity,
https://www.googleapis.com/auth/calendar,
https://www.googleapis.com/auth/drive,
https://www.googleapis.com/auth/gmail.settings.basic,
https://www.googleapis.com/auth/gmail.settings.sharing,
https://www.googleapis.com/auth/plus.login,
https://www.googleapis.com/auth/plus.me,
https://www.googleapis.com/auth/userinfo.email,
https://www.googleapis.com/auth/userinfo.profile
```
The link shown in the error message should take you directly to the authorization screen.
If not, in the Admin console, click `Security`, click `Show more`, click `Advanced settings`, click `Manage API client access`.
Paste SVCACCTID in the `Client Name` box and the complete list of scopes in the `One or More API Scopes` box, click `Authorize`.
Wait a moment and then perform the following command; it it still fails, wait a bit longer, it can sometimes take serveral minutes
for the authorization to complete.
```
admin@server:/usr/local/gamadv-x$ ./gam user testuser1@domain.com check serviceaccount
User: testuser1@domain.com, Check 12 Scopes
  Scope: https://mail.google.com/                                    , Checked: PASS (1/12)
  Scope: https://sites.google.com/feeds                              , Checked: PASS (2/12)
  Scope: https://www.google.com/m8/feeds                             , Checked: PASS (3/12)
  Scope: https://www.googleapis.com/auth/activity                    , Checked: PASS (4/12)
  Scope: https://www.googleapis.com/auth/calendar                    , Checked: PASS (5/12)
  Scope: https://www.googleapis.com/auth/drive                       , Checked: PASS (6/12)
  Scope: https://www.googleapis.com/auth/gmail.settings.basic        , Checked: PASS (7/12)
  Scope: https://www.googleapis.com/auth/gmail.settings.sharing      , Checked: PASS (8/12)
  Scope: https://www.googleapis.com/auth/plus.login                  , Checked: PASS (9/12)
  Scope: https://www.googleapis.com/auth/plus.me                     , Checked: PASS (10/12)
  Scope: https://www.googleapis.com/auth/userinfo.email              , Checked: PASS (11/12)
  Scope: https://www.googleapis.com/auth/userinfo.profile            , Checked: PASS (12/12)

All scopes passed!
Service Account Client name SVCACCTID is fully authorized.
```
Update gam.cfg to have your customer_id and domain.
```
admin@server:/usr/local/gamadv-x$ ./gam info domain
Customer ID: C01234567
Primary Domain: domain.com
Customer Creation Time: 2007-06-06T15:47:55.444Z
Primary Domain Verified: True
Default Language: en
...

admin@server:/usr/local/gamadv-x$ ./gam config customer_id C01234567 domain domain.com save verify
Config File: /Users/admin/.gam/gam.cfg, Saved
Section: DEFAULT
  activity_max_results = 100
  auto_batch_min = 0
  batch_size = 50
  cache_dir = /Users/admin/.gam/gamcache
  cache_discovery_only = true
  charset = mbcs
  classroom_max_results = 0
  client_secrets_json = client_secrets.json ; /Users/admin/.gam/client_secrets.json
  config_dir = /Users/admin/.gam
  contact_max_results = 100
  csv_input_column_delimiter = ,
  csv_output_column_delimiter = ,
  csv_output_convert_cr_nl = false
  csv_output_field_delimiter = ' '
  customer_id = C01234567
  debug_level = 0
  device_max_results = 500
  domain = domain.com
  drive_dir = /Users/admin/Downloads
  drive_max_results = 1000
  email_batch_size = 100
  extra_args = ''
  member_max_results = 200
  message_batch_size = 1000
  message_max_results = 1000
  no_browser = false
  no_cache = false
  no_update_check = false
  no_verify_ssl = false
  num_threads = 25
  oauth2_txt = oauth2.txt ; /Users/admin/.gam/oauth2.txt
  oauth2service_json = oauth2service.json ; /Users/admin/.gam/oauth2service.json
  section = ''
  show_convert_cr_nl = false
  show_counts_min = 1
  show_gettings = true
  show_multiprocess_info = false
  timezone = utc
  todrive_conversion = true
  todrive_parent = root
  todrive_timestamp = false
  todrive_user = ''
  user_max_results = 500

admin@server:/usr/local/gamadv-x$ 
```

## Windows

This example assumes that GAMADV-X has beem installed in C:\GAMADV-X.
Set environment variable OLDGAMPATH to point to the existing Gam directory; C:\GAM will be used in this example.
```
C:\GAMADV-X>set OLDGAMPATH=C:\GAM
```
Verify that OLDGAMPATH points to the correct location.
```
C:\GAMADV-X>dir %OLDGAMPATH%\*.json
 Volume in drive C has no label.
 Volume Serial Number is 663F-DA8B

 Directory of C:\GAM

02/26/2017  10:39 AM               553 client_secrets.json
02/12/2017  09:22 AM            10,133 cloudprint-v2.json
02/12/2017  09:22 AM             3,448 email-settings-v2.json
02/26/2017  10:39 AM             2,377 oauth2service.json
               4 File(s)         16,511 bytes
               0 Dir(s)  434,214,162,432 bytes free
```
Initialize GAMADV-X; this should be the first GAMADV-X command executed.
```
C:\GAMADV-X>gam config verify
Created: C:\Users\Administrator.DOMAIN\.gam
Created: C:\Users\Administrator.DOMAIN\.gam\gamcache
Copied: C:\GAM\oauth2service.json, To: C:\Users\Administrator.DOMAIN\.gam\oauth2service.json
Copied: C:\GAM\oauth2.txt, To: C:\Users\administrator.DOMAIN\.gam\oauth2.txt
Copied: C:\GAM\client_secrets.json, To: C:\Users\Administrator.DOMAIN\.gam\client_secrets.json
Config File: C:\Users\Administrator.DOMAIN\.gam\gam.cfg, Initialized
Section: DEFAULT
  activity_max_results = 100
  auto_batch_min = 0
  batch_size = 50
  cache_dir = C:\Users\Administrator.DOMAIN\.gam\gamcache
  cache_discovery_only = true
  charset = mbcs
  classroom_max_results = 0
  client_secrets_json = client_secrets.json ; C:\Users\Administrator.DOMAIN\.gam\client_secrets.json
  config_dir = C:\Users\Administrator.DOMAIN\.gam
  contact_max_results = 100
  csv_input_column_delimiter = ,
  csv_output_column_delimiter = ,
  csv_output_convert_cr_nl = false
  csv_output_field_delimiter = ' '
  customer_id = my_customer
  debug_level = 0
  device_max_results = 500
  domain = ''
  drive_dir = C:\Users\Administrator.DOMAIN\Downloads
  drive_max_results = 1000
  email_batch_size = 100
  extra_args = ''
  member_max_results = 200
  message_batch_size = 1000
  message_max_results = 1000
  no_browser = false
  no_cache = false
  no_update_check = false
  no_verify_ssl = false
  num_threads = 25
  oauth2_txt = oauth2.txt ; C:\Users\Administrator.DOMAIN\.gam\oauth2.txt
  oauth2service_json = oauth2service.json ; C:\Users\Administrator.DOMAIN\.gam\oauth2service.json
  section = ''
  show_convert_cr_nl = false
  show_counts_min = 1
  show_gettings = true
  show_multiprocess_info = false
  timezone = utc
  todrive_conversion = true
  todrive_parent = root
  todrive_timestamp = false
  todrive_user = ''
  user_max_results = 500
```
Verify initialization, this was a successful installation.
```
C:\GAMADV-X>dir %HOMEPATH%\.gam
 Volume in drive C has no label.
 Volume Serial Number is 663F-DA8B

 Directory of c:\Users\Administrator.DOMAIN\.gam

03/03/2017  10:16 AM    <DIR>          .
03/03/2017  10:16 AM    <DIR>          ..
03/03/2017  10:15 AM               553 client_secrets.json
03/03/2017  10:15 AM             1,125 gam.cfg
03/03/2017  10:15 AM    <DIR>          gamcache
03/03/2017  10:16 AM                10 lastupdatecheck.txt
03/03/2017  10:15 AM            11,704 oauth2.txt
03/03/2017  10:15 AM                 0 oauth2.txt.lock
03/03/2017  10:15 AM             2,377 oauth2service.json
               6 File(s)         15,769 bytes
               3 Dir(s)  110,532,562,944 bytes free
C:\GAMADV-X>
```
If the verification looks like this, then you'll have to copy client_secrets.json and oauth2service.json manually.
```
C:\GAMADV-X>dir %HOMEPATH%\.gam
 Volume in drive C has no label.
 Volume Serial Number is 663F-DA8B

 Directory of c:\Users\Administrator.DOMAIN\.gam

03/03/2017  10:19 AM    <DIR>          .
03/03/2017  10:19 AM    <DIR>          ..
03/03/2017  10:15 AM             1,125 gam.cfg
03/03/2017  10:15 AM    <DIR>          gamcache
03/03/2017  10:16 AM                10 lastupdatecheck.txt
03/03/2017  10:15 AM                 0 oauth2.txt.lock
               3 File(s)          1,135 bytes
               3 Dir(s)  110,532,562,944 bytes free

C:\GAMADV-X>copy %OLDGAMPATH%\client_secrets.json %HOMEPATH%\.gam\
        1 file(s) copied.

C:\GAMADV-X>copy %OLDGAMPATH%\oauth2service.json %HOMEPATH%\.gam\
        1 file(s) copied.

C:\GAMADV-X>dir %HOMEPATH%\.gam
 Volume in drive C has no label.
 Volume Serial Number is 663F-DA8B

 Directory of c:\Users\Administrator.DOMAIN\.gam

03/03/2017  10:20 AM    <DIR>          .
03/03/2017  10:20 AM    <DIR>          ..
02/26/2017  10:39 AM               553 client_secrets.json
03/03/2017  10:15 AM             1,125 gam.cfg
03/03/2017  10:15 AM    <DIR>          gamcache
03/03/2017  10:16 AM                10 lastupdatecheck.txt
03/03/2017  10:15 AM                 0 oauth2.txt.lock
02/26/2017  10:39 AM             2,377 oauth2service.json
               5 File(s)          4,065 bytes
               3 Dir(s)  110,532,538,368 bytes free
```
Enable GAMADV-X client access, create oauth2.txt; it must be deleted and recreated because it is in a different format than in basic Gam.
```
C:\GAMADV-X>del %HOMEPATH%\.gam\oauth2.txt
C:\GAMADV-X>gam version
WARNING: Config File: C:\Users\Administrator.DOMAIN\.gam\gam.cfg, Section: DEFAULT, Item: oauth2_txt, Value: C:\Users\Administrator.DOMAIN\.gam\oauth2.txt, Not Found
GAM 4.44.02 - https://github.com/taers232c/GAMADV-X
Ross Scroggs <ross.scroggs@gmail.com>
Python 2.7.13 64-bit final
google-api-python-client 1.6.1
Windows-10-10.0.14393 AMD64
Path: C:\GAMADV-X

C:\GAMADV-X>gam oauth create

What is your G Suite admin email address?admin@domain.com

Select the authorized scopes by entering a number.
Append an 'r' to grant read-only access or an 'a' to grant action-only access.

[*]  0)  Admin Settings API
[*]  1)  Admin User - Email upload report document notifications
[*]  2)  Admin User - Manage report documents in Google Drive
[*]  3)  Calendar Data API (supports readonly)
[*]  4)  Classroom API - Courses (supports readonly)
[*]  5)  Classroom API - Student Guardians (supports readonly)
[*]  6)  Classroom API - Profile Emails
[*]  7)  Classroom API - Profile Photos
[*]  8)  Classroom API - Rosters (supports readonly)
[*]  9)  Cloudprint API
[*] 10)  Contacts API - Domain Shared and Users and GAL
[*] 11)  Data Transfer API (supports readonly)
[*] 12)  Directory API - Chrome OS Devices (supports readonly)
[*] 13)  Directory API - Customers (supports readonly)
[*] 14)  Directory API - Domains (supports readonly)
[*] 15)  Directory API - Groups (supports readonly)
[*] 16)  Directory API - Mobile Devices Directory (supports readonly and action)
[*] 17)  Directory API - Notifications
[*] 18)  Directory API - Organizational Units (supports readonly)
[*] 19)  Directory API - Resource Calendars (supports readonly)
[*] 20)  Directory API - Roles (supports readonly)
[*] 21)  Directory API - User Schemas (supports readonly)
[*] 22)  Directory API - User Security
[*] 23)  Directory API - Users (supports readonly)
[*] 24)  Email Audit API
[*] 25)  Email Settings API - Users
[*] 26)  Groups Migration API
[*] 27)  Groups Settings API
[*] 28)  License Manager API
[*] 29)  Reports API - Audit Reports
[*] 30)  Reports API - Usage Reports
[ ] 31)  Reseller API
[*] 32)  Site Verification API
[*] 33)  Sites API

     s)  Select all scopes
     u)  Unselect all scopes
     e)  Exit without changes
     c)  Continue to authorization
Please enter 0-33[a|r] or s|u|e|c: c

Your browser has been opened to visit:

    https://goo.gl/01234

If your browser is on a different machine then press CTRL+C,
set no_browser = true in gam.cfg and re-run this command.

Authentication successful.

Your browser has been opened to visit:

    https://goo.gl/56789

If your browser is on a different machine then press CTRL+C,
set no_browser = true in gam.cfg and re-run this command.

Authentication successful.
Client OAuth2 File: C:\Users\Administrator.DOMAIN\.gam\oauth2.txt, Created
```
Gam service account access must be enabled.
```
C:\GAMADV-X>gam user testuser1@domain.com check serviceaccount
User: testuser1@domain.com, Check 12 Scopes
  Scope: https://mail.google.com/                                    , Checked: PASS (1/12)
  Scope: https://sites.google.com/feeds                              , Checked: FAIL (2/12)
  Scope: https://www.google.com/m8/feeds                             , Checked: FAIL (3/12)
  Scope: https://www.googleapis.com/auth/activity                    , Checked: PASS (4/12)
  Scope: https://www.googleapis.com/auth/calendar                    , Checked: PASS (5/12)
  Scope: https://www.googleapis.com/auth/drive                       , Checked: PASS (6/12)
  Scope: https://www.googleapis.com/auth/gmail.settings.basic        , Checked: PASS (7/12)
  Scope: https://www.googleapis.com/auth/gmail.settings.sharing      , Checked: FAIL (8/12)
  Scope: https://www.googleapis.com/auth/plus.login                  , Checked: PASS (9/12)
  Scope: https://www.googleapis.com/auth/plus.me                     , Checked: PASS (10/12)
  Scope: https://www.googleapis.com/auth/userinfo.email              , Checked: PASS (11/12)
  Scope: https://www.googleapis.com/auth/userinfo.profile            , Checked: PASS (12/12)

ERROR: Some scopes failed! Please go to:

https://admin.google.com/domain.com/AdminHome?#OGX:ManageOauthClients

and grant Service Account Client name:

SVCACCTID

Access to scopes:

https://mail.google.com/,
https://sites.google.com/feeds,
https://www.google.com/m8/feeds,
https://www.googleapis.com/auth/activity,
https://www.googleapis.com/auth/calendar,
https://www.googleapis.com/auth/drive,
https://www.googleapis.com/auth/gmail.settings.basic,
https://www.googleapis.com/auth/gmail.settings.sharing,
https://www.googleapis.com/auth/plus.login,
https://www.googleapis.com/auth/plus.me,
https://www.googleapis.com/auth/userinfo.email,
https://www.googleapis.com/auth/userinfo.profile
```
The link shown in the error message should take you directly to the authorization screen.
If not, in the Admin console, click `Security`, click `Show more`, click `Advanced settings`, click `Manage API client access`.
Paste SVCACCTID in the `Client Name` box and the complete list of scopes in the `One or More API Scopes` box, click `Authorize`.
Wait a moment and then perform the following command; it it still fails, wait a bit longer, it can sometimes take serveral minutes
for the authorization to complete.
```
C:\GAMADV-X>gam user testuser1@domain.com check serviceaccount
User: testuser1@domain.com, Check 12 Scopes
  Scope: https://mail.google.com/                                    , Checked: PASS (1/12)
  Scope: https://sites.google.com/feeds                              , Checked: PASS (2/12)
  Scope: https://www.google.com/m8/feeds                             , Checked: PASS (3/12)
  Scope: https://www.googleapis.com/auth/activity                    , Checked: PASS (4/12)
  Scope: https://www.googleapis.com/auth/calendar                    , Checked: PASS (5/12)
  Scope: https://www.googleapis.com/auth/drive                       , Checked: PASS (6/12)
  Scope: https://www.googleapis.com/auth/gmail.settings.basic        , Checked: PASS (7/12)
  Scope: https://www.googleapis.com/auth/gmail.settings.sharing      , Checked: PASS (8/12)
  Scope: https://www.googleapis.com/auth/plus.login                  , Checked: PASS (9/12)
  Scope: https://www.googleapis.com/auth/plus.me                     , Checked: PASS (10/12)
  Scope: https://www.googleapis.com/auth/userinfo.email              , Checked: PASS (11/12)
  Scope: https://www.googleapis.com/auth/userinfo.profile            , Checked: PASS (12/12)

All scopes passed!
Service Account Client name SVCACCTID is fully authorized.
```
Update gam.cfg to have your customer_id and domain.
```
C:\GAMADV-X>gam info domain
Customer ID: C01234567
Primary Domain: domain.com
Customer Creation Time: 2007-06-06T15:47:55.444Z
Primary Domain Verified: True
Default Language: en
...

C:\GAMADV-X>gam config customer_id C01234567 domain domain.com save verify
Config File: C:\Users\Administrator.DOMAIN\.gam\gam.cfg, Saved
Section: DEFAULT
  activity_max_results = 100
  auto_batch_min = 0
  batch_size = 50
  cache_dir = C:\Users\Administrator.DOMAIN\.gam\gamcache
  cache_discovery_only = true
  charset = mbcs
  classroom_max_results = 0
  client_secrets_json = client_secrets.json ; C:\Users\Administrator.DOMAIN\.gam\client_secrets.json
  config_dir = C:\Users\Administrator.DOMAIN\.gam
  contact_max_results = 100
  csv_input_column_delimiter = ,
  csv_output_column_delimiter = ,
  csv_output_convert_cr_nl = false
  csv_output_field_delimiter = ' '
  customer_id = C01234567
  debug_level = 0
  device_max_results = 500
  domain = domain.com
  drive_dir = C:\Users\Administrator.DOMAIN\Downloads
  drive_max_results = 1000
  email_batch_size = 100
  extra_args = ''
  member_max_results = 200
  message_batch_size = 1000
  message_max_results = 1000
  no_browser = false
  no_cache = false
  no_update_check = false
  no_verify_ssl = false
  num_threads = 25
  oauth2_txt = oauth2.txt ; C:\Users\Administrator.DOMAIN\.gam\oauth2.txt
  oauth2service_json = oauth2service.json ; C:\Users\Administrator.DOMAIN\.gam\oauth2service.json
  section = ''
  show_convert_cr_nl = false
  show_counts_min = 1
  show_gettings = true
  show_multiprocess_info = false
  timezone = utc
  todrive_conversion = true
  todrive_parent = root
  todrive_timestamp = false
  todrive_user = ''
  user_max_results = 500

C:\GAMADV-X>
```

Installation - Upgrading from a prior version of GAMADV-X
---------------------------------------------------------
Read GamUpdate.txt

Mailing List / Discussion group
-------------------------------
The GAM mailing list / discussion group is hosted on [Google Groups].  You can join the list and interact via email, or just post from the web itself.

Source Repository
-----------------
The official GAMADV-X source repository is on [GitHub] in the master branch.

Author
------
GAMADV-X is maintained by <a href="mailto:ross.scroggs@gmail.com">Ross Scroggs</a>.

[GitHub Releases]: https://github.com/taers232c/GAMADV-X/releases
[GitHub]: https://github.com/taers232c/GAMADV-X/tree/master
[GitHub Wiki]: https://github.com/jay0lee/GAM/wiki/
[GitHub GAMADV-X Wiki]: https://github.com/taers232c/GAMADV-X/wiki/
[Google Groups]: http://groups.google.com/group/google-apps-manager
