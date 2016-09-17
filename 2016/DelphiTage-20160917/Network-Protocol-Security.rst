Network protocol security
#########################

.. # * = + ^ ~ - : . _ ` ' "

Im memoriam: Gwan Tan
*********************

`Im memoriam: Gwan Tan, friend, Delphi, Firebird, EKON and Delphi-Tage supporter <http://www.delphipraxis.net/189691-im-memoriam-gwan-tan-friend-delphi-firebird-ekon-delphi-tage-supporter.html>`_

.. image:: Portrait-Gwan-Tan.jpeg

how to use and test secure protocols
************************************

`Abstract <http://web.archive.org/web/20160909195410/http://www.delphitage.de/index.php/veranstaltung/sessionplan/>`_
=====================================================================================================================
Over time, there has been a trend towards better security including network protocols. Even though not everybody follows the trend, it’s important you do. This session explains various SSH and SSL/TLS based protocols and how to test their various security aspects. Then it shows a few alternatives for SFTP based clients in Delphi (as Indy does OK on the SSL/TLS side, but nothing on the SSH side). Finally you will see client side usage of SSL/TLS based protocols. There will also be some guidance on server based secure protocols.

Motive
======

I had two reasons for submitting this session:

- The overall feel that stil truckloads of software should use secure protocols
- The need for a more secure replacement of ``FTP``.

For the latter, ``SFTP`` seemed the dominant use, but there was a lot of confusion of what it is and how it can be used from Delphi.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Security
########

Security is hard to get right. What hels is to:

- do as little yourself and
- depend on up-to-date libraries and algorithms
- used by a large audience

Opinion on security changes over time, so be sure to be agile enough so you can adapt to change.

The consensus is that staying behind is bad which reminds me of the `internet explorer 6 days <https://www.google.com/search?q="internet+explorer+6+days">`_

Staying current is hard though.

Recent examples of opinion changing:

- `IoT kernels: good for 30 years of product lifetime without updates. <https://plus.google.com/+KristianK%C3%B6hntopp/posts/ZZbdsD6aGP7>`_
- `LTS is a disease that must be eradicated with extreme thoroughness. <https://plus.google.com/+MaikZumstrull/posts/YztsXcYoJ2b>`_
- `Backports and long-term stable kernels <https://lwn.net/SubscriberLink/700530/1efa5402d18f9ded/>`_

In that sense, part of the new `Windows 10 <https://en.wikipedia.org/wiki/Windows_10>`_ and `Windows Server 2016 <https://en.wikipedia.org/wiki/Windows_Server_2016>`_ release models might be a good move, though `they don't do a rolling release <https://www.reddit.com/r/linuxmasterrace/comments/4axaez/is_windows_10_a_rolling_release/>`_

They mix `Rolling release <https://en.wikipedia.org/wiki/Rolling_release>`_ (or more specifically `Rolling distribution <https://en.wikipedia.org/wiki/Rolling_distribution>`_) with larger updates (which are a pain to install on VHD boot installs).

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Secure protocols
################

Virtually all secure protocols are either SSL or SSH based.

SSL (now TLS) and SSH are totally different protocols.

Both use hashing and cypher algorithms. Do not use these weak hashing algorithms/settings:

- `MD5 <https://en.wikipedia.org/wiki/MD5>`_ - 1996 flaw in design found; 2012 Flame malware exploited MD5
- `SHA1 <https://en.wikipedia.org/wiki/SHA-1>`_ - 2015 estimate of cracking single key is 75K–120K US$
- `DES <https://en.wikipedia.org/wiki/Data_Encryption_Standard>`_ - keysize 56 bit
- `RC4 <https://en.wikipedia.org/wiki/RC4>`_ - 2013 statistical biases in RC4 key table
- `3DES <https://en.wikipedia.org/wiki/3DES>`_ - because of `SWEET32 collission attack <https://threatpost.com/new-collision-attacks-against-3des-blowfish-allow-for-cookie-decryption/120087/>`_
- `Blowfish <https://en.wikipedia.org/wiki/Blowfish_(cipher)>`_ - because of `SWEET32 collission attack <https://threatpost.com/new-collision-attacks-against-3des-blowfish-allow-for-cookie-decryption/120087/>`_
- anything with 1024 or less bits in key or hash
- pre-installed default/stock keys that come with your OS

Most of the issues there are with server-side configurations.

This means you have to

1. harden your install when it comes out of the box. Some ideas:
  - Linux side:
    - `My First 10 Minutes on a Server <https://news.ycombinator.com/item?id=11909543>`_
    - `SSH Server Configuration rhel-lockdown <http://people.redhat.com/swells/mea/SECSCAN-FirstRun/sshd_config.htm>`_
    - `Hardening your SSH server (opensshd_config) <http://wp.kjro.se/2013/09/06/hardening-your-ssh-server-opensshd_config/>`_
    - `http://kacper.blog.redpill-linpro.com/archives/702 <http://kacper.blog.redpill-linpro.com/archives/702>`_ from `gone/ssh at github · comotion/gone <https://github.com/comotion/gone/blob/github/modules/ssh>`_. Note that the ``sandbox`` value for ``UsePrivilegeSeparation`` is even `more secure <http://www.openbsd.org/cgi-bin/man.cgi/OpenBSD-current/man5/sshd_config.5?query=sshd_config&sec=5>`_
    - `Hardening Your Web Server’s SSL Ciphers — Hynek Schlawack <https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/>`_:
    - `Mozilla.org Security, Server Side TLS: Apache <https://wiki.mozilla.org/Security/Server_Side_TLS#Apache>`_
    - `weak Diffie-Hellman <https://weakdh.org/>`_ (see `Schneier on Security, Crypto-Gram, June 15, 2015, The Logjam (and Another) Vulnerability against Diffie-Hellman Key Exchange <https://www.schneier.com/crypto-gram/archives/2015/0615.html#1>`_).

  - Windows side:
    - `Hardening the Windows infrastructure <https://technet.microsoft.com/en-us/library/cc995076.aspx>`_
    - `Server Hardening: Windows Server 2012 <https://technet.microsoft.com/en-us/security/jj720323.aspx>`_
    - `Baseline Server Hardening <https://technet.microsoft.com/en-us/library/cc526440.aspx>`_

2. watch places like these to stay up-to-date:
  - OpenSuSE (which I use most)
    - https://openqa.opensuse.org/group_overview/1
    - https://www.suse.com/support/update/
    - https://www.suse.com/security/cve/
    - https://lwn.net/Alerts/openSUSE/

  - Others
    - https://access.redhat.com/security/security-updates/#/
    - http://www.ubuntu.com/usn/
    - https://www.freebsd.org/security/advisories.html
    - https://technet.microsoft.com/en-us/security/bulletins.aspx

Many security updates are based on CVE advisories: https://cve.mitre.org/compatible/alerts_announcements.html

`SSH <https://en.wikipedia.org/wiki/Secure_Shell>`_ = Secure SHell
******************************************************************

- to access `shell accounts <https://en.wikipedia.org/wiki/Shell_account>`_ mostly on `Unix-like <https://en.wikipedia.org/wiki/Unix-like>`_ operating systems and limited use to access `Windows <https://en.wikipedia.org/wiki/Microsoft_Windows>`_ systems (but since Windows 10 increasing)
- replacement of `Telnet <https://en.wikipedia.org/wiki/Telnet>`_ and for unsecured remote shell protocols such as the Berkeley rlogin, rsh, and rexec protocols
- `SSH-1 <https://en.wikipedia.org/wiki/Secure_Shell#Version_1.x>`_ protocol is obsolete and vulnerable. `SSH-2 <https://en.wikipedia.org/wiki/Secure_Shell#Version_2.x>`_ protocol is stable and secure.
- Uses are mainly for secure shell, port tunneling, VPN (when both sides are OpenSSH) and (our focus): file transfer protocols:
  - `SFTP <https://en.wikipedia.org/wiki/SSH_File_Transfer_Protocol>`_ (SSH File Transfer Protocl) - majority, especially from Widows point of view
  - `SCP <https://en.wikipedia.org/wiki/Secure_copy>`_ (SSH Copy Protocol) - mainly Unix-like to Unix-like
  - `rsync <https://en.wikipedia.org/wiki/Rsync>`_ (remote sync) - file syncing, mainly Unix-like to Unix-like

We'll focus on measuring security and using client-side connections here, so since Delphi: Windows tooling and SFTP.

Most `open source <https://en.wikipedia.org/wiki/Open-source_software>`_ Windows Clients for shell access are `PuTTY based <http://www.htpcbeginner.com/best-ssh-clients-windows-putty-alternatives/>`_ (majority) or `Cygwin <https://en.wikipedia.org/wiki/Cygwin>`_ (minority). Closed source clients are a small minority.

Cygwin is actually a Posix layer on top of Windows so it's very rich, but also tougher to install than a simple client installation, so many people prefer PuTTY like clients.

Windows Clients that supprt SFTP:

1. `Filezilla <https://filezilla-project.org/>`__ (as `Filezilla on Windows is waaaay faster than WinSCP <https://wiert.me/2016/10/21/filezilla-on-windows-is-waaaay-faster-than-winscp/>`__)
   which implements ``SFTP``, ``SCP`` and ``FTP`` on Windows and Mac OSX

2. `WinSCP <https://winscp.net/eng/index.php>`__ (a Windows ``SCP`` and ``SFTP``
   client written in C++ Builder)
3. `PSFTP <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp>`__
   (the `Putty <http://www.putty.org/>`__ ``SFTP`` client)

There have been few `SSH vulnerabilities <https://en.wikipedia.org/wiki/Secure_Shell#Vulnerabilities>`_.

`SSL (now TLS) <https://en.wikipedia.org/wiki/Transport_Layer_Security>`_ = Secure Sockets Layer or Transport Layer Security
****************************************************************************************************************************

- set of `cryptographic protocols <https://en.wikipedia.org/wiki/Cryptographic_protocol>`_ that provide `communications security <https://en.wikipedia.org/wiki/Communications_security>`_ over a `computer network <https://en.wikipedia.org/wiki/Computer_network>`_
- it's a transport protocol, not a shell protocol
- is supported by many tranport oriented connections like web, mail, news, file, directory, chat
- has many versions (SSL 1.0, 2.0 and 3.0, TLS 1.0, 1.1, 1.2 and 1.3 draft), algorithms and other settings which makes it hard to configure right
- ``SSL`` is now obsolete, but still in use; ``TLS`` shoul dbe used
- has many implementations of which `OpenSSL <https://en.wikipedia.org/wiki/OpenSSL>`_ is the most widely used and known
- this is even true on Windows, though Windows has built-in ``SChannel`` as part of `SSPI <https://en.wikipedia.org/wiki/Security_Support_Provider_Interface>`_ as well

Forms of authentication:

- client can authenticate server (most common usage scenario of https)
- servers can authenticate clients (both the client software as the client user)

Most vulnerabilities have to do with either:

- client and server software versions
- server configurations (as servers can limit what clients can use and choose the most secure common demnominator of both)

Since it's hard, people often choose to configure a `TLS termination Proxy <https://en.wikipedia.org/wiki/TLS_termination_proxy>`_:

 > one known good configuration on the outside decrypting TLS

- unencrypted to a known secure network on the inside
- reencrypted using interternal certificates to a network on the inside

This can be done by both commercial (like a `BIG-IP appliance <https://en.wikipedia.org/wiki/F5_Networks#BIG-IP>`_ from `F5 Networks <https://en.wikipedia.org/wiki/F5_Networks>`_) or open source (like `Apache <https://en.wikipedia.org/wiki/Apache_HTTP_Server>`_) solutions, for instance:

`partial.network-diagram.svg <partial.network-diagram.svg>`_ / `partial.network-diagram.plantuml <partial.network-diagram.plantuml>`_

.. image:: partial.network-diagram.svg

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Testing secure protocols
########################

Security is hard. You can fill more than a day discussing these test tools:

- https://nmap.org/nsedoc/categories/vuln.html
- https://github.com/PeterMosmans/security-scripts/blob/master/analyze_hosts.sh
- http://bitvijays.github.io/blog/2016/03/03/learning-from-the-field-basic-network-hygiene/

It's extremely hard to implement secure algorithms:

- getting the algorithms right is just step 1
- preventing `Side Channel Attacks <https://en.wikipedia.org/wiki/Side-channel_attack>`_ is an order of magnitude larger
- finding issues requires a large installed base

That's why I highly prefer open source cross platform based implementation with a tiny Delphi wrapper around it over a fully Delphi based library:

> The Delphi market is way too small to warrant a really secure library just writteen in the `Object Pascal language <https://en.wikipedia.org/wiki/Object_Pascal>`_

So we do some limited discussion here. If time permits we can dig deeper.

We use tools on Linux for most checking. Remote login to Linux from Windows is easy with https://the.earth.li/~sgtatham/putty/0.67/ via http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html

Testing TLS/SSL
===============

Testing TLS/SSL with testssl.sh
+++++++++++++++++++++++++++++++

You can it at https://testssl.sh/ (yes that *is* secure `https <https://en.wikipedia.org/wiki/HTTPS>`_).

The cool thing is that it supports any protocol using SSL/TLS:

- `https <https://en.wikipedia.org/wiki/HTTPS>`_ (web)
- `nntps <https://en.wikipedia.org/wiki/NNTPS>`_ (news)
- `smtps <https://en.wikipedia.org/wiki/SMTPS>`_ (mail)
- `ftps <https://en.wikipedia.org/wiki/FTPS>`_ (file transfer) aka FTPES, FTP-SSL, S-FTP (differnt from SFTP) and FTP Secure
- `pop3s <https://en.wikipedia.org/wiki/POP3S>`_ (mail)
- `imaps <https://en.wikipedia.org/wiki/IMAPS>`_ (mail)
- `xmpps <https://en.wikipedia.org/wiki/XMPP>`_ (chat)
- `telnets <https://en.wikipedia.org/wiki/Telnet>`_ (terminal) - hardly used, one implementation in Go: https://github.com/reiver/telnets
- `ldaps <https://en.wikipedia.org/wiki/LDAPS>`_ (directory)

I use ``testssl.sh`` on Mac OS X and Linux as `on Windows 10 with bash it is very slow <https://wiert.me/2016/08/08/testssl-sh-on-bashonwindows-ubuntu-from-win10-drwettertestssl-sh/>`_.

We will focus on https and nntps here.

Running the latest ``testssl.sh``::

  git clone https://github.com/drwetter/testssl.sh.git
  cd testssl.sh
  ./testssl.sh www.pluimers.com

- https://github.com/drwetter/testssl.sh is updated frequently; stay up to date with ``git pull`` in the directory where you clonde the repository.
- Like Dr.Bob (which stems from `Dr. GUI <https://www.google.nl/search?q="Dr.+Gui">`_) he is not a doctor at all: his first name is Dirk.


Need HTML output? Just pipe through "aha" (Ansi HTML Adapter: github.com/theZiz/aha) like::

  "testssl.sh <options> <URI> | aha >output.html"

``aha`` is "Ansi Html Adapter" for which the latest is ``Version 0.4.8.0`` on Mac OS X and ``Version 0.4.9.0`` on OpenSuSE::

  zypper addrepo http://download.opensuse.org/repositories/utilities/openSUSE_Factory/utilities.repo
  zypper refresh
  zypper install aha

Testing with aha::

  ./testssl.sh www.pluimers.com | tee /tmp/www.pluimers.com.ansi.txt
  aha -f /tmp/www.pluimers.com.ansi.txt > /tmp/www.pluimers.com.html
  open /tmp/www.pluimers.com.html

Or (eat your own dogfood)::

  ./testssl.sh testssl.sh | tee /tmp/testssl.sh.ansi.txt
  aha -f /tmp/testssl.sh.ansi.txt > /tmp/testssl.sh.html
  open /tmp/testssl.sh.html

A script like this makes it easier::

  testssl.sh-host()
  {
    pushd /tmp/
    ~/Versioned/testssl.sh/testssl.sh $1 | tee $1.ansi.txt
    aha -f $1.ansi.txt > $1.html
    open $1.html
    popd
  }

Embarcadero is notiously bad at TLS security, so this helps testing them::

  alias testssl-embarcadero='for host in {{,members,qc,tp,quality,community,forums,edn,store,www}.embarcadero.com,forums.embarcadero.com:563}; do echo $host && testssl.sh-host $host || echo; done'

You can also test on-line: https://www.ssllabs.com/ssltest/analyze.html?d=quality.embarcadero.com

`Recently <https://gist.github.com/3f85ffcd6cfa7ac8adfc088f2ad14c8b>`_ they've `become better <https://rawgit.com/jpluimers/3f85ffcd6cfa7ac8adfc088f2ad14c8b/raw/c534e477f6f457bbf55cb4315a409a70e262938f/__index.html>`_, but in the past they scored grade F which is about as good as plain text.


Testing TLS/SSL with nmap
+++++++++++++++++++++++++

nmap testing requiring nmap >= 7.01::

  nmap -p 443 -d --script ssl-ccs-injection --script-args vulns.showall example.com

via http://security.stackexchange.com/questions/82426/nmap-says-variable-keys-is-not-declared-when-trying-to-run-ssl-ccs-injection

There are many of these scrips, see the list below.

  Most can benefit from the ``-sV`` parameter to use Nmap's service scan to detect SSL/TLS on non-standard ports. Otherwise, most will only run on ports that are commonly used for SSL.

========================================================================  = ======
URL                                                                       * Example usage
========================================================================  = ======
https://nmap.org/nsedoc/scripts/ssl-ccs-injection.html                    * ``nmap -p 443 --script ssl-ccs-injection <target>``
https://nmap.org/nsedoc/scripts/ssl-cert.html                               ``nmap -sV -sC <target>`` (add ``-v`` or ``-v -v`` to make output larger)
https://nmap.org/nsedoc/scripts/ssl-date.html                               ``nmap <target> --script=ssl-date``
https://nmap.org/nsedoc/scripts/ssl-dh-params.html                        * ``nmap --script ssl-dh-params <target>``
https://nmap.org/nsedoc/scripts/ssl-enum-ciphers.html                       ``nmap --script ssl-enum-ciphers -p 443 <host>``
https://nmap.org/nsedoc/scripts/ssl-google-cert-catalog.html                ``nmap -p 443 --script ssl-cert,ssl-google-cert-catalog <host>``
https://nmap.org/nsedoc/scripts/ssl-heartbleed.html                       * ``nmap -p 443 --script ssl-heartbleed <target>``
https://nmap.org/nsedoc/scripts/ssl-known-key.html                          ``nmap --script ssl-known-key -p 443 <host>``
https://nmap.org/nsedoc/scripts/ssl-poodle.html                           * ``nmap -sV --version-light --script ssl-poodle -p 443 <host>``
https://nmap.org/nsedoc/scripts/sslv2.html                                  ``nmap -sV -sC <target>``
https://nmap.org/nsedoc/scripts/sslv2-drown.html                          * ``nmap -sV --script=sslv2-drown <target>``
https://nmap.org/nsedoc/scripts/sstp-discover.html                          ``nmap -sV -sC <target>``
========================================================================  = ======

For the ones marked ``*``, you can add the ``--script-args vulns.showall`` parameter when needed:

  ``vulns.showall``: https://nmap.org/nsedoc/lib/vulns.html#script-args

  If set, the library will show and report all the registered vulnerabilities which includes the ``NOT VULNERABLE`` ones. By default the library will only report the ``VULNERABLE`` entries: ``VULNERABLE``, ``LIKELY VULNERABLE``, ``VULNERABLE (DoS)`` and ``VULNERABLE (Exploitable)``.

Testing SSH with nmap
=====================

Since SSH is different from TLS, `instead of using testssl.sh <https://github.com/drwetter/testssl.sh/issues/458>`_ you should use ``nmap``: https://nmap.org/nsedoc/scripts/ssh2-enum-algos.html

========================================================================  = ======
URL                                                                       * Example usage
========================================================================  = ======
https://nmap.org/nsedoc/scripts/ssh-hostkey.html                            ``nmap host --script ssh-hostkey --script-args ssh_hostkey=all``
https://nmap.org/nsedoc/scripts/ssh2-enum-algos.html                        ``nmap --script ssh2-enum-algos target``
https://nmap.org/nsedoc/scripts/sshv1.html                                  ``nmap -sV -sC <target>``
========================================================================  = ======

The criteria for ``ssh2-enum-algos`` are these:

  - The ``diffie-hellman-group1-sha1`` must not appear. It only has 1024 bit.
  - The ``diffie-hellman-group14-sha1`` must appear as it is 2048 bit.
  - The ``curve25519-sha256`` must appear
  - The ``diffie-hellman-group-exchange-sha256`` appear

To be even more secure, you should:

  - Have ``curve25519-sha256`` appear
  - Have ``diffie-hellman-group-exchange-sha256`` appear
  - Have these not appear:
    - NIST algorithms ``ecdh-sha2-nistp256``, ``ecdh-sha2-nistp384``, ``ecdh-sha2-nistp521``
    - SHA1 algorithms ``diffie-hellman-group1-sha1``, ``diffie-hellman-group14-sha1``, ``diffie-hellman-group-exchange-sha1``

  Then regenerate the sha256 based key using 4096 bits.

See these for the back-ground info:

- https://stribika.github.io/2015/01/04/secure-secure-shell.html
- http://security.stackexchange.com/questions/92642/logjam-hardening-openssh-and-testing-it
- http://security.stackexchange.com/questions/89689/what-is-logjam-and-how-do-i-prevent-it
- https://weakdh.org/sysadmin.html

Though they suggest running this script (where ``172.16.172.134`` is the target)::

  $ nmap --script ssh2-enum-algos 172.16.172.134

  Starting Nmap 6.47 ( http://nmap.org ) at 2016-09-09 15:53 CEST
  Note: Host seems down. If it is really up, but blocking our ping probes, try -Pn
  Nmap done: 1 IP address (0 hosts up) scanned in 3.04 seconds

it's better to add the ``-Pn`` parameter::

  $ nmap -Pn --script ssh2-enum-algos 172.16.172.134

  Starting Nmap 6.47 ( http://nmap.org ) at 2016-09-09 15:53 CEST
  Nmap scan report for 172.16.172.134
  Host is up (0.00028s latency).
  Not shown: 999 filtered ports
  PORT   STATE SERVICE
  22/tcp open  ssh
  | ssh2-enum-algos:
  |   kex_algorithms: (6)
  |       curve25519-sha256@libssh.org
  |       ecdh-sha2-nistp256
  |       ecdh-sha2-nistp384
  |       ecdh-sha2-nistp521
  |       diffie-hellman-group-exchange-sha256
  |       diffie-hellman-group14-sha1
  |   server_host_key_algorithms: (6)
  |       ssh-rsa
  |       rsa-sha2-512
  |       rsa-sha2-256
  |       ssh-dss
  |       ecdsa-sha2-nistp256
  |       ssh-ed25519
  |   encryption_algorithms: (6)
  |       chacha20-poly1305@openssh.com
  |       aes128-ctr
  |       aes192-ctr
  |       aes256-ctr
  |       aes128-gcm@openssh.com
  |       aes256-gcm@openssh.com
  |   mac_algorithms: (10)
  |       umac-64-etm@openssh.com
  |       umac-128-etm@openssh.com
  |       hmac-sha2-256-etm@openssh.com
  |       hmac-sha2-512-etm@openssh.com
  |       hmac-sha1-etm@openssh.com
  |       umac-64@openssh.com
  |       umac-128@openssh.com
  |       hmac-sha2-256
  |       hmac-sha2-512
  |       hmac-sha1
  |   compression_algorithms: (2)
  |       none
  |_      zlib@openssh.com

  Nmap done: 1 IP address (1 host up) scanned in 8.16 seconds

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SFTP
####

``SFTP`` is totally unlike ``FTP``.

SFTP means `SSH File Transfer
Protocol <https://en.wikipedia.org/wiki/SSH_File_Transfer_Protocol>`__,
not `Simple File Transfer
Protocol <https://en.wikipedia.org/wiki/File_Transfer_Protocol#Simple_File_Transfer_Protocol>`__
nor `FTP over
SSH <https://en.wikipedia.org/wiki/File_Transfer_Protocol#FTP_over_SSH>`__ nor
`FTP over SSL aka FTPS <https://en.wikipedia.org/wiki/FTPS>`__.

Client side SFTP from Delphi
****************************

``FTPS`` latter `\*is\* supported by
Indy <http://www.indyproject.org/kb/index.html?howdoiuseftpwithssl.htm>`__ but
`the former
isn't <http://web.archive.org/web/20160726090156/https://forums.embarcadero.com/message.jspa?messageID=661000#661000>`__.

The `consensus seemed <http://stackoverflow.com/questions/4235714/ftp-over-ssh-sftp-in-delphi-2010>`__ that there `were no good <http://stackoverflow.com/questions/7236240/sftp-client-with-source-for-ipv6>`_ open source implmentations for Delphi SFTP but only commercial implementations.

On the commercial ones:

I decided against `SecureBlackBox <https://www.eldos.com/sbb>`_ (providing `SFTPBlackbox <https://www.eldos.com/sbb/desc-sftp.php>`__) and IP\*Works' (`SSH <https://www.nsoftware.com/ipworks/ssh/>`__) as:

-  I tried both a while ago for `S/MIME <https://en.wikipedia.org/wiki/S/MIME>`_ support and was disappointed about both the lack of features and documentation; in the end I went for wrapping
`OpenSSL <https://en.wikipedia.org/wiki/OpenSSL>`_ for the "encrypt-then-sign" process and Indy for the SSMTP part.
- The `acquisition of SecureBlackBox by /n software <https://www.nsoftware.com/company/press/pr084.rst>`_ made me even less happy: those usually tend to stall things for a while.

The `Chilkat alternative for SFTP <https://www.example-code.com/delphi/sftp.asp>`__ isn't too compelling either:

- ActiveX or DLL black-box
- without a lot of insight on how many people do use it

There is a http://synapse.ararat.cz/files/contrib/sftp.zip from 2006 but that put me off for two reasons:

- No Delphi Unicode support
- This depressing remark::

  //  Not tested carefully but directory listing and file transfer seems to work.
  //  Requires cl32.dll (CryptLib) and Synapse 37b6 or newer !!!
  //  If somebody knows how to extract file type information from file attributes
  //  packet (I'm not sure that code in TSimpleSFTP.ParseFileNamePacket will work
  //  in any case) then please let know to Sergey Gagarin (serg@screens.ru)

Then I found https://bitbucket.org/ZeljkoMarjanovic/libssh2-delphi which had `commits from mid-2010 to early 2013 <https://bitbucket.org/ZeljkoMarjanovic/libssh2-delphi/commits/all>`_

It's a Delphi wrapper around the OK C library ``libssh2``. Later I will review ``libssh`` versus ``libssh2``; for now it works quite well and ``libssh2`` gets frequent updates.

I also considered thinking outside the Delphi realm by embedding either of these:

#. `Filezilla <https://filezilla-project.org/>`__ (as `Filezilla on Windows is waaaay faster than WinSCP <https://wiert.me/2016/10/21/filezilla-on-windows-is-waaaay-faster-than-winscp/>`__)
#. `WinSCP <https://winscp.net/eng/index.php>`__ (a Windows SCP and SFTP client written in C++ Builder)
#. `PSFTP <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp>`__ (the `Putty <http://www.putty.org/>`__ SFTP client)

So lets dig into to client side tools first.

SFTP compatible Windows client side tools
*****************************************

The below list has to reasons:

- Tooling you can use to test SFTP connections using a GUI
- Potential tools to wrap in a different way than ``libssh2-delphi``

Incidentally all below tools are open source.

The clients
===========

FileZilla
+++++++++

`FileZilla internally uses FzSFtp.exe which is based on PSFTP code <http://serverfault.com/questions/700780/why-is-filezilla-so-much-faster-than-psftp/700882#700882>`__ (but with some buffers making it faster than PSFTP or WinSCP). According to the author, neither FzSFtp.exe nor FileZilla can be automated:

But:

  FileZilla cannot make any automated transfers at all. Neither FileZilla.exe nor fzsftp.exe (is for SFTP) can be used for any batch processing. Source: `run filezilla tzsftp from batch command line - FileZilla Forums <https://forum.filezilla-project.org/viewtopic.php?t=28200>`__

The WinSCP author commented in a similar fashion:

  FileZilla does not have any command line arguments (nor any other way) that allow automatic transfer. Source: `windows - Command line option to download file in FileZilla - Stack Overflow <http://stackoverflow.com/questions/28022567/command-line-option-to-download-file-in-filezilla/28023319>`__

In addition, FileZilla is always a GUI program, so running it as a console app (which I'd prefer) or even in a service would be impossible.

WinSCP
++++++

WinSCP can be automated in two ways:

#. The `WinSCP.exe command-line <https://winscp.net/eng/docs/commandline>`__ allows for `a /console and /script switch <https://winscp.net/eng/docs/commandline#scripting>`__
   enabling scripting mode that you can use for `Scripting and Task Automation :: WinSCP <https://winscp.net/eng/docs/scripting>`__

   -  For console-only operations `using WinSCP.com is preferred <https://winscp.net/eng/docs/executables>`__ as it has no GUI (so the ``/console`` switch is implicit)
   -  There are many example scripts at \ `Useful Scripts :: WinSCP <http://winscp.net/eng/docs/scripts>`__
   -  It is easy to switch from PSFTP or SFTP: \ `Converting PuTTY PSFTP or OpenSSH SFTP script to WinSCP script :: WinSCP <https://winscp.net/eng/docs/guide_psftp_script_to_winscp#commandline>`__

#. A wrapper around WinSCP.exe is availble as \ `WinSCP .NET Assembly and COM Library :: WinSCP <https://winscp.net/eng/docs/library>`__ which requires both .NET to be installed and (from Delphi) calling through COM which I don't like much

Since I already have good Delphi wrapping code round starting/waiting-for running processes, I might opt for using WinSCP.com scripting. There used to be wrapping code around it: `Use with Delphi :: Support Forum :: WinSCP <https://winscp.net/forum/viewtopic.php?t=8153>`__

PSFTP
+++++

These `Using PSFTP to transfer files securely <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp>`__ links should get me going if I want to try it:

- `Chapter 6: Using PSFTP to transfer files securely <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp>`__

  -  `6.1 Starting PSFTP <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-starting>`__
       -  `6.1.1 -b: specify a file containing batch commands <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-option-b>`__
       -  `6.1.2 -bc: display batch commands as they are run <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-option-bc>`__
       -  `6.1.3 -be: continue batch processing on errors <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-option-be>`__
       -  `6.1.4 -batch: avoid interactive prompts <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-usage-options-batch>`__

  -  `6.2 Running PSFTP <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-commands>`__
       -  `6.2.1 General quoting rules for PSFTP commands <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-quoting>`__
       -  `6.2.2 Wildcards in PSFTP <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-wildcards>`__
       -  `6.2.3 The open command: start a session <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-open>`__
       -  `6.2.4 The quit command: end your session <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-quit>`__
       -  `6.2.5 The close command: close your connection <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-close>`__
       -  `6.2.6 The help command: get quick online help <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-help>`__
       -  `6.2.7 The cd and pwd commands: changing the remote working directory <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-cd>`__
       -  `6.2.8 The lcd and lpwd commands: changing the local working directory <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-lcd>`__
       -  `6.2.9 The get command: fetch a file from the server <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-get>`__
       -  `6.2.10 The put command: send a file to the server <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-put>`__
       -  `6.2.11 The mget and mput commands: fetch or send multiple files <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-mgetput>`__
       -  `6.2.12 The reget and reput commands: resuming file transfers <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-regetput>`__
       -  `6.2.13 The dir command: list remote files <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-dir>`__
       -  `6.2.14 The chmod command: change permissions on remote files <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-chmod>`__
       -  `6.2.15 The del command: delete remote files <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-del>`__
       -  `6.2.16 The mkdir command: create remote directories <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-mkdir>`__
       -  `6.2.17 The rmdir command: remove remote directories <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-rmdir>`__
       -  `6.2.18 The mv command: move and rename remote files <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-mv>`__
       -  `6.2.19 The ! command: run a local Windows command <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-cmd-pling>`__

  -  `6.3 Using public key authentication with PSFTP <http://the.earth.li/~sgtatham/putty/0.67/htmldoc/Chapter6.html#psftp-pubkey>`__

Practical examples:

-  `cmd - Batch file for PuTTY/PSFTP file transfer automation - Stack Overflow <http://stackoverflow.com/questions/16439039/batch-file-for-putty-psftp-file-transfer-automation/16440468>`__
-  `Delphi SFTP mit Indy - Seite 2 - Delphi-PRAXiS <http://www.delphipraxis.net/67911-sftp-mit-indy-2.html>`__
-  `PuTTY plink wrapper in Delphi <http://www.delphipraxis.net/70989-komponente-fuer-ssh-verbindung.html>`__

The open source locations
=========================

-  FileZilla SVN repository: https://svn.filezilla-project.org/svn/FileZilla3
-  WinSCP does not have a repository; you can download ZIP files with source code for each release from https://winscp.net/eng/download.php
-  Putty Git repository: \ http://tartarus.org/~simon-git/gitweb/?p=putty.git

Client side SFTP from Delphi continued
**************************************

libssh2-delphi
==============

The original repo is at https://bitbucket.org/ZeljkoMarjanovic/libssh2-delphi

Some pending features that I want to get merged are at https://bitbucket.org/jpluimers/libssh2-delphi

It three parts:

1. Import libraries for the (32-bit) ``libssh2.dll`` from the https://github.com/libssh2/libssh2 project
2. An ``TSFTPClient`` component that wraps these libraries (and some ofhter classes like an SSH client)
3. A fully fledged Delphi GUI application for testing which is:
    - nice as it shows all features
    - touch as most code is in the form

So I wrote a smaller SFTP upload example so it is easier to focus on some basics in the https://bitbucket.org/jeroenp/besharp.net repository at `feature/Build SFTP example for DelphiTage/EKON. <https://bitbucket.org/jeroenp/besharp.net/branch/feature/Build%20SFTP%20example%20for%20DelphiTage/EKON.>`_

Let's dig into that and the GUI now...

libssh2 building
================

Since ``libssh2-delphi`` requires a Win32 (x86) ``libssh2.dll` I needed to build one.

So I asked this on the ``#libsshs`` IRC channel::

  [10:15am] <wiert> Hi.
  [10:15am] <wiert> Are there any guidelines to build libssh2 for Win32?
  [10:16am] <wiert> I’m trying to resurrect the https://bitbucket.org/ZeljkoMarjanovic/libssh2-delphi wrapper around it and update it to the most recent libssh2 dll.
  [10:17am] <wiert> A list of prereqs (tools, libraries, etc) would be nice.
  [10:19am] <wiert> https://github.com/libssh2/libssh2/blob/master/win32/GNUmakefile is a bit “intimidating” for a first starter.
  [10:20am] <wiert> I don’t mind making a pull request of a markdown/reStructuredText file containing detailed build instructions, so if anyone can provide me with a few starting hints that would be great.
  [10:23am] <wiert> I’ve Windows VMs with various RAD Studio versions (that contain C++ Builder) or Visual Studio versions, but my C/C++ knowledge is a bit rusty (from like 20 years ago).
  [10:23am] <wiert> I don’t mind learning though (:
  [1:05pm] <wiert> I was offline for a while (and will be offline in an hour or so for a while as well), did anyone have some hints on building libssh2 for Win32?
  [1:11pm] <Bert> wiert: Shouldn't be too hard to build.. Just setup CMake and things should work. (Tested with several VS versions)
  [1:18pm] <Bert> wiert: Too keep things easy I would recommend sticking with an OpenSSL pre 1.1.0 for a bit... 1.1.0 breaks quite a few projects, so I would wait for one more release, to allow other projects to fix their link/compile issues.
  [1:19pm] <Bert> Not sure if you need OpenSSL though... depends on your config (and if you still want to support XP/2003)

2 days later and a lot of cursing I came up with a script that - for brevity - is at https://gist.github.com/jpluimers/2bf514d658488a7ddfc189b0677a3a57

Basic steps for now (I'm not happy at all on how to get rid of `VCRUNTIME140.DLL`):

1. Install Visual Studio 2015 community edition from https://www.visualstudio.com/en-us/downloads/download-visual-studio-vs.aspx (as of writing: http://download.microsoft.com/download/D/2/3/D23F4D0F-BA2D-4600-8725-6CCECEA05196/vs_community_ENU.exe or http://download.microsoft.com/download/b/e/d/bedddfc4-55f4-4748-90a8-ffe38a40e89f/vs2015.3.com_enu.iso )
2. Download CMake via https://cmake.org/download/ back then https://cmake.org/files/v3.6/cmake-3.6.2-win64-x64.msi
3. Install and ensure to `add CMake to the PATH for all users <https://www.dropbox.com/s/ss5xke97iy4yyka/Screenshot%202016-09-13%2009.36.54.png?dl=0>`_
4. Run the script from the gist on the command-line

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Q&A
###

This is your chance (:

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

TODO
####

No work finishes without some of ideas of stuff that still needs to be done (:

SSH testing
***********

Try https://github.com/GDSSecurity/SSH-Weak-DH which is explained at http://blog.gdssecurity.com/labs/2015/8/3/ssh-weak-diffie-hellman-group-identification-tool.html and reached via http://security.stackexchange.com/questions/92642/logjam-hardening-openssh-and-testing-it

Some semi-random Delphi SSL related posts
*****************************************

During the search above I found the below links that will be useful to
me one day:

-  `Send mail to GMail using Indy and SSL/TLS SMTP <http://www.marcocantu.com/tips/oct06_gmail.html>`__
-  `FTPS <https://en.wikipedia.org/wiki/FTPS>`__ (FTP over TLS/SSL): \ `[Delphi] - INDY + IDFTP + SSL/TLS :: 4programmers.net <http://forum.4programmers.net/Delphi_Pascal/141070-Delphi_-_INDY_+_IDFTP_+_SSLTLS>`__
-  `Delphi Indy Samples & Articles - Delphi <http://www.ciuly.com/index.php/delphi/indy>`__

   -  `Indy SSL Yahoo send email example (2) <http://www.ciuly.com/delphi/indy/indy-ssl-yahoo-send-email-example-2/>`__
   -  `Login into googles blogger using SSL <http://www.ciuly.com/delphi/indy/login-into-googles-blogger-using-ssl/>`__
   -  `Persistent login example using SSL and sending email for Yahoo <http://www.ciuly.com/delphi/indy/persistent-login-example-using-ssl-and-sending-email-for-yahoo/>`__
   -  `Persistent login example using SSL for EBAY <http://www.ciuly.com/delphi/indy/persistent-login-example-using-ssl-for-ebay/>`__
   -  `Indy SSL persistent login for uniqueauction.com <http://www.ciuly.com/delphi/indy/indy-ssl-persistent-login-for-uniqueauction-com/>`__

-  `Indy SSL <http://www.indyproject.org/Sockets/SSL.en.aspx>`__
-  `libssh2 <https://libssh2.org/>`__ Delphi wrapper: \ `ZeljkoMarjanovic / libssh2 delphi — Bitbucket <https://bitbucket.org/ZeljkoMarjanovic/libssh2-delphi>`__ (unmaintained since 2013-01-02)
-  WinSCP wrapper in the wayback machine: `SeySo Software & Service - Projects <http://web.archive.org/web/20160329165723/http://seyso.de/projects_e/projects_en.php>`__
