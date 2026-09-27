Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999C319B3CB
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 03:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790478419; cv=none; b=XyzgYBOcsXMnrUaJkzc8SXDOA7+089Z7fylzaChVAdOlPaaqftfkVFiUEV6R4Bue/C6CKrFpIo0c8Y1qzVSOmvRGz/GNCIJJZkfV7gUlW3wR3WvtvJNxg4XWejj7knjq9v3Zjp7sAULhIQ7R7hfRHaSMdNeUTa2ZZOSeWsrTBL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790478419; c=relaxed/simple;
	bh=z5xsdwlYmTTWdJH5POMdkRyVmVIfsQ21S8bMs4AiH2k=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=R88qBfQXZQuudr5efcQslxynWBzT/7gfz/nbQEZlVZu2xoUBr3rPs+tWWFMFqKJweTsZetIFx1xYa8fKV5p4UBKw8mUHEpq4YEslJeWvStWh6tXVwNHA5Vk/9kG46AfGuadeqSbv+eQUZk937XnzUmc5bA7Q3t1pbsqbbXEMjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=rMFRP67Z; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="rMFRP67Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1790478408; x=1790737608;
	bh=Z2rTHNmpANHQ3QQtzML9meWtfXy7dja6/vhA0B7aLtw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rMFRP67ZU36gI1/qnXhfxPpjKEKUsDgrqQ4pCBJLIG0pJqPnTSrhMp3lUteDRdMdP
	 Y1YkIgQoAx7C1mk3L/eHjl/cICQZskqbMoWN2CM2h5d7esAAKYikQrzKyQuLbb2ek5
	 T1f4gvAFWFT1E2u4lMeZLL+DEXel3Dbl1G3E02iSGbfezzkx4tVuYyiDOppmNCKa1i
	 3kRl3uhPKGnEeKgWC+EGFY1TLtyK6qltZTuPZz9yw2b4H7jkvllWojEd0bbWFK7Pf9
	 sZ0T2q3/Sgztt4Npr038pvdwjx/DjwbRoBSWTzz8IFXBIOklgh+xKjKJWcNSkWCOAh
	 KcmjAHXIBRyGQ==
Date: Sun, 27 Sep 2026 03:06:42 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Notes on How to Install Coraza Web Application Firewall (WAF) + OWASP CRS on Debian 13.7.0 Linux Server
Message-ID: <yqxeDm9kL1GLsZWM0v8J0Hpn6x2MsqxwFiUmjvlzGIJ-eRiqA19xrbIwpIQxEqIUTPN3B-Ap26_4odDUYzlWj6NCBgjlwgb5kH6zl2RCWEY=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: b14108e778ce7968ce7c06757630d1aa93932651
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Notes on How to Install Coraza Web Application Firewall (WAF) + OW=
ASP CRS on Debian 13.7.0 Linux Server

Good day from Singapore,

Author: Mr. Turritopsis Dohrnii Teo En Ming
Date: 27 Sep 2026 Sunday 12.47 AM
Country: Singapore

Install Debian 13.7.0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

nano /etc/apt/sources.list

#deb cdrom:[Debian GNU/Linux 13.7.0 _Trixie_ - Official amd64 DVD Binary-1 =
with firmware 20260912-09:36]/ trixie contrib main non-free-firmware

apt update

apt full-upgrade -y

apt install -y curl wget git ca-certificates gnupg unzip tar jq

reboot

cat /etc/os-release

Test connectivity to your existing HTTPS server
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

curl -vk https://192.168.88.8 # (This is a VMware ESXi 8.0 Update 3e Server=
)

Install Go
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

apt install -y golang-go

go version

Then install xcaddy:

GOBIN=3D/usr/local/bin go install github.com/caddyserver/xcaddy/cmd/xcaddy@=
latest

xcaddy version

Build Caddy with Coraza
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

mkdir -p /usr/local/src/caddy-coraza
cd /usr/local/src/caddy-coraza

xcaddy build --with github.com/corazawaf/coraza-caddy/v2

./caddy version

./caddy list-modules | grep -i waf

install -m 755 ./caddy /usr/bin/caddy

/usr/bin/caddy version

Create Caddy user/directories
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

groupadd --system caddy 2>/dev/null || true
useradd --system \
  --gid caddy \
  --create-home \
  --home-dir /var/lib/caddy \
  --shell /usr/sbin/nologin \
  caddy 2>/dev/null || true
 =20
 =20
mkdir -p /etc/caddy
mkdir -p /etc/coraza
mkdir -p /etc/coraza/crs
mkdir -p /var/log/caddy
mkdir -p /var/log/coraza


chown -R root:caddy /etc/caddy
chown -R root:caddy /etc/coraza
chown -R caddy:caddy /var/log/caddy
chown -R caddy:caddy /var/log/coraza

chmod 750 /etc/caddy
chmod 750 /etc/coraza

Download OWASP Core Rule Set
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

cd /opt

git clone https://github.com/coreruleset/coreruleset.git coreruleset

cd /opt/coreruleset
git status

Install the CRS files
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

cp -a /opt/coreruleset/. /etc/coraza/crs/

ls -la /etc/coraza/crs

ls -la /etc/coraza/crs/rules | head -30

chown -R root:caddy /etc/coraza

find /etc/coraza -type d -exec chmod 750 {} \;
find /etc/coraza -type f -exec chmod 640 {} \;

Create Coraza base configuration
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

nano /etc/coraza/coraza.conf

SecRuleEngine DetectionOnly

SecRequestBodyAccess On
SecResponseBodyAccess Off

SecRequestBodyLimit 13107200
SecRequestBodyNoFilesLimit 131072

SecAuditEngine RelevantOnly
SecAuditLogParts ABIJDEFHZ
SecAuditLogType Serial
SecAuditLog /var/log/coraza/audit.log

Configure CRS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

cp /etc/coraza/crs/crs-setup.conf.example \
   /etc/coraza/crs/crs-setup.conf
  =20
Configure Caddy + Coraza
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

nano /etc/caddy/Caddyfile

{
    order coraza_waf first
}

https://192.168.88.7 {

    coraza_waf {
        directives `
            Include /etc/coraza/coraza.conf
            Include /etc/coraza/crs/crs-setup.conf
            Include /etc/coraza/crs/rules/*.conf
        `
    }

    reverse_proxy https://192.168.88.8 {
        transport http {
            tls
            tls_insecure_skip_verify
        }
    }

    log {
        output file /var/log/caddy/access.log
    }
}

***NOTICE: Please note that 192.168.88.7 is the Coraza WAF and 192.168.88.8=
 is the HTTPS web server it is protecting.***

Better solution: trust the self-signed certificate
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

openssl s_client \
  -connect 192.168.88.8:443 \
  -showcerts </dev/null
 =20
nano /etc/coraza/backend.crt

-----BEGIN CERTIFICATE-----
---snipped---
-----END CERTIFICATE-----


chmod 644 /etc/coraza/backend.crt

Validate Caddy configuration
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

caddy validate \
  --config /etc/caddy/Caddyfile \
  --adapter caddyfile
 =20
Create systemd service
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

nano /etc/systemd/system/caddy.service

[Unit]
Description=3DCaddy with Coraza WAF
Documentation=3Dhttps://caddyserver.com/
After=3Dnetwork-online.target
Wants=3Dnetwork-online.target

[Service]
Type=3Dnotify
User=3Dcaddy
Group=3Dcaddy

ExecStart=3D/usr/bin/caddy run \
  --environ \
  --config /etc/caddy/Caddyfile

ExecReload=3D/usr/bin/caddy reload \
  --config /etc/caddy/Caddyfile \
  --force

TimeoutStopSec=3D5s
LimitNOFILE=3D1048576
PrivateTmp=3Dtrue
ProtectSystem=3Dfull

AmbientCapabilities=3DCAP_NET_ADMIN CAP_NET_BIND_SERVICE
CapabilityBoundingSet=3DCAP_NET_ADMIN CAP_NET_BIND_SERVICE

[Install]
WantedBy=3Dmulti-user.target


chown -R root:caddy /etc/coraza

find /etc/coraza -type d -exec chmod 750 {} \;
find /etc/coraza -type f -exec chmod 640 {} \;


mkdir -p /var/log/caddy
chown -R caddy:caddy /var/log/caddy
chmod 750 /var/log/caddy

chown caddy:caddy /var/log/caddy/access.log
chmod 640 /var/log/caddy/access.log

mkdir -p /var/log/coraza
chown -R caddy:caddy /var/log/coraza
chmod 750 /var/log/coraza

chown caddy:caddy /var/log/coraza/audit.log
chmod 640 /var/log/coraza/audit.log

systemctl daemon-reload
systemctl enable caddy
systemctl start caddy

systemctl status caddy --no-pager -l

journalctl -u caddy -n 100 --no-pager

Confirm ports
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ss -lntp | grep -E ':80|:443'

LISTEN 0      4096               *:443             *:*    users:(("caddy",p=
id=3D11197,fd=3D7))
LISTEN 0      4096               *:80              *:*    users:(("caddy",p=
id=3D11197,fd=3D9))

Test normal website traffic
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Open https://192.168.88.7 (Coraza WAF) in a Google Chrome web browser.

The site should work normally.

Then watch Coraza/Caddy:

journalctl -u caddy -f

tail -f /var/log/coraza/audit.log

Test SQL injection detection
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

While still in:

SecRuleEngine DetectionOnly

send a harmless test request:

curl -k 'https://192.168.88.7/?id=3D1%27%20OR%20%271%27=3D%271'

tail -100 /var/log/coraza/audit.log

You should see CRS alerts associated with SQL injection.

Test XSS detection
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

curl -k 'https://192.168.88.7/?q=3D%3Cscript%3Ealert(1)%3C%2Fscript%3E'

tail -100 /var/log/coraza/audit.log

Again, in DetectionOnly mode the request isn't supposed to be blocked; you'=
re checking that CRS recognizes it.

Turn blocking on
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

nano /etc/coraza/coraza.conf

Change to

SecRuleEngine On

caddy validate \
 --config /etc/caddy/Caddyfile \
 --adapter caddyfile
=20
systemctl reload caddy

Now repeat the SQLi test.

Open https://192.168.88.7/?id=3D1%27%20OR%20%271%27=3D%271 in Google Chrome=
 web browser.

Access to 192.168.88.7 was denied
You don't have authorization to view this page.
HTTP ERROR 403

Automatically update OWASP CRS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

<EMPTY>

Create CRS update script
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

nano /usr/local/sbin/update-coraza-crs.sh

#!/bin/bash
set -euo pipefail

WORKDIR=3D"/var/tmp/coraza-crs-update"
INSTALLDIR=3D"/etc/coraza/crs"
BACKUPDIR=3D"/etc/coraza/crs-backup"

rm -rf "$WORKDIR"

git clone --depth 1 \
  https://github.com/coreruleset/coreruleset.git \
  "$WORKDIR"

# Preserve local CRS configuration
if [ -f "$INSTALLDIR/crs-setup.conf" ]; then
    cp "$INSTALLDIR/crs-setup.conf" \
       "$WORKDIR/crs-setup.conf"
else
    cp "$WORKDIR/crs-setup.conf.example" \
       "$WORKDIR/crs-setup.conf"
fi

# Backup existing CRS
rm -rf "$BACKUPDIR"
cp -a "$INSTALLDIR" "$BACKUPDIR"

# Install candidate rules
rm -rf "${INSTALLDIR}.new"
cp -a "$WORKDIR" "${INSTALLDIR}.new"

chown -R root:caddy "${INSTALLDIR}.new"
chmod -R g+rX "${INSTALLDIR}.new"

# Temporarily switch directories
mv "$INSTALLDIR" "${INSTALLDIR}.old"
mv "${INSTALLDIR}.new" "$INSTALLDIR"

# Validate complete Caddy/Coraza configuration
if /usr/bin/caddy validate \
    --config /etc/caddy/Caddyfile \
    --adapter caddyfile
then

    systemctl reload caddy

    rm -rf "${INSTALLDIR}.old"

    logger -t coraza-crs-update \
      "OWASP CRS successfully updated"

else

    logger -t coraza-crs-update \
      "CRS update FAILED validation; rolling back"

    rm -rf "$INSTALLDIR"
    mv "${INSTALLDIR}.old" "$INSTALLDIR"

    exit 1
fi

rm -rf "$WORKDIR"


Make executable:

chmod 750 /usr/local/sbin/update-coraza-crs.sh

Automate it with systemd
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Instead of cron, use a systemd timer.

nano /etc/systemd/system/coraza-crs-update.service

[Unit]
Description=3DUpdate OWASP Core Rule Set for Coraza

[Service]
Type=3Doneshot
ExecStart=3D/usr/local/sbin/update-coraza-crs.sh



nano /etc/systemd/system/coraza-crs-update.timer

[Unit]
Description=3DDaily OWASP CRS update check

[Timer]
OnCalendar=3D*-*-* 03:30:00
Persistent=3Dtrue
RandomizedDelaySec=3D30m

[Install]
WantedBy=3Dtimers.target


This checks approximately once per day around 03:30.


systemctl daemon-reload

systemctl enable --now coraza-crs-update.timer

systemctl list-timers | grep coraza

Test the updater manually first
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Do not wait until 03:30 for the first run.

systemctl start coraza-crs-update.service

systemctl status coraza-crs-update.service

journalctl \
  -u coraza-crs-update.service \
  -n 100 \
  --no-pager
 =20
=20
systemctl status caddy

Then access the website.

https://192.168.88.7 (Coraza WAF)

Automatic Debian security updates
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

You should also keep Debian patched.

apt install -y unattended-upgrades

dpkg-reconfigure unattended-upgrades

Select Yes.

systemctl status unattended-upgrades



That's all.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Republic of Singapore
27 Sep 2026 Sunday 1.00 am Singapore Time





