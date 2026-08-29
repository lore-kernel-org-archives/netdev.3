Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [37.187.220.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2B3F1058
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 03:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.187.220.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787973872; cv=none; b=O6y2f9j2meMzFJ41ZojsqvbJ8o/RC/SmxgNVSZedcEIR43V5SpCHwcVzfPlpH9/c2AdBiApgXw8y7H24PIvG2AAitk4idrpw+2UBXT6L22lgDgyj3Iyd5VOC0EE1dV19gD5AxuvQT+ugZTbGguG0FkB33+tWGSrP/atrlggoDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787973872; c=relaxed/simple;
	bh=Eu3iiDzR5GaNZrNiBCtSxczNS6XUw/Y719S76ewZB1E=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=H9mW3rrua7Ga4HSAjwBDUCyV5ualG82RLNohlpq6ACYWGrY06XCrz3gOQnwl2fIEhlkTP+lIBKUWL4I401orbHfwrq/QmDi17B219ZaUKZV4VMN/p6vR22SwfqZ0q4AoAxa36PgaYJ55EBJP2cd5IBchlCPz4LwUrwJp//hbZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=cTuBbniy; arc=none smtp.client-ip=37.187.220.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cTuBbniy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1787973853; x=1788233053;
	bh=Mx9wYZKZy59hgTIjGqPX4UsPmbseRooOnUQywvSw01U=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cTuBbniyifivKjb6LyysRi2hVDNQkEClPkddMW8cfzD2l0B5my6ly8O/4XXUsznT1
	 f//sUfe8BOdbUN3J/p6c1aUnmwHgZiBBt7BEEWaI7SU4erxaPSUf6vVtwz+IxeK5RU
	 8TiaIJWJa+MF/A6AXp7Ak3CR5VSrGzkc9XOU1CxNs2TW0uZRRIDn8k+3ybTCO7onJ9
	 Y3kT4zZQwfGoLtcRZF5kG75t42UTGtTrB/nAO3vqwUK9vJwrGoW8szU27bXYLyVAlc
	 ZtNriy/oEZAW3RbZIE9P9859C203qUqwS+1Fw1+V4aE6NMcRCcWk3uhrWFYK8wiqkh
	 Ezsd1SHSZm7og==
Date: Sat, 29 Aug 2026 03:24:08 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Notes on Installing LAMP stack with Ubuntu 26.04 LTS Linux Server
Message-ID: <MQxyzEVuM5ZAPaNFvPu3A2e7Ff_s9RbSR3IEsTOD0TPyaCqZyoStqymbTh0eRVd8tBLgvRyFmX93vy1v66Uh6Xn-PR8BEZBJ9W4fRzdLYKQ=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 7b68780e6fb1179fe5e27cd5a94581d679c6dbc8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Notes on Installing LAMP stack with Ubuntu 26.04 LTS Linux Server

Good day from Singapore,

Author: Mr. Turritopsis Dohrnii Teo En Ming
Date: 29 Aug 2026 Saturday
Country: Singapore

Download Ubuntu Server 26.04 LTS ISO.

In our example, we will be installing Ubuntu Server 26.04 LTS ISO as a virt=
ual machine in Windows Server 2025 Datacenter Evaluation Hyper-V Hypervisor=
.

Hyper-V Manager
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

New Virtual Machine Wizard

Before You Begin: click Next

Specify Name and Location:

Name: Service Record - Ubuntu
Click Store the virtual machine in a different location
Location: F:\Virtual Hard Disks\Service Record - Ubuntu
Click Next

Specify Generation: Click Generation 2. Click Next

Assign Memory: Startup memory: 8192 MB. Click Next

Configure Networking: Connection: Broadcom NetXtreme Gigabit Ethernet - Vir=
tual Switch. Click Next

Connect Virtual Hard Disk:

Click Create a virtual hard disk

Name: Service Record - Ubuntu.vhdx
Location: F:\Virtual Hard Disks\Service Record - Ubuntu\Service Record -Ubu=
...
Size: 2048 GB

Click Next

Installation Options:

Click Install an operating system from a bootable image file

Image file (.iso): C:\Users\Administrator\Documents\ubuntu-26.04-live-serve=
r-amd64.iso

Click Next

Summary: Click Finish

Power on the virtual machine.

If you encounter the following ERROR:

The signed image's hash is not allowed (DB)

Go to Secure Boot

Click Enable Secure Boot

Change the Template to: Microsoft UEFI Certificate Authority

Power on the virtual machine again.

Installing Ubuntu Server 26.04 LTS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

On the GNU GRUB page, select "Try or Install Ubuntu Server"

Welcome!: English

Keyboard configuration:

Layout: English (US)

Variant: English (US)

Choose the type of installation:

Click Ubuntu Server

Network configuration:

Choose Manual / Static

Enter the following:

Subnet:

Address:

Gateway:

Name Servers:

Search domains:

Proxy configuration: leave blank

Ubuntu archive mirror configuration:

Click Done

Guided storage configuration:

Click Use an entire disk

Uncheck Set up this disk as an LVM group

Storage configuration: Click Done

Confirm destructive action: Click Continue

Profile configuration:

Your name: Teo En Ming
Your servers name: servicerecord
Pick a username: teo-en-ming
Choose a password:
Confirm your password:

Upgrade to Ubuntu Pro: Click Skip for now

SSH configuration:

Click Install OpenSSH server

Click Allow password authentication over SSH

Click Done

Featured server snaps: Click Done

Installing system

Installation complete! Click Reboot Now

sudo nano /etc/ssh/sshd_config

Port 2222

Save and exit

sudo systemctl disable --now ssh.socket

sudo systemctl enable ssh.service

sudo systemctl restart ssh.service

netstat -anp | grep 22

You should see port 2222

Installing Apache Web Server
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

sudo apt install apache2

You should now be able to see your default HTTP web page.

sudo a2enmod ssl

sudo mkdir -p /etc/apache2/ssl

sudo openssl req -x509 -nodes -days 3650 \
  -newkey rsa:2048 \
  -keyout /etc/apache2/ssl/apache-selfsigned.key \
  -out /etc/apache2/ssl/apache-selfsigned.crt
 =20
sudo nano /etc/apache2/sites-available/selfsigned-ssl.conf

<VirtualHost *:443>
    ServerAdmin ceo@teo-en-ming-corp.com

    DocumentRoot /var/www/html

    SSLEngine on
    SSLCertificateFile /etc/apache2/ssl/apache-selfsigned.crt
    SSLCertificateKeyFile /etc/apache2/ssl/apache-selfsigned.key

    ErrorLog ${APACHE_LOG_DIR}/ssl-error.log
    CustomLog ${APACHE_LOG_DIR}/ssl-access.log combined
</VirtualHost>

sudo a2ensite selfsigned-ssl.conf

sudo apache2ctl configtest
Syntax OK

sudo systemctl reload apache2

You should now see your default HTTPS web page.

Installing MariaDB Database Server
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

sudo apt update

sudo apt install mariadb-server mariadb-client

sudo mariadb

CREATE USER 'mysqlroot'@'localhost'
IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON *.* TO
'mysqlroot'@'localhost'
WITH GRANT OPTION;

FLUSH PRIVILEGES;

EXIT

mariadb -u mysqlroot -p

Installing phpMyAdmin
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

sudo apt-get update

sudo apt install phpmyadmin=20

Web server to reconfigure automatically: apache2

Configure database for phpmyadmin with dbconfig-common? Yes

MySQL application password for phpmyadmin:=20

Password confirmation:=20

Password of the database's administrative user:

sudo apt install php-mysql

sudo systemctl restart apache2

sudo phpenmod mbstring

sudo systemctl restart apache2

sudo apt update && sudo apt install -y software-properties-common

Installing PHP 8.5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

sudo apt install -y php php-cli php-fpm

sudo apt install -y php-{curl,mbstring,xml,zip,mysql,intl}

sudo apt install libapache2-mod-php8.5

sudo a2enmod php8.5

sudo systemctl restart apache2

You should now be able to access phpMyAdmin at

https://IP_address/phpmyadmin/

Turning on Software Firewall in Ubuntu Server 26.04 LTS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

sudo ufw allow 2222/tcp

sudo ufw allow 443/tcp

sudo ufw enable

sudo ufw status

Miscellaneous
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

cat /etc/os-release

PRETTY_NAME=3D"Ubuntu 26.04 LTS"

That's all.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Diehard hardcore PAP government supporter
29 Aug 2026 Saturday 11.14 am Singapore Time











